import 'dart:math';

import 'package:benchmark/benchmark.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/parameter_arguments_description.dart';
import 'run_controller.dart';
import 'settings_controller.dart';

class ChartsView extends StatelessWidget {
  const ChartsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Databases'),
              Tab(text: 'Batch sizes'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _DatabasesCharts(),
            _BatchSizeCharts(),
          ],
        ),
      ),
    );
  }
}

class _DatabasesCharts extends StatelessWidget {
  const _DatabasesCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final runController = context.watch<RunController>();

    return _ChartsGrid(
      children: _buildCharts(settingsController, runController).toList(),
    );
  }

  Iterable<Widget> _buildCharts(
    SettingsController settingsController,
    RunController runController,
  ) sync* {
    for (final benchmark in settingsController.benchmarks) {
      for (final executionValue in settingsController.executions) {
        for (final batchSizeValue in settingsController.batchSizes) {
          final runConfigurations =
              runController.runnableRunConfigurations.where((runConfiguration) {
            final arguments = runConfiguration.arguments;
            return runConfiguration.benchmark == benchmark &&
                arguments.get(execution) == executionValue &&
                arguments.get(batchSize) == batchSizeValue;
          }).toList();

          if (runConfigurations.isEmpty) {
            continue;
          }

          yield _DatabaseChart(
            benchmark: benchmark.name,
            arguments: runConfigurations.first.arguments,
            databaseProviders: settingsController.databaseProviders,
            operationsPerSecond: {
              for (final runConfiguration in runConfigurations)
                runConfiguration.databaseProvider:
                    _benchmarkResult(runController, runConfiguration)
                        ?.operationsPerSecond,
            },
          );
        }
      }
    }
  }
}

class _DatabaseChart extends StatelessWidget {
  const _DatabaseChart({
    Key? key,
    required this.benchmark,
    required this.arguments,
    required this.databaseProviders,
    required this.operationsPerSecond,
  }) : super(key: key);

  final String benchmark;

  final ParameterArguments arguments;

  final List<DatabaseProvider> databaseProviders;

  final Map<DatabaseProvider, double?> operationsPerSecond;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            benchmark,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          ParameterArgumentsDescription(arguments: arguments),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: _operationsAxisTitles(),
                  bottomTitles: _categoryAxisTitles(
                    reservedSize: 74,
                    title: (value) => databaseProviders[value.toInt()].name,
                  ),
                ),
                gridData: _flGridData(context),
                borderData: _flBorderData(context),
                barGroups: List.generate(databaseProviders.length, (index) {
                  final databaseProvider = databaseProviders[index];
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: operationsPerSecond[databaseProvider] ?? 0,
                        width: 30,
                        color: databaseProviderColors[databaseProvider]!,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  );
                }),
                barTouchData: _barTouchData(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BatchSizeCharts extends StatelessWidget {
  const _BatchSizeCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final runController = context.watch<RunController>();

    return _ChartsGrid(
      children: _buildCharts(settingsController, runController).toList(),
    );
  }

  Iterable<Widget> _buildCharts(
    SettingsController settingsController,
    RunController runController,
  ) sync* {
    for (final databaseProvider in settingsController.databaseProviders) {
      for (final benchmark in settingsController.benchmarks) {
        for (final executionValue in settingsController.executions) {
          final runConfigurations =
              runController.runnableRunConfigurations.where((runConfiguration) {
            final arguments = runConfiguration.arguments;
            return runConfiguration.benchmark == benchmark &&
                runConfiguration.databaseProvider == databaseProvider &&
                arguments.get(execution) == executionValue;
          }).toList();

          if (runConfigurations.isEmpty) {
            continue;
          }

          yield _BatchSizeChart(
            benchmark: benchmark.name,
            execution: executionValue,
            databaseProvider: databaseProvider,
            batchSizes: settingsController.enabledBatchSize,
            operationsPerSecond: {
              for (final runConfiguration in runConfigurations)
                runConfiguration.arguments.get(batchSize)!:
                    _benchmarkResult(runController, runConfiguration)
                        ?.operationsPerSecond,
            },
          );
        }
      }
    }
  }
}

class _BatchSizeChart extends StatelessWidget {
  const _BatchSizeChart({
    Key? key,
    required this.benchmark,
    required this.execution,
    required this.databaseProvider,
    required this.batchSizes,
    required this.operationsPerSecond,
  }) : super(key: key);

  final String benchmark;

  final Execution execution;

  final DatabaseProvider databaseProvider;

  final List<int> batchSizes;

  final Map<int, double?> operationsPerSecond;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${databaseProvider.name} - $benchmark',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text.rich(executionTextSpan(execution)),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: _operationsAxisTitles(),
                  bottomTitles: _categoryAxisTitles(
                    reservedSize: 74,
                    title: (value) => value.floor().toString(),
                  ),
                ),
                gridData: _flGridData(context),
                borderData: _flBorderData(context),
                barGroups: [
                  for (final batchSize in batchSizes)
                    BarChartGroupData(
                      x: batchSize,
                      barRods: [
                        BarChartRodData(
                          toY: operationsPerSecond[batchSize] ?? 0,
                          width: 30,
                          color: databaseProviderColors[databaseProvider]!,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                    )
                ],
                barTouchData: _barTouchData(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ChartsGrid extends StatelessWidget {
  const _ChartsGrid({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.extent(
        maxCrossAxisExtent: 342,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: children,
      ),
    );
  }
}

class _RotatedTitle extends StatelessWidget {
  const _RotatedTitle({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-.5, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Transform.rotate(
          angle: -pi / 4,
          alignment: Alignment.topRight,
          child: child,
        ),
      ),
    );
  }
}

AxisTitles _operationsAxisTitles() {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 40,
      getTitlesWidget: (double value, TitleMeta meta) {
        if (value == 0 || meta.max == value) {
          return Container();
        }

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            value < 1000
                ? value.floor().toString()
                : '${value.floor() ~/ 1000}k',
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        );
      },
    ),
  );
}

AxisTitles _categoryAxisTitles({
  required double reservedSize,
  required String Function(double value) title,
}) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: reservedSize,
      getTitlesWidget: (value, meta) => _RotatedTitle(
        child: Text(
          title(value),
          softWrap: false,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}

FlGridData _flGridData(BuildContext context) {
  return FlGridData(
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) => FlLine(
      strokeWidth: 1,
      color: Theme.of(context).dividerColor,
    ),
  );
}

FlBorderData _flBorderData(BuildContext context) {
  return FlBorderData(
    border: Border(
      bottom: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    ),
  );
}

BarTouchData _barTouchData() {
  return BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        return BarTooltipItem(
          rod.toY.floor().toString(),
          const TextStyle(fontSize: 12),
        );
      },
    ),
  );
}

BenchmarkResult? _benchmarkResult(
  RunController runController,
  BenchmarkRunConfiguration runConfiguration,
) {
  final lastResult = runController.getResults(runConfiguration).lastOrNull;
  if (lastResult == null) {
    return null;
  }
  if (lastResult is! BenchmarkResult) {
    return null;
  }
  return lastResult;
}
