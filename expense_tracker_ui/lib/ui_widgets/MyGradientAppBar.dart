import 'package:flutter/material.dart';

class MyGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  const MyGradientAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
