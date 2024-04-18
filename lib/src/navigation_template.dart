import 'package:flutter/material.dart';
import 'package:purs_spring_24/src/camera/camera_preview.dart';
import 'package:purs_spring_24/src/donate/donate_view.dart';
import 'package:purs_spring_24/src/home/home_view.dart';
import 'package:purs_spring_24/src/test/test_view.dart';

class NavigationTemplate extends StatefulWidget {
  const NavigationTemplate({super.key, required this.body});

  final Widget body;

  @override
  _NavigationTemplateState createState() => _NavigationTemplateState();
}

class _NavigationTemplateState extends State<NavigationTemplate> {
  int _currentPageIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.camera),
      label: 'Camera',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.volunteer_activism),
      label: 'Donate',
    ),
  ];

  void _onTapFunction(int index, BuildContext context) {
    if (index != _currentPageIndex) {
      switch (index) {
        case 0: // Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationTemplate(
                body: PageViewExample(),
              ),
            ),
          );
          _currentPageIndex = 0;
          break;
        case 1: // Camera
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationTemplate(
                body: TakePictureScreen(),
              ),
            ),
          );
          _currentPageIndex = 1;
          break;
        case 2: // Donate
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationTemplate(
                body: DonateView(),
              ),
            ),
          );
          _currentPageIndex = 2;
          break;
        default: // Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationTemplate(
                body: HomeView(),
              ),
            ),
          );
          _currentPageIndex = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        onTap: (int index) => _onTapFunction(index, context),
      ),
      body: widget.body,
    );
  }
}
