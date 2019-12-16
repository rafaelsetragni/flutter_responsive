import 'package:flutter/material.dart';
import 'package:flutter_responsive_example/pages/grids_page.dart';
import 'package:flutter_responsive_example/pages/grids_performance.dart';
import 'package:flutter_responsive_example/pages/home_page.dart';
import 'package:flutter_responsive_example/pages/typography_page.dart';
import 'package:flutter_responsive_example/pages/typography_performance.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}
class _MyApp extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Example',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 86, 61, 124),
        accentColor: Colors.black,

        // Define the default font family.
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}