import 'package:flutter/material.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({super.key});

  @override
  NotificationIconState createState() => NotificationIconState();
}

class NotificationIconState extends State<NotificationIcon> {
  List<String> notifications = [
    'Evento 1 está começando em breve!',
    'Evento 2 foi adicionado aos seus favoritos.',
    'Você tem novos eventos na sua área.',
  ];

  // Método para remover uma notificação individual
  void _removeNotification(int index, StateSetter setStateDialog) {
    setStateDialog(() {
      notifications.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notificação removida'),
      ),
    );
    // Atualiza o estado da tela principal (ícone de notificações)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // Exibe a caixa de notificações ao clicar
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color(0xFF57697A).withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: const Text(
                    'Notificações',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStateDialog) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: notifications.isEmpty
                            ? const Text(
                                'Nenhuma notificação',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      _removeNotification(index, setStateDialog);
                                    },
                                    background: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.centerRight,
                                      color: Colors.red,
                                      child: const Icon(Icons.delete, color: Colors.white),
                                    ),
                                    child: Card(
                                      color: const Color(0xFF2F3349),
                                      elevation: 3,
                                      margin: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        leading: const Icon(Icons.event, color: Colors.white),
                                        title: Text(
                                          notifications[index],
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.close, color: Colors.white),
                                          onPressed: () {
                                            _removeNotification(index, setStateDialog);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      );
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                      },
                      child: const Text('Fechar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                );
              },
            );
          },
        ),
        // Bolinha vermelha com contador de notificações
        if (notifications.isNotEmpty)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  '${notifications.length}',  // Atualiza o número de notificações
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
