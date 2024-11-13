import 'package:flutter/material.dart';

class H1 extends StatelessWidget {
  final String label;

  const H1(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        color: Colors.white,
      ),
    );
  }
}
