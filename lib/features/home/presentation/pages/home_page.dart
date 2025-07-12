import 'package:flutter/material.dart';

import '../../../search/search.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 10,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => SearchPage(),
                transitionsBuilder:
                    (_, anim, __, child) =>
                        FadeTransition(opacity: anim, child: child),
              ),
            );
          },
          child: Hero(
            tag: "search-bar",
            child: Material(
              color: Colors.transparent,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search...",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [SizedBox(height: 10)]),
        ),
      ),
    );
  }
}
