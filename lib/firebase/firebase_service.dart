import 'package:avaliacao_as/firebase/firebase_options.dart';
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
}