import 'package:flutter/material.dart';

class H2 extends StatelessWidget {
  final String label;

  const H2(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.white,
      ),
    );
  }
}
