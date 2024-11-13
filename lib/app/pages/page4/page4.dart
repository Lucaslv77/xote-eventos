import 'package:flutter/material.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pag4'),
        backgroundColor: const Color(0xff282828),
      ),
      body: const Center(
        child: Text('Conteúdo da Pag4'),
      ),
    );
  }
}
