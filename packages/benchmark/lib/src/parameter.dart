import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

abstract class Parameter<T extends Object?> {
  const Parameter(this.name);

  final String name;

  Iterable<T>? get enumerableValues => null;

  bool isValidArgument(T value);

  Object? toJson(T value);

  T fromJson(Object? value);

  String describe(T value);
}

class EnumParameter<T extends Enum> extends Parameter<T> {
  EnumParameter(String name, this.enumerableValues)
      : assert(enumerableValues.isNotEmpty),
        super(name);

  @override
  final List<T> enumerableValues;

  @override
  bool isValidArgument(T value) => true;

  @override
  String toString() => 'EnumParameter($name, $enumerableValues)';

  @override
  Object? toJson(T value) => value.name;

  @override
  T fromJson(Object? value) =>
      enumerableValues.firstWhere((enumValue) => enumValue.name == value);

  @override
  String describe(T value) => value.name;
}

class NumericParameter<T extends num> extends Parameter<T> {
  NumericParameter(String name, {this.min, this.max}) : super(name);

  final T? min;
  final T? max;

  @override
  bool isValidArgument(T value) {
    final min = this.min;
    if (min != null && value < min) {
      return false;
    }
    final max = this.max;
    if (max != null && value > max) {
      return false;
    }
    return true;
  }

  @override
  String toString() => 'NumericParameter($name, min: $min, max: $max)';

  @override
  Object? toJson(T value) => value;

  @override
  T fromJson(Object? value) => value as T;

  @override
  String describe(T value) => value.toString();
}

abstract class ParameterRange<T extends Object?> {
  ParameterRange(this.parameter);

  factory ParameterRange.all(Parameter<T> parameter) {
    final values = parameter.enumerableValues;
    if (values == null || values.isEmpty) {
      throw ArgumentError('Parameter $parameter has no enumerable values.');
    }
    return ListParameterRange(parameter, values.toList());
  }

  factory ParameterRange.single(Parameter<T> parameter, T value) =>
      ListParameterRange(parameter, [value]);

  final Parameter<T> parameter;

  Iterable<T> get values;
}

class ListParameterRange<T extends Object?> extends ParameterRange<T> {
  ListParameterRange(Parameter<T> parameter, this.values)
      : assert(values.every(parameter.isValidArgument)),
        super(parameter);

  @override
  final List<T> values;

  @override
  String toString() => 'ListParameterRange(${parameter.name}, $values)';
}

extension ParameterRangeListExt on List<ParameterRange<Object?>> {
  Iterable<ParameterArguments> crossProduct() sync* {
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

    for (final values in generateValues(this)) {
      yield ParameterArguments._(Map.fromEntries(values));
    }
  }
}

class ParameterArgumentsBuilder {
  final _arguments = <Parameter, Object?>{};

  void add<T extends Object>(Parameter<T> parameter, T argument) {
    if (_arguments.containsKey(parameter)) {
      throw ArgumentError('Parameter $parameter already added.');
    }

    _arguments[parameter] = argument;
  }

  ParameterArguments build() =>
      ParameterArguments._(Map.unmodifiable(_arguments));
}

@immutable
class ParameterArguments {
  factory ParameterArguments(
    void Function(ParameterArgumentsBuilder) build,
  ) {
    final builder = ParameterArgumentsBuilder();
    build(builder);
    return builder.build();
  }

  const ParameterArguments._(this._arguments);

  final Map<Parameter, Object?> _arguments;

  T? get<T>(Parameter<T> parameter) {
    return _arguments[parameter] as T?;
  }

  bool contains(Parameter parameter) {
    return _arguments.containsKey(parameter);
  }

  List<Parameter> get parameters => _arguments.keys.toList();

  bool containsArguments(ParameterArguments other) =>
      other._arguments.keys.every(
        (parameter) =>
            _arguments.containsKey(parameter) &&
            _arguments[parameter] == other._arguments[parameter],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParameterArguments &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(_arguments, other._arguments);

  @override
  int get hashCode => const DeepCollectionEquality().hash(_arguments);

  @override
  String toString() {
    final sortedParameters = _arguments.keys.toList()
      ..sort(((a, b) => a.name.compareTo(b.name)));

    return [
      'ParameterArguments(',
      [
        for (final parameter in sortedParameters)
          '${parameter.name}: ${_arguments[parameter]}',
      ].join(', '),
      ')'
    ].join('');
  }

  Map<String, Object?> toJson() => {
        for (final parameter in _arguments.keys)
          parameter.name: parameter.toJson(_arguments[parameter]),
      };

  factory ParameterArguments.fromJson(
    Map<String, Object?> json, {
    required Map<String, Parameter> parameters,
  }) =>
      ParameterArguments._({
        for (final argument in json.entries)
          parameters[argument.key]!:
              parameters[argument.key]!.fromJson(argument.value),
      });
}

typedef ParameterArgumentsPredicate = bool Function(ParameterArguments);

ParameterArgumentsPredicate andPredicates(
  Iterable<ParameterArgumentsPredicate> predicates,
) =>
    (arguments) => predicates.every((predicate) => predicate(arguments));

ParameterArgumentsPredicate anyArgument(Parameter<Object?> parameter) =>
    (arguments) => arguments.contains(parameter);

ParameterArgumentsPredicate anyArgumentOf<T>(
  Parameter<T> parameter,
  Iterable<T> values,
) =>
    (arguments) {
      if (!arguments.contains(parameter)) {
        return false;
      }
      final argument = arguments.get(parameter)!;
      return values.contains(argument);
    };
