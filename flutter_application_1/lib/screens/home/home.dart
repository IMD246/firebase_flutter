import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Firebase Basic'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
