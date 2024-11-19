import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xote_eventos/app/pages/search-page/event_card.dart';
import '/app/pages/stores/evento_store.dart';
import '../../widgets/customErrorWidget.dart';
import '../../widgets/LoadingWidget.dart';

class LibPage extends StatefulWidget {
  const LibPage({super.key});

  @override
  LibPageState createState() => LibPageState();
}

class LibPageState extends State<LibPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventoStore>().getFavoritos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF02142F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000D1F),
        title: const Text('Meus Eventos Favoritos', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<EventoStore>(
        builder: (context, store, child) {
          if (store.isLoading.value) {
            return const LoadingWidget(); // Carregamento de dados
          }
          
          if (store.erro.value.isNotEmpty) {
            return CustomErrorWidget(errorMessage: store.erro.value); 
          }

          final eventosFavoritos = store.state.value;
          
          if (eventosFavoritos.isEmpty) {
            return _buildEmptyState(); 
          }

          return _buildEventList(eventosFavoritos); 
        },
      ),
    );
  }

  // Função para construir o estado vazio (sem eventos)
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.white70),
          SizedBox(height: 20),
          Text(
            'Você ainda não tem eventos favoritos.',
            style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Adicione eventos aos seus favoritos para vê-los aqui.',
            style: TextStyle(color: Colors.white54, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Função para construir a lista de eventos favoritos
  Widget _buildEventList(List eventosFavoritos) {
    return ListView.builder(
      itemCount: eventosFavoritos.length,
      itemBuilder: (context, index) {
        final evento = eventosFavoritos[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: EventCard(event: evento), // Usando o EventCard
        );
      },
    );
  }
}
