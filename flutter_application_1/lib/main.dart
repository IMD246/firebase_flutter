import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/users.dart';
import 'package:flutter_application_1/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
