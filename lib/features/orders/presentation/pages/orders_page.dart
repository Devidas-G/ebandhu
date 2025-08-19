import 'package:ebandhu/features/orders/presentation/pages/history_tab_page.dart';
import 'package:ebandhu/features/orders/presentation/pages/orders_tab_page.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  createState() => _OrdersPage();
}

class _OrdersPage extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Orders"),
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
            tabs: [Tab(text: "My Orders"), Tab(text: "History")],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [OrdersTabPage(), HistoryTabPage()],
        ),
      ),
    );
  }
}
