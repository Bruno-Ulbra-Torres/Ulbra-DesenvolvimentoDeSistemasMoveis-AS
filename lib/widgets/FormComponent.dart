import 'package:avaliacao_as/screens/HomeScreen.dart';
import 'package:avaliacao_as/widgets/style_components/CustomInputDecoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormComponent extends StatefulWidget {
  final bool register;

  const FormComponent({
    super.key,
    this.register = false,
  });

  @override
  State<FormComponent> createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  //Attributes
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();

  final TextEditingController _emailRegisterController =
      TextEditingController();
  final TextEditingController _passwordRegisterController =
      TextEditingController();
  final TextEditingController _confirmPasswordRegisterController =
      TextEditingController();
  final TextEditingController _usernameRegisterController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureRegisterPassword = true;
  bool _obscureConfirmPassword = true;

  bool _isLoading = false;
  String? _errorMessage;

  // Methods

  void _loading() {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
  }

  void loginUserWithEmailAndPassword() async {
    _loading();
    if (_loginKey.currentState!.validate()) {
      print("Email $_emailLoginController");
      print("Email $_passwordLoginController");

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailLoginController.text,
          password: _passwordLoginController.text,
        );
        print("${FirebaseAuth.instance.currentUser}");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Suas credênciais estão inválidas!";
        });
        if (e.code == 'user-not-found') {
          print("Usuário não cadastrado");
        } else {
          print("Suas credencias estão incorretas");
        }
      } on Exception catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Aconteceu um erro";
        });
        print("Erro: ${e}");
      }
    }
    _isLoading = false;
  }

  void registerUser() async {
    _loading();
    if (_registerKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailRegisterController.text,
          password: _passwordRegisterController.text,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          print("Email já está em uso.");
          setState(() {
            _errorMessage = "Este email já está em uso.";
          });
        } else if (e.code == 'weak-password') {
          print("Senha muito fraca.");
          setState(() {
            _errorMessage =
                "A senha é muito fraca. Ela deve ser maior que 6 dígitos";
          });
        } else {
          setState(() {
            _errorMessage = "Um erro ocorreu";
          });
          print("Erro: ${e.message}");
        }
      } on Exception catch (e) {
        print(e);
      }
    }
    _isLoading = false;
  }

  String? validaEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite um email por favor!';
    } else {
      return null;
    }
  }

  String? validaSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha por favor!';
    } else {
      return null;
    }
  }

  // Build
  @override
  Widget build(BuildContext context) {
    if (widget.register) {
      return Form(
        key: _registerKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailRegisterController,
                      validator: validaEmail,
                      cursorColor: const Color(0xffEBB400),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: Custominputdecoration.build(
                        label: const Text("Email"),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordRegisterController,
                      validator: validaSenha,
                      obscureText: _obscureRegisterPassword,
                      cursorColor: const Color(0xffEBB400),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: Custominputdecoration.build(
                        label: const Text("Senha"),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureRegisterPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureRegisterPassword =
                              !(_obscureRegisterPassword);
                            });
                          },
                        ),

                      ),

                    ),
                    TextFormField(
                      controller: _confirmPasswordRegisterController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          _isLoading = false;
                          return 'As senhas não são iguais';
                        } else if (_passwordRegisterController.text != value) {
                          return 'As senhas não são iguais';
                        } else {
                          return null;
                        }
                      },
                      obscureText: _obscureConfirmPassword,
                      cursorColor: const Color(0xffEBB400),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: Custominputdecoration.build(
                        label: const Text("Confirme a senha"),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                              !(_obscureConfirmPassword);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: _isLoading
                  ? const SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: Color(0xffEBB400),
                      ),
                    )
                  : _errorMessage != null
                      ? Center(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xffEBB400),
                          ),
                        ),
                        onPressed: registerUser,
                        child: const Text(
                          "Cadastre-se",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Form(
        key: _loginKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailLoginController,
                cursorColor: const Color(0xffEBB400),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: Custominputdecoration.build(
                  label: const Text("Email"),
                ),
                validator: validaEmail,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: _passwordLoginController,
                  obscureText: _obscurePassword,
                  cursorColor: const Color(0xffEBB400),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: Custominputdecoration.build(
                    label: const Text("Senha"),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !(_obscurePassword);
                        });
                      },
                    ),
                  ),
                  validator: validaSenha,
                ),
              ),
              _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        height: 20,
                        child: _errorMessage != null
                            ? Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            : Container(),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xffEBB400),
                      ),
                    ),
                    onPressed: loginUserWithEmailAndPassword,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
