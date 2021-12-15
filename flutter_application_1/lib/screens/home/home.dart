import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brew.dart';
import 'package:flutter_application_1/screens/home/brew_list.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text('bottom sheet'),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseSerVice(uid: '').brews,
      child: Scaffold(
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
            TextButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
