import 'package:flutter/material.dart';
import 'package:novasat/src/screen_layout.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'North-Wind-API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenLayoutHelper(),
    );
  }
}
