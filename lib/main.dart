import 'package:blqdeveloper/Constants/const.dart';
import 'package:blqdeveloper/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sendbird = SendbirdSdk(appId: sendbirdappid);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SendBird',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SendBird'),
    );
  }
}

