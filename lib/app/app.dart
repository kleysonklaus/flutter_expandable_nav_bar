import 'package:flutter/material.dart';

import 'main_expandable_nav_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Expandable Nav Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainExpandableNavBar(title: 'Flutter Expandable Nav Bar'),
    );
  }
}
