import 'package:flutter/material.dart';
import 'package:i_market/auth/auth.dart';
//import 'package:keisyp/auth/Auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/iMarket.jpg'),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to iMarket',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Order Raw Food Staffs Online with Uganda\'s Largest & No.1 Ordering & Delivery App. Enjoy fast delivery, great discounts, and a wide variety of cuisines from top-rated Markets. Get started by selecting your favorite markets and explore categories.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Train',
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.redAccent, backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(child: Text('Welcome to Home Screen')),
//     );
//   }
// }
