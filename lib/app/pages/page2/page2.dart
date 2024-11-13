import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pag2'),
        backgroundColor: const Color(0xff282828),
      ),
      body: const Center(
        child: Text('Conteúdo da Pag2'),
      ),
    );
  }
}
