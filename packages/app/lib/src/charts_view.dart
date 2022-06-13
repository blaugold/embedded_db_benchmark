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
        body: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: SafeArea(
                child: const TabBar(
                  tabs: [
                    Tab(text: 'Databases'),
                    Tab(text: 'Batch sizes'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: const TabBarView(
                children: [
                  _DatabasesCharts(),
                  _BatchSizeCharts(),
                ],
              ),
            ),
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
      for (final batchSizeValue in settingsController.enabledBatchSize) {
        yield _DatabaseChart(
          benchmark: benchmark.name,
          arguments: ParameterArguments((builder) {
            builder.add(batchSize, batchSizeValue);
          }),
          databaseProviders: settingsController.databaseProviders,
          operationsPerSecond: {
            for (final databaseProvider in settingsController.databaseProviders)
              databaseProvider: {
                for (final execution in Execution.values)
                  execution: _operationsPerSecond(
                    runController,
                    benchmark,
                    databaseProvider,
                    execution,
                    batchSizeValue,
                  ),
              },
          },
        );
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

  final Map<DatabaseProvider, Map<Execution, double?>> operationsPerSecond;

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
                      _buildBarChardRod(databaseProvider, Execution.sync),
                      _buildBarChardRod(databaseProvider, Execution.async),
                    ],
                    barsSpace: 0,
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

  BarChartRodData _buildBarChardRod(
    DatabaseProvider databaseProvider,
    Execution execution,
  ) =>
      BarChartRodData(
        toY: operationsPerSecond[databaseProvider]![execution] ?? 0,
        width: 10,
        color: _databaseProviderColor(databaseProvider, execution),
        borderRadius: BorderRadius.zero,
      );
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
        yield _BatchSizeChart(
          benchmark: benchmark.name,
          databaseProvider: databaseProvider,
          batchSizes: settingsController.enabledBatchSize,
          operationsPerSecond: {
            for (final batchSizeValue in settingsController.enabledBatchSize)
              batchSizeValue: {
                for (final execution in Execution.values)
                  execution: _operationsPerSecond(
                    runController,
                    benchmark,
                    databaseProvider,
                    execution,
                    batchSizeValue,
                  ),
              },
          },
        );
      }
    }
  }
}

class _BatchSizeChart extends StatelessWidget {
  const _BatchSizeChart({
    Key? key,
    required this.benchmark,
    required this.databaseProvider,
    required this.batchSizes,
    required this.operationsPerSecond,
  }) : super(key: key);

  final String benchmark;

  final DatabaseProvider databaseProvider;

  final List<int> batchSizes;

  final Map<int, Map<Execution, double?>> operationsPerSecond;

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
                        _buildBarChardRod(batchSize, Execution.sync),
                        _buildBarChardRod(batchSize, Execution.async),
                      ],
                      barsSpace: 0,
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

  BarChartRodData _buildBarChardRod(
    int batchSize,
    Execution execution,
  ) =>
      BarChartRodData(
        toY: operationsPerSecond[batchSize]![execution] ?? 0,
        width: 10,
        color: _databaseProviderColor(databaseProvider, execution),
        borderRadius: BorderRadius.zero,
      );
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('Left bar: sync execution; Right bar: async execution'),
              ],
            ),
          ),
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 342,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: children,
            ),
          ),
        ],
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

Color _databaseProviderColor(
  DatabaseProvider databaseProvider,
  Execution execution,
) {
  final color = databaseProviderColors[databaseProvider]!;
  switch (execution) {
    case Execution.sync:
      return color;
    case Execution.async:
      // return color;

      final hslColor = HSLColor.fromColor(color);
      return hslColor.withLightness(hslColor.lightness + .1).toColor();
  }
}

double? _operationsPerSecond(
  RunController runController,
  Benchmark benchmark,
  DatabaseProvider databaseProvider,
  Execution executionValue,
  int batchSizeValue,
) {
  final runConfiguration =
      runController.runnableRunConfigurations.where((runConfiguration) {
    final arguments = runConfiguration.arguments;
    return runConfiguration.benchmark == benchmark &&
        runConfiguration.databaseProvider == databaseProvider &&
        arguments.get(execution) == executionValue &&
        arguments.get(batchSize) == batchSizeValue;
  }).firstOrNull;

  if (runConfiguration != null) {
    return _benchmarkResult(runController, runConfiguration)
        ?.operationsPerSecond;
  }

  return null;
}
