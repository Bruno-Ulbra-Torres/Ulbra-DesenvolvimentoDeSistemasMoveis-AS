import 'package:avaliacao_as/firebase/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseService{

  static Future<void> initialize() async{

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /** await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);*/

  }

  static Future<bool> validaSeEmailEstaEmUso(email) async {
    final signInMethods =
    await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (signInMethods.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}