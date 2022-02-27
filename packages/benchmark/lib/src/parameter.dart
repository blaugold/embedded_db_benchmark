import 'utils.dart';

abstract class Parameter<T> {
  Parameter(this.name);

  final String name;

  Iterable<T> get values;

  bool isValidValue(T value);
}

class EnumParameter<T extends Enum> extends Parameter<T> {
  EnumParameter(this.values)
      : assert(values.isNotEmpty),
        super(values.first.runtimeType.toString().kebabCase);

  @override
  final List<T> values;

  @override
  bool isValidValue(T value) => true;

  @override
  String toString() => 'EnumParameter($name, $values)';
}

class FlagParameter extends Parameter<bool> {
  FlagParameter(String name) : super(name);

  @override
  Iterable<bool> get values => const <bool>[true, false];

  @override
  bool isValidValue(bool value) => true;

  @override
  String toString() => 'FlagParameter($name)';
}

abstract class ParameterRange<T> {
  ParameterRange(this.parameter);

  factory ParameterRange.all(Parameter<T> parameter) =>
      ListParameterRange(parameter, parameter.values.toList());

  factory ParameterRange.single(Parameter<T> parameter, T value) =>
      ListParameterRange(parameter, [value]);

  final Parameter<T> parameter;

  Iterable<T> get values;
}

class ListParameterRange<T> extends ParameterRange<T> {
  ListParameterRange(Parameter<T> parameter, this.values)
      : assert(values.every(parameter.isValidValue)),
        super(parameter);

  @override
  final List<T> values;

  @override
  String toString() => 'ListParameterRange(${parameter.name}, $values)';
}

class ParameterCombinationBuilder {
  final _values = <Parameter, Object?>{};

  void add<T>(Parameter<T> parameter, T value) {
    if (_values.containsKey(parameter)) {
      throw ArgumentError('Parameter $parameter already added.');
    }

    _values[parameter] = value;
  }

  ParameterCombination build() =>
      ParameterCombination._(Map.unmodifiable(_values));
}

class ParameterCombination {
  factory ParameterCombination(
    void Function(ParameterCombinationBuilder) build,
  ) {
    final builder = ParameterCombinationBuilder();
    build(builder);
    return builder.build();
  }

  static Iterable<ParameterCombination> allCombinations(
    List<ParameterRange<Object?>> ranges,
  ) sync* {
    Iterable<List<MapEntry<Parameter, Object?>>> generateValues(
      List<ParameterRange> ranges,
    ) sync* {
      if (ranges.isEmpty) {
        yield [];
        return;
      }

      final firstRange = ranges.first;
      final restRanges = ranges.skip(1).toList();

      for (final value in firstRange.values) {
        for (final restValues in generateValues(restRanges)) {
          yield [MapEntry(firstRange.parameter, value), ...restValues];
        }
      }
    }

    for (final values in generateValues(ranges)) {
      yield ParameterCombination._(Map.fromEntries(values));
    }
  }

  ParameterCombination._(this._values);

  final Map<Parameter, Object?> _values;

  T? get<T>(Parameter<T> parameter) {
    return _values[parameter] as T?;
  }

  bool contains(Parameter parameter) {
    return _values.containsKey(parameter);
  }

  bool containsCombination(ParameterCombination combination) =>
      combination._values.keys.every(
        (parameter) =>
            _values.containsKey(parameter) &&
            _values[parameter] == combination._values[parameter],
      );

  @override
  String toString() {
    final sortedParameters = _values.keys.toList()
      ..sort(((a, b) => a.name.compareTo(b.name)));

    return [
      'ParameterCombination(',
      [
        for (final parameter in sortedParameters)
          '${parameter.name}: ${_values[parameter]}',
      ].join(', '),
      ')'
    ].join('');
  }
}
