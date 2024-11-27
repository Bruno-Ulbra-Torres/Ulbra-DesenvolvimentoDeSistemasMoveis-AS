import 'package:flutter/material.dart';

class IconButtonWithText extends StatefulWidget {
  final VoidCallback? action;
  final String text;
  final IconData icon;

  const IconButtonWithText({
    super.key,
    required this.action,
    required this.text,
    required this.icon,
  });

  @override
  State<IconButtonWithText> createState() => _IconButtonWithTextState();
}

class _IconButtonWithTextState extends State<IconButtonWithText> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color(0xff111111),
          ),
          shape: WidgetStatePropertyAll(
            BeveledRectangleBorder(),
          ),
        ),
        onPressed: widget.action,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon),
            Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ));
  }
}
