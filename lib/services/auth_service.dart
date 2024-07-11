import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Add Firestore instance

  // Register a new user
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        // Update Firestore with user data
        await addOrUpdateUserData(user);
      }
      return user;
    } catch (e) {
      print('Error during registration: $e');
      return null;
    }
  }

  // Sign in an existing user with email and password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        // Ensure user data is up-to-date
        await addOrUpdateUserData(user);
      }
      return user;
    } catch (e) {
      print('Error during sign-in: $e');
      return null;
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        await addOrUpdateUserData(user);
      }
      return user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  // Function to add or update user data in Firestore
  Future<void> addOrUpdateUserData(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);

    // Set user data, including name and email
    await userDoc.set({
      'name': user.displayName ?? '',
      'email': user.email ?? '',
      'address': '',  // Default or empty until set by the user
      'phoneNumber': '',  // Default or empty until set by the user
    }, SetOptions(merge: true));  // Merge with existing document if it exists
  }

  // Send password reset email
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }
}
