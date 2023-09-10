import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/page/login_page.dart';
import 'package:sociabile/provider/auth_provider.dart';
import 'package:sociabile/widgets/custom_button.dart';

import '../widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthProvider controller;
  @override
  void initState() {
    super.initState();
    controller = Provider.of<AuthProvider>(context, listen: false);
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
  }

  bool validatePassword() {
    if (_passwordController.value == _passwordController2.value) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: GlobalVariables.backgroundColor,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/RISTEK.png',
                          height: 300,
                        ),
                      ),
                    ),
                    CustomTextfield(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: _passwordController,
                      hintText: 'Password*',
                      isPasswordField: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: _passwordController,
                      hintText: 'Confirm Password*',
                      isPasswordField: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                        text: "Submit",
                        onPressed: () {
                          if (validatePassword()) {}
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        LoginPage.routeName,
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
