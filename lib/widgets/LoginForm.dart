import 'package:avaliacao_as/screens/SingupScreen.dart';
import 'package:avaliacao_as/widgets/FormComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/HomeScreen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void loginComGoogle(BuildContext context) async {
    try {

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        print("User null");
        return;
      } else {

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false, // Remove todas as rotas anteriores
          );
        }
      }
    } catch (e) {
      // Em caso de erro, imprima a mensagem de erro
      print('Erro no login com Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FormComponent(),
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xffffffff),
                ),
              ),
              onPressed: (){loginComGoogle(context);},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Image.asset(
                      'assets/icons/google_icon.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      "Faça login com o Google",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(
          //   width: 200,
          //   height: 40,
          //   child: TextButton(
          //     onPressed: () {},
          //     child: const Text(
          //       "Esqueceu a senha?",
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0xff797979),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "ou",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xff797979),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Color(0xffEBB400),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Singupscreen(),
                ));
              },
              child: const Text(
                "Cadastre-se",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
