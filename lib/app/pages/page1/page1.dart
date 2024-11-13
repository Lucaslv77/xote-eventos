import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pag1'),
        backgroundColor: const Color(0xff282828),
      ),
      body: const Center(
        child: Text('Conteúdo da Pag1'),
      ),
    );
  }
}
