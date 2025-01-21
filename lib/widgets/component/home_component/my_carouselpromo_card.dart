// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ocash/widgets/my_color.dart';

class MyCarouselpromo extends StatefulWidget {
  const MyCarouselpromo({super.key});

  @override
  _MyCarouselpromoState createState() => _MyCarouselpromoState();
}

class _MyCarouselpromoState extends State<MyCarouselpromo> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _imageUrls = [
    'https://ik.imagekit.io/tvlk/image/imageResource/2024/09/24/1727167400284-f5ef5f06df2c6f8261fad1993847c841.png?tr=q-75',
    'https://ik.imagekit.io/tvlk/image/imageResource/2024/09/04/1725431412915-1736fe1d037c6a859adc54f7b06871db.png?tr=q-75',
    'https://ik.imagekit.io/tvlk/image/imageResource/2024/08/30/1724989767966-57f696f6a97ce48855476f4899e3d232.png?tr=q-75',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: greys,
      ),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  _imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
