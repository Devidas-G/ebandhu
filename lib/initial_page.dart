import 'package:flutter/material.dart';
import 'package:ebandhu/features/user/user.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final PageController _pageViewController = PageController(initialPage: 3);
  int currentindex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        onPageChanged: (index) {
          setState(() {
            currentindex = index;
          });
        },
        children: [Placeholder(), Placeholder(), Placeholder(), UserPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index) {
          _pageViewController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceOut,
          );
          setState(() {
            currentindex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }
}
