import 'package:data_base/database/database_helper.dart';
import 'package:data_base/pages/login_page.dart';
import 'package:flutter/material.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null) {
                    return 'Please Enter Name';
                  } else if (value.trim().isEmpty) {
                    return 'Please Enter Name';
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
                  hintText: "name",
                  filled: true,
                ),
              ),
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
                  hintText: "Enter your Email here",
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      backgroundColor: const Color(0xff007074)),
                  onPressed: () async {
                    bool isFormValid = _formKey.currentState!.validate();
                    if (!isFormValid) {
                      return;
                    }
                    DatabaseHelper.save(nameController.text,
                        emailController.text, passwordController.text);
                    //
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                      //
                    ));
                    List<Map<String, dynamic>> get = await DatabaseHelper.get();

                    setState(() {
                      print("get $get");
                    });
                  },
                  child: const Text(
                    'create account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: const Text('login')),
            ],
          ),
        )),
      ),
    );
  }
}
