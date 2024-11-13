import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obter o tamanho da tela

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xff282828),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagem de perfil
              CircleAvatar(
                radius: size.width * 0.2, 
                backgroundImage: const AssetImage('assets/images/lib2.jpeg'),
              ),
              const SizedBox(height: 16.0),

              // Nome do usuário
              Text(
                'Caio Vinicius', // Substitua pelo nome do usuário
                style: TextStyle(
                  fontSize: size.width * 0.06, // Fonte responsiva
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),

              // Email do usuário
              Text(
                'caio.vinicius@email.com', // Substitua pelo email do usuário
                style: TextStyle(
                  fontSize: size.width * 0.04, // Fonte responsiva
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24.0),

              // Estatísticas dos eventos
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatsCard('Eventos Criados', '12', size),
                  _buildStatsCard('Eventos Favoritos', '25', size),
                ],
              ),
              const SizedBox(height: 24.0),

              // Botão Editar Perfil
              ElevatedButton.icon(
                onPressed: () {
                  // Ação para editar perfil
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Editar Perfil',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff57607A),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Botão Logout
              ElevatedButton.icon(
                onPressed: () {
                  // Ação para logout
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2F3349),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xff121212),
    );
  }

  // Widget para exibir estatísticas do perfil
  Widget _buildStatsCard(String title, String value, Size size) {
    return Card(
      color: const Color(0xff2F3349),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.07, // Fonte responsiva
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.04, // Fonte responsiva
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
