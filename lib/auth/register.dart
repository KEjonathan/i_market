import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_market/home/Home.dart';
import 'package:i_market/services/auth_service.dart'; // Import AuthService

class RegisterForm extends StatelessWidget {
  final AuthService _authService = AuthService(); // Use AuthService
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    try {
      User? user = await _authService.registerWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        await user.updateProfile(displayName: _nameController.text);
        // Navigate to home screen or show a success message
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      _showErrorDialog(context, 'Failed with error code: ${e.toString()}');
    }
  }

  Future<void> _signUpWithGoogle(BuildContext context) async {
    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        // User display name is already updated by signInWithGoogle
        // Navigate to home screen or show a success message
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      _showErrorDialog(context, 'Error during Google sign-in: ${e.toString()}');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "iMarket Notice",
              style: TextStyle(color: Colors.pink, fontSize: 20),
            ),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person_2_outlined),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _signUp(context),
          child: const Text('Sign Up'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => _signUpWithGoogle(context),
          icon: Image.asset(
            'assets/images/google.png',
            height: 24,
          ),
          label: const Text('Sign up with Google'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
