import 'package:blind_app/home.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:blind_app/users/homePage.dart';

import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mongo DB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EasySplashScreen(
        durationInSeconds: 6,
        navigator: Home(),
        backgroundImage: AssetImage('assets/images/s2.jpg'),
        loaderColor: Colors.grey,
        logo: Image.asset(
          'assets/images/134543.png',
        ),
      ),
    );
  }
}
