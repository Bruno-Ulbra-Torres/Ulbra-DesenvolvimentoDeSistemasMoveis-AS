import 'package:avaliacao_as/screens/LoginScreen.dart';
import 'package:avaliacao_as/widgets/IconButtonWithText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/list_builder.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? "Não logado";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // "Game of Thrones",
          email,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff111111),
        actions: [
          IconButtonWithText(
            text: "Logout",
            icon: Icons.logout,
            action: () async {
              final GoogleSignIn googleSignIn = GoogleSignIn();

              await googleSignIn.signOut();
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
    );
  }
}
