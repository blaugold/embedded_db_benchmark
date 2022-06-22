import 'package:benchmark/benchmark.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/error_dialog.dart';
import 'component/parameter_arguments_description.dart';
import 'run_controller.dart';
import 'style.dart';

enum _PopupMenuItem {
  showNonRunnableConfigs,
  exportResults,
  importResults,
}

class RunConfigurationsView extends StatelessWidget {
  const RunConfigurationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final runController = context.watch<RunController>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: runController.resetResults,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset results',
          ),
          PopupMenuButton<_PopupMenuItem>(
            onSelected: (item) {
              switch (item) {
                case _PopupMenuItem.showNonRunnableConfigs:
                  runController.showAllRunConfigurations =
                      !runController.showAllRunConfigurations;
                  break;
                case _PopupMenuItem.exportResults:
                  runController.exportResults().onError((error, stackTrace) {
                    showErrorAlert(context, error, stackTrace);
                  });
                  break;
                case _PopupMenuItem.importResults:
                  runController.importResults().onError((error, stackTrace) {
                    showErrorAlert(context, error, stackTrace);
                  });
                  break;
              }
            },
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                value: _PopupMenuItem.showNonRunnableConfigs,
                checked: runController.showAllRunConfigurations,
                child: const Text('Show non-runnable configs'),
              ),
              PopupMenuItem(
                value: _PopupMenuItem.exportResults,
                child: const Text('Export results'),
              ),
              PopupMenuItem(
                value: _PopupMenuItem.importResults,
                child: const Text('Import results'),
              ),
            ],
          )
        ],
      ),
      body: const _RunConfigurationList(),
    );
  }
}

class _RunConfigurationList extends StatelessWidget {
  const _RunConfigurationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final runController = context.watch<RunController>();
    final runConfigurations = runController.visibleRunConfigurations;

    if (runConfigurations.isEmpty) {
      return _NoRunConfigurationsView();
    }

    return ListView.separated(
      primary: false,
      padding: fabClearancePadding,
      itemBuilder: (context, i) {
        final runConfiguration = runConfigurations[i];
        final results = runController.getResults(runConfiguration);
        final isCurrent =
            runConfiguration == runController.currentConfiguration;

        if (isCurrent) {
          return ValueListenableBuilder<int?>(
            valueListenable: runController.progress,
            builder: (context, progress, _) => _RunConfigurationView(
              runConfiguration: runConfiguration,
              results: results,
              lifecycle: runController.lifecycle,
              isWarmUp: runController.isWarmUp,
              progress: progress,
            ),
          );
        } else {
          return _RunConfigurationView(
            runConfiguration: runConfiguration,
            results: results,
          );
        }
      },
      itemCount: runConfigurations.length,
      separatorBuilder: (context, i) => const Divider(height: 0),
    );
  }
}

class _NoRunConfigurationsView extends StatelessWidget {
  const _NoRunConfigurationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('No run configurations.'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                context
                    .read<RunController>()
                    .importResults()
                    .onError((error, stackTrace) {
                  showErrorAlert(context, error, stackTrace);
                });
              },
              child: Text('Import results'),
            )
          ],
        ),
      ),
    );
  }
}

class _RunConfigurationView extends StatefulWidget {
  const _RunConfigurationView({
    Key? key,
    required this.runConfiguration,
    required this.results,
    this.lifecycle,
    this.isWarmUp,
    this.progress,
  }) : super(key: key);

  final BenchmarkRunConfiguration runConfiguration;
  final List<Object> results;
  final BenchmarkRunnerLifecycle? lifecycle;
  final bool? isWarmUp;
  final int? progress;

  @override
  State<_RunConfigurationView> createState() => _RunConfigurationViewState();
}

class _RunConfigurationViewState extends State<_RunConfigurationView> {
  bool _isRunning = false;

  @override
  void didUpdateWidget(covariant _RunConfigurationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isRunning = widget.lifecycle != null;
    if (isRunning != _isRunning) {
      _isRunning = isRunning;
      if (_isRunning) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 200),
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lastResult = widget.results.lastOrNull;

    IconData iconData;
    Color iconColor;
    Widget? state;

    if (widget.lifecycle != null) {
      iconData = Icons.autorenew;
      iconColor = Colors.grey;
      state = _progress(context);
    } else if (lastResult is BenchmarkResult) {
      iconData = Icons.check;
      iconColor = Colors.green;
      state = _resultTable(context, lastResult);
    } else if (lastResult is BenchmarkThrewException) {
      iconData = Icons.close;
      iconColor = Colors.red;
      // TODO: show the exception
    } else {
      iconData = Icons.circle;
      iconColor = Colors.grey;
    }

    final icon = Icon(
      iconData,
      color: iconColor,
    );

    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _runConfigurationInfo(),
                  if (state != null) ...[
                    const SizedBox(height: 8),
                    state,
                  ]
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: !widget.runConfiguration.isRunnable || _isRunning
                ? null
                : () {
                    final runController = context.read<RunController>();
                    if (runController.isRunning) {
                      return;
                    } else {
                      runController.runConfiguration(widget.runConfiguration);
                    }
                  },
            icon: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }

  Column _runConfigurationInfo() {
    final arguments = widget.runConfiguration.arguments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.runConfiguration.databaseProvider.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(widget.runConfiguration.benchmark.name),
          ],
        ),
        ParameterArgumentsDescription(arguments: arguments),
      ],
    );
  }

  Widget _progress(BuildContext context) {
    const lifecycleLabels = {
      BenchmarkRunnerLifecycle.created: 'Created',
      BenchmarkRunnerLifecycle.setup: 'Setup',
      BenchmarkRunnerLifecycle.validateDatabase: 'Validate database',
      BenchmarkRunnerLifecycle.warmUp: 'Warm up',
      BenchmarkRunnerLifecycle.run: 'Run',
      BenchmarkRunnerLifecycle.teardown: 'Teardown',
      BenchmarkRunnerLifecycle.done: 'Done',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Chip(label: Text(lifecycleLabels[widget.lifecycle!]!)),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: widget.lifecycle == BenchmarkRunnerLifecycle.warmUp ||
                  widget.lifecycle == BenchmarkRunnerLifecycle.run
              ? (widget.progress! / 100)
              : null,
        )
      ],
    );
  }

  Widget _resultTable(BuildContext context, BenchmarkResult result) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(100),
        2: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            const Text('Ops'),
            Text(
              result.operations.toString(),
              textAlign: TextAlign.end,
            ),
            Container(),
          ],
        ),
        TableRow(
          children: [
            const Text('Ops/s'),
            Text(
              result.operationsPerSecond.floor().toString(),
              textAlign: TextAlign.end,
            ),
            Container(),
          ],
        ),
        TableRow(
          children: [
            const Text('Time'),
            Text(
              (result.operationsRunTime.inMicroseconds / 10e5)
                  .toStringAsFixed(3),
              textAlign: TextAlign.end,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text('s'),
            ),
          ],
        ),
        TableRow(
          children: [
            const Text('Time/Op'),
            Text(
              (result.timePerOperationInMicroseconds.ceil()).toString(),
              textAlign: TextAlign.end,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text('μs'),
            ),
          ],
        ),
      ],
    );
  }
}
