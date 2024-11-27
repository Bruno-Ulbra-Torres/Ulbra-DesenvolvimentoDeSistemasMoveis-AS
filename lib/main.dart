import 'package:avaliacao_as/firebase/firebase_service.dart';
import 'package:avaliacao_as/screens/HomeScreen.dart';
import 'package:avaliacao_as/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {

  await FirebaseService.initialize();

  User? currentUser = FirebaseAuth.instance.currentUser;

  runApp(MyApp(
    user: currentUser,
    isAuthenticated: currentUser != null,
  ));

}

class MyApp extends StatelessWidget {

  User? user;
  bool isAuthenticated;

  MyApp({
    super.key,
    required this.user,
    required this.isAuthenticated,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffEBB400)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginScreen(),
      },
    );
  }
}

