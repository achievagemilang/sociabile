import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/page/register_page.dart';
import 'package:sociabile/provider/auth_provider.dart';
import 'package:sociabile/widgets/custom_button.dart';

import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthProvider controller;
  @override
  void initState() {
    super.initState();
    controller = Provider.of<AuthProvider>(context, listen: false);
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                      height: 80,
                    ),
                    CustomButton(text: "Submit", onPressed: () {}),
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
                    'Don’t have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        RegisterPage.routeName,
                      );
                    },
                    child: const Text(
                      'Register',
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
