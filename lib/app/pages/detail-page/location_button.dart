import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';

class LocationButton extends StatelessWidget {
  final EventModel event;
  final bool isLoading;
  final Future<void> Function(String url) launchURL;

  const LocationButton({
    super.key,
    required this.event,
    required this.isLoading,
    required this.launchURL,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : () => launchURL(event.localGoogleUrl),
      icon: const Icon(Icons.location_on, color: Colors.white),
      label: const Text('Ver Localização', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1F2A38),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
