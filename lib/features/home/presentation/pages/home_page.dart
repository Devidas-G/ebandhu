import 'package:flutter/material.dart';

import '../../../search/search.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
          ],
          bottom: TabBar(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              borderSide: BorderSide(
                width: 3.0,
                color: Theme.of(context).primaryColor,
              ),
              insets: EdgeInsets.symmetric(horizontal: 30), // adjust for ~70%
            ),
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: "Home"), Tab(text: "Category")],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TabBarView(
              children: [
                // Tab 1: Home
                Column(
                  children: [
                    SizedBox(height: 10),
                    Text("Welcome to Home Page"),
                    // Add more widgets for home tab here
                  ],
                ),
                // Tab 2: Category
                Column(
                  children: [
                    SizedBox(height: 10),
                    Text("Browse Categories"),
                    // Add more widgets for category tab here
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
