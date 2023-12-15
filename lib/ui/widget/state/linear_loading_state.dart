import 'package:flutter/material.dart';

class LinearLoadingState extends StatelessWidget {
  const LinearLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return LinearProgressIndicator(
        backgroundColor: primary.withOpacity(0.3), color: primary);
  }
}
