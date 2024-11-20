import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:xote_eventos/app/pages/home-page/app_navigation.dart';
import 'package:xote_eventos/app/pages/stores/evento_store.dart';

void main() => const MyApp();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EventoStore(),
        )
      ],
      child: MaterialApp(
        title: 'XoteCariri',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppNavigation(),
        builder: (context, child) {
          return Stack(
            children: [
              child ?? const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
