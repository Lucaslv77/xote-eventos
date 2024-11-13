import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';
import '/app/pages/detail-page/event_detail_page.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Determina a cor do cifrão com base no valor de 'pay'
    Color payColor = event.pay ? Colors.red : Colors.green;

    // Estilos reutilizáveis
    const TextStyle greyTextStyle = TextStyle(color: Colors.grey);
    const TextStyle titleTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
    const TextStyle detailTextStyle = TextStyle(color: Colors.blue, fontWeight: FontWeight.w600);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailPage(event: event)),
        );
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFF000D1F),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Row(
                children: [
                  // Imagem do evento com tratamento de erro
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      imageUrl: event.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: titleTextStyle),
                        Text('Data: ${event.formattedDate}', style: greyTextStyle),
                        Text('Local: ${event.local}', style: greyTextStyle),
                        Text('Cidade: ${event.city}', style: greyTextStyle),
                        const SizedBox(height: 8),
                        const Text('Clique para mais detalhes', style: detailTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 8,
                right: 16,
                child: Text(
                  '\$', // Símbolo de cifrão
                  style: TextStyle(
                    color: payColor,
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
