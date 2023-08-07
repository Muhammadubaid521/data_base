import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null) {
                    return 'Please Enter Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please a valid Email';
                  } else if (value.trim().isEmpty) {
                    return 'Please Enter Email';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintText: "email",
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null) {
                    return 'Please a Enter Password';
                  } else if (value.trim().isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintText: "password",
                  filled: true,
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      backgroundColor: const Color(0xff007074)),
                  onPressed: () async {
                    bool isFormValid = formKey.currentState!.validate();
                    if (!isFormValid) {
                      return;
                    }
                    List<Map<String, dynamic>> items =
                        await DatabaseHelper.get();

                    for (var a in items) {
                      if (a["email"] == emailController.text &&
                          a["password"] == passwordController.text) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                      }
                    }

                    setState(() {
                      print("obj $items");
                    });
                  },
                  child: const Text(
                    'login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              InkWell(
                  onTap: () async {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  },
                  child: const Text('signup')),
            ],
          ),
        )),
      ),
    );
  }
}
