import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_market/home/Home.dart';
import 'package:i_market/services/auth_service.dart'; // Import AuthService

class LoginForm extends StatelessWidget {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      User? user = await _authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      _showErrorDialog(context, 'Failed with error code: ${e.toString()}');
    }
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      User? user = await _authService.signInWithGoogle(); // Add signInWithGoogle in AuthService
      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      _showErrorDialog(context, 'Error during Google sign-in: ${e.toString()}');
    }
  }

  Future<void> _resetPassword(BuildContext context) async {
    final String email = _emailController.text;
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address.')),
      );
      return;
    }
    try {
      await _authService.resetPassword(email); // Add resetPassword in AuthService
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
    } catch (e) {
      _showErrorDialog(context, 'Error sending password reset email: ${e.toString()}');
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
          controller: _emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            labelText: 'Email Address',
            border: OutlineInputBorder(),
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
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => _resetPassword(context),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Colors.pink),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _login(context),
          child: const Text('Login'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => _loginWithGoogle(context),
          icon: Image.asset(
            'assets/images/google.png',
            height: 24,
          ),
          label: const Text('Login with Google'),
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
