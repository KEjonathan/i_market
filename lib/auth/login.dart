import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_market/home/Home.dart';
class LoginForm extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to home screen or show a success message
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {

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
            "Failed with error code: ${e.code}\n${e.message}",
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
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      // Navigate to home screen or show a success message
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      // Handle error
      print(e);
    }
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
            onPressed: () {
              // Implement forget password functionality
            },
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
            foregroundColor: Colors.white, backgroundColor: Colors.pink,
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
            foregroundColor: Colors.black, backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
