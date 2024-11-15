import 'package:flutter/material.dart';
import '/app/pages/home-page/home_page.dart';
import '/app/pages/lib_page/lib_page.dart';
import '/app/pages/search-page/search_page.dart';
import '/app/widgets/logo.dart';
import '/app/widgets/scroll_menu.dart';
import '/app/pages/stores/evento_store.dart'; // Importando o EventoStore

class HomeLogo extends StatelessWidget {
  const HomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Logo();
  }
}

class HomeScrollMenu extends StatelessWidget {
  final EventoStore eventStore; // Adicionando o parâmetro para o eventStore

  const HomeScrollMenu({super.key, required this.eventStore}); // Passando o eventStore para o construtor

  @override
  Widget build(BuildContext context) {
    return ScrollMenu(
      menuItems: const ['Home', 'Lib', 'Search'],
      pages: [
        HomePage(eventStore: eventStore), // Passando o eventStore para a HomePage
        const LibPage(),
        const SearchPage(),
      ],
      icons: const [], // Você pode adicionar ícones aqui se necessário
    );
  }
}
