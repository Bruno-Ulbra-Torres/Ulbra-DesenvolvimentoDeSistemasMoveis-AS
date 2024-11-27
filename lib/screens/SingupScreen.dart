
import 'package:avaliacao_as/widgets/FormComponent.dart';
import 'package:flutter/material.dart';

class Singupscreen extends StatelessWidget {
  const Singupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),
      appBar: AppBar(
        backgroundColor: const Color(0xff111111),
        iconTheme: const IconThemeData(color: Color(0xffEBB400)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              height: 30,
              child: Image.asset('assets/tucano.png'),
            ),
          ),
        ],
      ),
      body: const FormComponent(register: true),
    );
  }
}
