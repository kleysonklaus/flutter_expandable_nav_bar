import 'package:flutter/material.dart';

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
      home: const _MainExpandableNavBar(title: 'Flutter Expandable Nav Bar'),
    );
  }
}

class _MainExpandableNavBar extends StatefulWidget {
  const _MainExpandableNavBar({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  State<_MainExpandableNavBar> createState() => _MainExpandableNavBarState();
}

class _MainExpandableNavBarState extends State<_MainExpandableNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
          );
        },
      ),
    );
  }
}
