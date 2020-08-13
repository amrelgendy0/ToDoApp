import 'package:flutter/material.dart';
import './Helper/database.dart';
import './Screen/HomeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await database().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(primaryColor: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
