import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
