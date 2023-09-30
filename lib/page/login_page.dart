import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/page/register_page.dart';
import 'package:sociabile/provider/auth_provider.dart';
import 'package:sociabile/services/auth_services.dart';
import 'package:sociabile/widgets/custom_button.dart';

import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _loginUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      await _authService.logInUser(
          context: context, email: email, password: password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter email and password.')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // Wrap your Column in a SingleChildScrollView
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
                CustomButton(text: "Submit", onPressed: _loginUser),
                const SizedBox(
                  height: 30,
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
      ),
    );
  }
}
