import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/brew.dart';
import 'package:flutter_application_1/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brewlists = Provider.of<List<Brew>>(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        return BrewTile(brew: brewlists[index]);
      },
      itemCount: brewlists.length,
    );
  }
}
