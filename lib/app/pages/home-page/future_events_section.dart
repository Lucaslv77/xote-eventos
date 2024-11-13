import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';
import '/app/pages/stores/evento_store.dart';
import '/app/data/http/http_client.dart';
import '/app/data/repositories/event_repository.dart';

class FutureEventsSection extends StatefulWidget {
  const FutureEventsSection({super.key});

  @override
  _FutureEventsSectionState createState() => _FutureEventsSectionState();
}

class _FutureEventsSectionState extends State<FutureEventsSection> {
  late final EventoStore _eventoStore;
  final Set<int> _favoriteIndices = {};
  int _visibleItemCount = 2;

  @override
  void initState() {
    super.initState();
    final httpClient = HttpClient();
    final repository = EventRepository(client: httpClient);
    _eventoStore = EventoStore(repository: repository, client: httpClient);
    _fetchFutureEvents();
  }

  Future<void> _fetchFutureEvents() async {
    await _eventoStore.getEventosByDateDesc();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
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
                    _fetchFutureEvents(); // Tentar novamente
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
                'Eventos Futuros',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: (_visibleItemCount < eventos.length)
                      ? _visibleItemCount + 1
                      : eventos.length,
                  itemBuilder: (context, index) {
                    if (index == _visibleItemCount) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            _visibleItemCount =
                                (_visibleItemCount + 2).clamp(0, eventos.length);
                          });
                        },
                        child: const Text(
                          'Ver Mais',
                          style: TextStyle(color: Colors.blue),
                        ),
                      );
                    }

                    final event = eventos[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: const Color(0xFF000D1F),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                event.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.grey, // Placeholder em caso de erro
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Data: ${event.formattedDate}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'Hora: ${event.time}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  const Text(
                                    'Clique para mais detalhes',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _favoriteIndices.contains(index)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _favoriteIndices.contains(index)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_favoriteIndices.contains(index)) {
                                        _favoriteIndices.remove(index);
                                        _showSnackBar('Evento removido dos favoritos');
                                      } else {
                                        _favoriteIndices.add(index);
                                        _showSnackBar('Evento adicionado aos favoritos');
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                Text(
                                  event.pay ? 'Pago' : 'Gratuito',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: event.pay ? Colors.red : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
