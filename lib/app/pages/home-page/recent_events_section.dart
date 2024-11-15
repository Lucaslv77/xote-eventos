import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';
import '/app/data/http/http_client.dart';
import '/app/data/repositories/event_repository.dart';
import '/app/pages/detail-page/event_detail_page.dart';
import '/app/pages/stores/evento_store.dart';

class RecentEventsSection extends StatefulWidget {
  const RecentEventsSection({super.key});

  @override
  RecentEventsSectionState createState() => RecentEventsSectionState();
}

class RecentEventsSectionState extends State<RecentEventsSection> {
  late final EventoStore _eventoStore;

  @override
  void initState() {
    super.initState();
    final httpClient = HttpClient();
    final repository = EventRepository(client: httpClient);
    _eventoStore = EventoStore(repository: repository, client: httpClient);
    _fetchRecentEvents();
  }

  Future<void> _fetchRecentEvents() async {
    await _eventoStore.getRecentEventos();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<EventModel>>(
      valueListenable: _eventoStore.state,
      builder: (context, eventos, _) {
        if (_eventoStore.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_eventoStore.erro.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_eventoStore.erro.value),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _fetchRecentEvents(); 
                  },
                  child: const Text('Tentar Novamente'),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mais Recentes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14.0),
              SizedBox(
                height: 200, 
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    final event = eventos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navegar para a página de detalhes
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailPage(event: event),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent, 
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    event.imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Container(
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    event.title,
                                    style: const TextStyle(
                                      color: Color(0xFFFFB854),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.white70,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        event.formattedDate,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: Colors.white70,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        event.time,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
