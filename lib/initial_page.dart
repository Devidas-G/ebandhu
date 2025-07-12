import 'package:flutter/material.dart';

import 'features/home/home.dart';
import 'features/orders/orders.dart';
import 'features/user/user.dart';
import 'features/wishlist/presentation/pages/wishlist_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final PageController _pageViewController = PageController(initialPage: 0);
  int currentindex = 0;
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
        children: [HomePage(), OrdersPage(), WishlistPage(), UserPage()],
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
