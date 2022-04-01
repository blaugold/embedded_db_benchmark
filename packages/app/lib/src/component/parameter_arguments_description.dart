import 'package:benchmark/benchmark.dart';
import 'package:flutter/material.dart';

class ParameterArgumentsDescription extends StatelessWidget {
  const ParameterArgumentsDescription({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final ParameterArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          executionTextSpan(arguments.get(execution)!),
          const TextSpan(text: ', batch size: '),
          TextSpan(
            text: batchSize.describe(arguments.get(batchSize)!),
          )
        ],
      ),
    );
  }
}

TextSpan executionTextSpan(Execution executionValue) => TextSpan(
      text: execution.describe(executionValue),
      style: TextStyle(
        color: executionValue == Execution.sync
            ? Colors.redAccent
            : Colors.blueAccent,
      ),
    );
