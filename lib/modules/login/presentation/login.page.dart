import 'package:flutter/material.dart';
import 'package:fudo_test/modules/home/presentation/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _userControllerTextEditing,
      _passwordControllerTextEditing;

  @override
  void initState() {
    super.initState();
    _userControllerTextEditing = TextEditingController();
    _passwordControllerTextEditing = TextEditingController();
  }

  bool _areCredentialsCorrect() {
    String user = _userControllerTextEditing.value.text;
    String password = _passwordControllerTextEditing.value.text;
    return user.isNotEmpty &&
        user == "challenge@fudo" &&
        password.isNotEmpty &&
        password == "password";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_areCredentialsCorrect()) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const HomeFudo();
            }));
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Usuario y/o contrasena incorrectos"),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: const Center(
            child: Text(
              "Log in",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _userControllerTextEditing,
                  decoration: InputDecoration(
                    hintText: "User",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: _passwordControllerTextEditing,
                  decoration: InputDecoration(
                    hintText: "User",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
