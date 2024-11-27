import 'package:flutter/material.dart';

import '../models/character.dart';
import '../screens/detail_screen.dart';

class CharacterListItemWidget extends StatelessWidget {
  final Character character;

  const CharacterListItemWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xffEBB400),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    character.image,
                    fit: BoxFit.cover,
                  ))),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.fullName,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                character.title,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              )
            ],
          ),
          trailing: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    character: character,
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Color(0xffEBB400),
            ),
          ),
        ),
      ),
    );
  }
}
