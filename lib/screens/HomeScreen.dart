
import 'package:avaliacao_as/screens/LoginScreen.dart';
import 'package:avaliacao_as/widgets/IconButtonWithText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/list_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HomeScreen",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffEBB400))),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Game of Thrones", style: TextStyle(color: Colors.white),),
          backgroundColor: const Color(0xff111111),
          actions: [
            IconButtonWithText(
              text: "Logout",
              icon: Icons.logout,
              action: () async {

                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
            )
            ],
        ),
        body: const ListBuilder(),
      ),
    );
  }
}
