import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pag3'),
        backgroundColor: const Color(0xff282828),
      ),
      body: const Center(
        child: Text('Conteúdo da Pag3'),
      ),
    );
  }
}
