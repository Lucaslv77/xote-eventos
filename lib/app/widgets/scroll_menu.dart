import 'package:flutter/material.dart';

class ScrollMenu extends StatelessWidget {
  final List<String> menuItems;
  final List<Widget> pages;
  final List<IconData> icons; 

  const ScrollMenu({
    super.key,
    required this.menuItems,
    required this.pages,
    required this.icons, 
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(menuItems.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF000D1F),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 30, 
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0), 
                  Text(
                    menuItems[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
