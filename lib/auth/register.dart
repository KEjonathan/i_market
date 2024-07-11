import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_market/home/Home.dart';
class RegisterForm extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await userCredential.user?.updateProfile(displayName: _nameController.text);
      // Navigate to home screen or show a success message
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    } on FirebaseAuthException catch (e) {
      // Handle error
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future<void> _signUpWithGoogle(BuildContext context) async {
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
      await userCredential.user?.updateProfile(displayName: googleUser.displayName);
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
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person_2_outlined)
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email Address',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email_outlined)
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock)
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _signUp(context),
          child: const Text('Sign Up'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.pink,
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
            foregroundColor: Colors.black, backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            side: const BorderSide(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
