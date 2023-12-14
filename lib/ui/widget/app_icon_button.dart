import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, required this.onTap, required this.icon});

  final Function() onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: icon);
  }
}
