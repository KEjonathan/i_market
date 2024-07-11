import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_market/home/Home.dart';
import 'package:i_market/services/auth_service.dart'; // Import AuthService

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService(); // Initialize AuthService
  late User _user;
  String _name = 'Loading...';
  String _email = 'Loading...';
  String _address = 'Address not set';
  String _phoneNumber = 'Phone number not set';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    _user = _auth.currentUser!;
    await _authService.addOrUpdateUserData(_user);  // Ensure user data is in Firestore
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(_user.uid).get();

      setState(() {
        _name = _user.displayName ?? 'User';
        _email = _user.email ?? 'user@example.com';
        _address = userDoc['address'] ?? 'Address not set';
        _phoneNumber = userDoc['phoneNumber'] ?? 'Phone number not set';
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePhoneNumber() async {
    final phoneNumberController = TextEditingController(text: _phoneNumber);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Phone Number'),
          content: TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String newPhoneNumber = phoneNumberController.text;

                if (RegExp(r'^\+256[0-9]{9}$').hasMatch(newPhoneNumber)) {
                  try {
                    await _firestore.collection('users').doc(_user.uid).update({
                      'phoneNumber': newPhoneNumber,
                    });
                    setState(() {
                      _phoneNumber = newPhoneNumber;
                    });
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error updating phone number: $e');
                  }
                } else {
                  // Show error message for invalid phone number
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid Ugandan phone number.')),
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Profile'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.pink,),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Center(
                    child: Text(
                      "iMarket Notice",
                      style: TextStyle(color: Colors.pink, fontSize: 20),
                    ),
                  ),
                  content: Text(
                    "Notifications Enabled",
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
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.pink,
                  radius: 60,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _user.photoURL != null
                            ? NetworkImage(_user.photoURL!) as ImageProvider
                            : AssetImage('assets/images/user.jpg'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Personal Info
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Info',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      buildInfoRow('Name', _name),
                      buildInfoRow('Address', _address),
                      buildInfoRow('Email', _email),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone Number'),
                          TextButton(
                            onPressed: _updatePhoneNumber,
                            child: Text(
                              _phoneNumber,
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
