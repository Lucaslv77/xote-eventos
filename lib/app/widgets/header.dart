import 'package:flutter/material.dart';
import 'package:xote_eventos/app/widgets/logo.dart';
import 'package:xote_eventos/app/widgets/notification_icon.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF000D1F),
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Logo(),  
            Spacer(),
            NotificationIcon(),  
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
