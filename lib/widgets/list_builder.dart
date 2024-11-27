import 'package:flutter/material.dart';

import '../models/character.dart';
import '../services/characters_services.dart';
import 'character_list_item_widget.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({super.key});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  late Future<List<Character>> listFuture;
  List<Character> list = List.empty();
  List<Character> listFilter = List.empty();

  @override
  void initState() {
    super.initState();
    listFuture = CharacterService().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (list.isEmpty) {
            list = snapshot.data ?? List.empty();
            listFilter = list;
          }
          return Container(
            color: const Color(0xff111111),
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        var filteredList = list
                            .where((character) => character.fullName
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        setState(() {
                          listFilter = filteredList;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelText: 'Busque a character',
                        labelStyle: TextStyle(
                          color: Color(0xffEBB400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEBB400),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEBB400),
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return CharacterListItemWidget(
                            character: listFilter[index]);
                      },
                      separatorBuilder: (_, __) {
                        return Container();
                      },
                      itemCount: listFilter.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Text("ops não foi possivel fazer a requisição");
        }
        return Container(
          color: const Color(0xff111111),
          child: const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xffEBB400),
              ),
            ),
          ),
        );
      },
    );
  }
}
