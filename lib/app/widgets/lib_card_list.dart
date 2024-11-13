import 'package:flutter/material.dart';
import 'lib_card.dart';

class LibCardList extends StatelessWidget {
  final List<Map<String, String>> libs;

  const LibCardList({super.key, required this.libs});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: libs.map((lib) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: LibCard(
              image: lib['image']!,
              libName: lib['libName']!,
              authorName: lib['authorName']!,
            ),
          );
        }).toList(),
      ),
    );
  }
}
