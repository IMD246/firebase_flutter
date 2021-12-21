import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/services/database.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName = "";
  String _currentSugars = "0";
  int _currentStrength = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseSerVice(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData? userData = snapshot.data;
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val.toString();
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars.compareTo("0") == 0
                        ? userData!.sugars
                        : _currentSugars,
                    items: sugars
                        .map(
                          (sugar) => DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          ),
                        )
                        .toList(),
                    onChanged: (e) => setState(() {
                      _currentSugars = e.toString();
                    }),
                  ),
                  //slider
                  Slider(
                    activeColor: Colors.brown[
                        _currentStrength <= 100 ? 100 : _currentStrength],
                    inactiveColor: Colors.brown[
                        _currentStrength <= 100 ? 100 : _currentStrength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    label: (_currentStrength <= 100
                            ? userData?.strength
                            : _currentStrength)!
                        .round()
                        .toString(),
                    value: (_currentStrength <= 100
                            ? userData?.strength
                            : _currentStrength)!
                        .toDouble(),
                    onChanged: (val) => setState(
                      () {
                        _currentStrength = val.round();
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink[400]),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseSerVice(uid: user.uid).updateUserData(
                            _currentSugars.compareTo("0") == 0
                                ? userData!.sugars
                                : _currentSugars,
                            _currentName.trim().isEmpty
                                ? userData!.name
                                : _currentName,
                            _currentStrength <= 100
                                ? userData!.strength
                                : _currentStrength);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
