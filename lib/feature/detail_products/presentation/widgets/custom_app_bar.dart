import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? action;
  final double height;
  final SystemUiOverlayStyle colorStatusBar;
  const CustomAppBar({
    super.key,
    this.title,
    this.action,
    this.height = 60,
    this.colorStatusBar = SystemUiOverlayStyle.dark,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      systemOverlayStyle: colorStatusBar,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            Navigator.pop(context);
          },
          child: Ink(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFF292526),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title ?? '',
      ),
      actions: action,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, height);
}
