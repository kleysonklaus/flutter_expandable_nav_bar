import 'dart:ui';

import 'package:flutter/material.dart';
import 'music.dart';

const _cardColor = Color(0xFF5F40FB);
const _maxHeight = 350.0;
const _minHeight = 70.0;

class MainExpandableNavBar extends StatefulWidget {
  const MainExpandableNavBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainExpandableNavBar> createState() => MainExpandableNavBarState();
}

class MainExpandableNavBarState extends State<MainExpandableNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = false;
  double _currentHeight = _minHeight;
  late Music _currentMusic;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuWith = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(
                bottom: _minHeight + 20, left: 20, right: 20),
            itemCount: 5,
            itemBuilder: (context, index) {
              final music = musics[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMusic = music;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  // container image .asset
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors
                                .primaries[index % Colors.primaries.length],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                maxRadius: 20,
                              ),
                              SizedBox(height: 20),
                              Text(
                                _currentMusic.singer,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _currentMusic.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onVerticalDragUpdate: _expanded
                ? (details) {
                    setState(() {
                      final newHeight = _currentHeight - details.delta.dy;
                      _controller.value = _currentHeight / _maxHeight;
                      _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
                    });
                  }
                : null,
            onVerticalDragEnd: _expanded
                ? (details) {
                    if (_currentHeight < (_maxHeight / 2)) {
                      _controller.reverse();
                      _expanded = false;
                    } else {
                      _controller.forward(from: _currentHeight / _maxHeight);
                      _expanded = true;
                      _currentHeight = _maxHeight;
                    }
                  }
                : null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                // final value = Curves.elasticInOut.transform(_controller.value);
                final value =
                    const ElasticInOutCurve(0.7).transform(_controller.value);
                return Stack(
                  children: [
                    Positioned(
                      height: lerpDouble(_minHeight, _currentHeight, value),
                      left: lerpDouble(size.width / 2 - menuWith / 2, 0, value),
                      width: lerpDouble(menuWith, size.width, value),
                      bottom: lerpDouble(40, 0, value),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _cardColor,
                          borderRadius: BorderRadius.vertical(
                            top: const Radius.circular(20),
                            bottom:
                                Radius.circular(lerpDouble(20, 0, value) ?? 0),
                          ),
                        ),
                        child: _expanded
                            ? Opacity(
                                opacity: _controller.value,
                                child: _buildExpandedContent(),
                              )
                            : _buildMenuContent(),
                      ),
                    ),
                    // Positioned(
                    //   height: _minHeight,
                    //   left: size.width / 2 - menuWith / 2,
                    //   width: menuWith,
                    //   bottom: 40,
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.vertical(
                    //         top: Radius.circular(20),
                    //         bottom: Radius.circular(20),
                    //       ),
                    //     ),
                    //     child: _buildMenuContent(),
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      extendBody: true,
    );
  }

  /// contenido para cuando se expande
  Widget _buildExpandedContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 80,
              width: 80,
            ),
            const SizedBox(height: 15),
            Text(
              _currentMusic.singer,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 15),
            Text(_currentMusic.name, style: TextStyle(fontSize: 20)),
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
      ),
    );
  }

  /// contenido del menu
  Widget _buildMenuContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.calendar_today_sharp),
        GestureDetector(
            onTap: () {
              setState(() {
                _expanded = true;
                _currentHeight = _maxHeight;
                _controller.forward(from: 0.0);
              });
            },
            child: Icon(Icons.calendar_today)),
        Icon(Icons.calendar_today_sharp),
      ],
    );
  }
}
