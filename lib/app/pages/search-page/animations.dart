import 'package:flutter/material.dart';
import '/app/data/models/event_model.dart';
import '/app/pages/search-page/event_card.dart';

Widget buildAnimatedEventList({
  required List<EventModel> visibleEvents,
  required GlobalKey<AnimatedListState> listKey,
}) {
  return AnimatedList(
    key: listKey,
    initialItemCount: visibleEvents.length,
    itemBuilder: (context, index, animation) {
      // Verifica se o índice está dentro do intervalo válido da lista
      if (index >= visibleEvents.length) {
        return const SizedBox.shrink(); // Retorna um widget vazio caso o índice seja inválido
      }

      final event = visibleEvents[index];

      // Adicionando um atraso no card
      final delay = Duration(milliseconds: 200 * index);

      return SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
            .animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  delay.inMilliseconds / 2000.0,
                  1.0,
                  curve: Curves.easeInOut,
                ),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: EventCard(event: event),
        ),
      );
    },
  );
}
