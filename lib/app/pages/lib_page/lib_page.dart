import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '/app/pages/detail-page/event_detail_page.dart';
import '/app/pages/stores/evento_store.dart';
import '/app/widgets/CustomErrorWidget.dart';
import '../../widgets/LoadingWidget.dart';

class LibPage extends StatefulWidget {
  const LibPage({super.key});

  @override
  _LibPageState createState() => _LibPageState();
}

class _LibPageState extends State<LibPage> {
  @override
  void initState() {
    super.initState();
    // Chama o método para obter os eventos favoritos uma única vez
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Obtém os eventos favoritos
      context.read<EventoStore>().getFavoritos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF02142F), // Cor de fundo da página
      appBar: AppBar(
        backgroundColor: const Color(0xFF000D1F), // Cor de fundo do AppBar
        title: const Text(
          'Meus Eventos Favoritos', 
          style: TextStyle(color: Colors.white),
        ),
        // Não precisa do ícone de fechar ou voltar se a página é principal
      ),
      body: Consumer<EventoStore>(
        builder: (context, store, child) {
          // Exibe indicador de carregamento enquanto busca os dados
          if (store.isLoading.value) {
            return const LoadingWidget(); // Exibe o widget de carregamento
          }

          // Exibe um erro, caso haja
          if (store.erro.value.isNotEmpty) {
            return CustomErrorWidget(errorMessage: store.erro.value);
          }

          // Exibe os eventos favoritos em cards
          final eventosFavoritos = store.state.value;

          return ListView.builder(
            itemCount: eventosFavoritos.length,
            itemBuilder: (context, index) {
              final evento = eventosFavoritos[index];

              // Formatação da data para string
              String formattedDate = DateFormat('dd/MM/yyyy').format(evento.date); // Formata a data para o formato desejado

              return GestureDetector(
                onTap: () {
                  // Ação ao clicar no card (redireciona para a página de detalhes)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailPage(event: evento), // Passando o evento para a página de detalhes
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: const Color(0xFF000D1F), // Cor do card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 10, // Aumenta a sombra para destacar o card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagem no topo do card
                      evento.imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                              ),
                              child: Image.network(
                                evento.imageUrl,
                                width: double.infinity,
                                height: 200, // Definido para ocupar toda a parte superior
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              color: Colors.grey[300],
                              width: double.infinity,
                              height: 200,
                              child: const Icon(Icons.event, color: Colors.white),
                            ),
                      
                      // Informações abaixo da imagem
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          evento.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Legenda "Localização"
                            const Text(
                              "Localização:",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${evento.local}, ${evento.city}",
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Legenda "Data"
                            const Text(
                              "Data:",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedDate, // Exibindo a data formatada
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Status de pagamento com ícones
                            Row(
                              children: [
                                Icon(
                                  evento.pay ? Icons.payment : Icons.free_cancellation,
                                  color: evento.pay ? Colors.red : Colors.green,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  evento.pay ? "Pago" : "Gratuito",
                                  style: TextStyle(
                                    color: evento.pay ? Colors.red : Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Texto explicativo para clique
                            const Text(
                              "Clique para mais detalhes",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
