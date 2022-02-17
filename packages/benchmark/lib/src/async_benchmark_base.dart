import 'package:benchmark_harness/benchmark_harness.dart';

class AsyncBenchmarkBase {
  final String name;
  final ScoreEmitter emitter;

  // Empty constructor.
  const AsyncBenchmarkBase(this.name, {this.emitter = const PrintEmitter()});

  // The benchmark code.
  // This function is not used, if both [warmup] and [exercise] are overwritten.
  Future<void> run() async {}

  // Runs a short version of the benchmark. By default invokes [run] once.
  Future<void> warmup() async {
    await run();
  }

  // Exercises the benchmark. By default invokes [run] 10 times.
  Future<void> exercise() async {
    for (var i = 0; i < 10; i++) {
      await run();
    }
  }

  // Not measured setup code executed prior to the benchmark runs.
  Future<void> setup() async {}

  // Not measures teardown code executed after the benchmark runs.
  Future<void> teardown() async {}

  // Measures the score for this benchmark by executing it repeatedly until
  // time minimum has been reached.
  static Future<double> measureFor(
    Future<void> Function() f,
    int minimumMillis,
  ) async {
    var minimumMicros = minimumMillis * 1000;
    var iter = 0;
    var watch = Stopwatch();
    watch.start();
    var elapsed = 0;
    while (elapsed < minimumMicros) {
      await f();
      elapsed = watch.elapsedMicroseconds;
      iter++;
    }
    return elapsed / iter;
  }

  // Measures the score for the benchmark and returns it.
  Future<double> measure() async {
    await setup();
    // Warmup for at least 100ms. Discard result.
    await measureFor(warmup, 100);
    // Run the benchmark for at least 2000ms.
    var result = await measureFor(exercise, 2000);
    await teardown();
    return result;
  }

  Future<void> report({int repeatsPerRun = 1}) async {
    emitter.emit(name, (await measure()) / repeatsPerRun);
  }
}
