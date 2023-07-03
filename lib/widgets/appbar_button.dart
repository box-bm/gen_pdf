import 'package:flutter/material.dart';

class AppbarButton extends StatelessWidget {
  final Function() onPressed;
  final bool active;
  final String label;
  const AppbarButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: active
            ? ButtonStyle(
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary))
            : null,
        onPressed: onPressed,
        child: Text(label));
  }
}
