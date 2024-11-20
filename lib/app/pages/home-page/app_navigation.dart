import 'package:flutter/material.dart';

import '/app/pages/home-page/home_page.dart';
import '/app/pages/lib_page/lib_page.dart';
import '/app/pages/search-page/search_page.dart';
import '/app/pages/stores/evento_store.dart';
import '/app/data/repositories/event_repository.dart';
import '/app/data/http/http_client.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  late final EventoStore eventStore;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomePage(),
      const SearchPage(),
      const LibPage(),
    ];
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF000D1F),
        selectedItemColor: const Color(0xFFFFB854),
        unselectedItemColor: const Color.fromARGB(170, 203, 203, 203),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
