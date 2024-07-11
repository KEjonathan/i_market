import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_market/auth/login.dart';
import 'package:i_market/auth/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/iMarket.jpg'),
                  radius: 70,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ToggleButtons(
                  isSelected: [!isLogin, isLogin],
                  onPressed: (index) {
                    setState(() {
                      isLogin = index == 1;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isLogin ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isLogin ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              isLogin ? LoginForm() : RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
