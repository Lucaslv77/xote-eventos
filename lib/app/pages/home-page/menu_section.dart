import 'package:flutter/material.dart';
import '/app/pages/page1/page1.dart';
import '/app/pages/page2/page2.dart';
import '/app/pages/page3/page3.dart';
import '/app/pages/page4/page4.dart';
import '/app/widgets/scroll_menu.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = ['Shows', 'Gastronomia', 'Cultura', 'Esportes'];
    final pages = [
      const Page1(),
      const Page2(),
      const Page3(),
      const Page4(),
    ];
    final icons = [
      Icons.music_note, // Ícone para Shows
      Icons.local_dining, // Ícone para Gastronomia
      Icons.theater_comedy, // Ícone para Cultura
      Icons.sports_soccer, // Ícone para Esportes
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ScrollMenu(
              menuItems: menuItems,
              pages: pages,
              icons: icons, // Passando a lista de ícones
            ),
          ),
        ],
      ),
    );
  }
}
