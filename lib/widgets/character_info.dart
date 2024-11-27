import 'package:flutter/material.dart';

class CharacterInfo extends StatelessWidget {
  final String label;
  final String info;

  const CharacterInfo({super.key, required this.label, required this.info});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xffEBB400)
          ),
        ),
        subtitle: Text(
          info,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
