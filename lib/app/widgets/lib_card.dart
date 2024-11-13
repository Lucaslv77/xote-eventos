import 'package:flutter/material.dart';

class LibCard extends StatelessWidget {
  final String image;
  final String libName; 
  final String authorName; 

  const LibCard({
    required this.image,
    required this.libName,
    required this.authorName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130.0,
          height: 130.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        const SizedBox(height: 8.0), 
        Text(
          'Evento: $libName', 
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Text(
          'Detalhes: $authorName', 
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
          ),
        )
      ],
    );
  }
}
