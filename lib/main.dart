import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newlist/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'toDoList',
      home: Home(),
    );
  }
}
