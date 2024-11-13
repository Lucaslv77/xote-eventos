import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';

class EventImage extends StatelessWidget {
  final EventModel event;

  const EventImage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          event.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 250,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: const Center(
                child: Icon(Icons.error, color: Colors.white),
              ),
            );
          },
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
