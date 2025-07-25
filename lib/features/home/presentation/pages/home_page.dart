import 'package:flutter/material.dart';
import 'package:ebandhu/features/home/presentation/pages/home_tab_page.dart';
import 'package:ebandhu/features/home/presentation/pages/category_tab_page.dart';
import '../../../search/search.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
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
            onTap:
                () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => SearchPage(),
                    transitionsBuilder:
                        (_, anim, __, child) =>
                            FadeTransition(opacity: anim, child: child),
                  ),
                ),
            child: Hero(
              tag: "search-bar",
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              borderSide: BorderSide(
                width: 3,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              insets: EdgeInsets.symmetric(horizontal: 30),
            ),
            unselectedLabelColor: Colors.grey,
            tabs: const [Tab(text: "Home"), Tab(text: "Category")],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [HomeTabPage(), CategoryTabPage()],
        ),
      ),
    );
  }
}
