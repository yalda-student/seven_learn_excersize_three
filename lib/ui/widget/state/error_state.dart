import 'package:flutter/cupertino.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Text(errorMessage);
  }
}
