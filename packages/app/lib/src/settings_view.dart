import 'package:benchmark/benchmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'run_controller.dart';
import 'settings_controller.dart';
import 'style.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _batchSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final runController = context.watch<RunController>();
    final editable = !runController.isRunning;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        primary: false,
        padding: fabClearancePadding,
        children: [
          const _SectionLabel(label: 'Benchmarks'),
          for (final benchmark in allBenchmarks)
            CheckboxListTile(
              value: settingsController.benchmarks.contains(benchmark),
              onChanged: editable
                  ? (value) => settingsController.setBenchmarkEnabled(
                        benchmark,
                        isEnabled: value!,
                      )
                  : null,
              title: Text(benchmark.name),
            ),
          const Divider(),
          const _SectionLabel(label: 'Databases'),
          for (final databaseProvider in allDatabaseProviders)
            CheckboxListTile(
              value: settingsController.databaseProviders
                  .contains(databaseProvider),
              onChanged: editable &&
                      availableDatabaseProviders.contains(databaseProvider)
                  ? (value) => settingsController.setDatabaseProviderEnabled(
                        databaseProvider,
                        isEnabled: value!,
                      )
                  : null,
              title: Text(databaseProvider.name),
            ),
          const Divider(),
          const _SectionLabel(label: 'Execution'),
          for (final execution in Execution.values)
            CheckboxListTile(
              value: settingsController.executions.contains(execution),
              onChanged: editable
                  ? (value) => settingsController.setExecutionEnabled(
                        execution,
                        isEnabled: value!,
                      )
                  : null,
              title: Text(execution.name),
            ),
          const Divider(),
          const _SectionLabel(label: 'Batch sizes'),
          for (final batchSize in settingsController.batchSizes)
            Dismissible(
              key: Key(batchSize.toString()),
              confirmDismiss: (_) async => editable,
              onDismissed: (_) {
                settingsController.removeBatchSize(batchSize);
              },
              child: CheckboxListTile(
                title: Text('$batchSize'),
                value: settingsController.enabledBatchSize.contains(batchSize),
                onChanged: editable
                    ? (value) => settingsController.setBatchSizeEnabled(
                          batchSize,
                          isEnabled: value!,
                        )
                    : null,
              ),
            ),
          SafeArea(
            minimum: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _batchSizeController,
                    decoration: const InputDecoration(
                      labelText: 'Custom batch size',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[1-9]\d*')),
                    ],
                    onSubmitted: (value) {
                      settingsController.addBatchSize(int.parse(value));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: editable
                      ? () => settingsController
                          .addBatchSize(int.parse(_batchSizeController.text))
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
