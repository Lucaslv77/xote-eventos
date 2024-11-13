import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';
import '/app/pages/detail-page/event_image.dart';
import '/app/pages/detail-page/event_info.dart';
import '/app/pages/detail-page/location_button.dart';
import '/app/pages/detail-page/share_button.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool isLoading = false;

  // Método para abrir a URL usando o launchUrl
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    setState(() {
      isLoading = true;
    });

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o link: $url')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF02142F),
      appBar: AppBar(
        title: const Text('Evento', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF000D1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EventImage(event: widget.event),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.event.title,
                style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8.0),
            EventInfo(event: widget.event),
            const SizedBox(height: 16.0),
            _buildInfoCard('Tipo de Evento:', widget.event.type),
            const SizedBox(height: 8.0),
            _buildInfoCard(
              'Preço:',
              widget.event.pay ? 'R\$ ${widget.event.price.toStringAsFixed(2)}' : 'Gratuito',
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ShareButton(),
                  LocationButton(event: widget.event, isLoading: isLoading, launchURL: _launchURL),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      color: const Color(0xFF1F2A38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              '$title ',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(content, style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
