import 'package:flutter/material.dart';

const _cardColor = Color(0xFF5F40FB);
const _maxHeight = 350.0;
const _minHeight = 70.0;

class MainExpandableNavBar extends StatefulWidget {
  const MainExpandableNavBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainExpandableNavBar> createState() => MainExpandableNavBarState();
}

class MainExpandableNavBarState extends State<MainExpandableNavBar> {
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
      extendBody: true,
      bottomNavigationBar: Stack(
        children: [
          Positioned(
            height: _maxHeight,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(color: _cardColor, child: _buildExpandedContent()),
          ),
          // Positioned(
          //   height: _maxHeight,
          //   bottom: 40,
          //   left: 0,
          //   right: 0,
          //   child: Container(color: _cardColor, child: _buildExpandedContent()),
          // ),
        ],
      ),
    );
  }

  /// contenido para cuando se expande
  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 80,
            width: 80,
          ),
          const SizedBox(height: 15),
          const Text(
            'Last Century',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 15),
          const Text("bloddy tear", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.shuffle),
              Icon(Icons.pause),
              Icon(Icons.playlist_add),
            ],
          )
        ],
      ),
    );
  }

  /// contenido del menu
  Widget _buildMenuContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Icon(Icons.calendar_today_sharp),
        Icon(Icons.calendar_today),
        Icon(Icons.calendar_today_sharp),
      ],
    );
  }
}
