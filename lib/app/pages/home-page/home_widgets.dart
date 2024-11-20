import 'package:flutter/material.dart';
import '/app/pages/home-page/home_page.dart';
import '/app/pages/lib_page/lib_page.dart';
import '/app/pages/search-page/search_page.dart';
import '/app/widgets/logo.dart';
import '/app/widgets/scroll_menu.dart';
import '/app/pages/stores/evento_store.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Logo();
  }
}

class HomeScrollMenu extends StatelessWidget {
  final EventoStore eventStore;

  const HomeScrollMenu({super.key, required this.eventStore});

  @override
  Widget build(BuildContext context) {
    return const ScrollMenu(
      menuItems: ['Home', 'Lib', 'Search'],
      pages: [
        HomePage(),
        LibPage(),
        SearchPage(),
      ],
      icons: [],
    );
  }
}
