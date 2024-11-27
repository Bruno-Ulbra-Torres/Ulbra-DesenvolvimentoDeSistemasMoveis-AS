import 'package:flutter/material.dart';

import '../models/character.dart';
import '../widgets/character_info.dart';

class DetailScreen extends StatelessWidget {
  Character character;

  DetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "DetailScreen",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: const Color(0xff111111),
            leading: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Color(0xffEBB400),)),
            title: Text(
              character.fullName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: Container(color: const Color(0xffEBB400))),
                  Container(
                    color: const Color(0xff111111),
                    child: SizedBox(
                      height: 600,
                      width: 600,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 30, top: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                CharacterInfo(
                                    label: "First Name",
                                    info: character.firstName),
                                CharacterInfo(
                                    label: "Last Name",
                                    info: character.lastName),
                              ],
                            ),
                            Row(
                              children: [
                                CharacterInfo(
                                    label: "Family", info: character.family),
                                CharacterInfo(
                                    label: "Title", info: character.title),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
