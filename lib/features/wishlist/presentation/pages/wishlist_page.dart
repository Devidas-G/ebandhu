import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  @override
  createState() => _WishlistPage();
}

class _WishlistPage extends State<WishlistPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Favourite"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                hintText: "Search products...",
                suffixIcon: IconButton(
                  onPressed: () {
                    print("object");
                  },
                  icon: Icon(Icons.settings),
                ),
              ),
              onChanged: (query) {
                // TODO: Add search logic
              },
            ),
          ),
        ),
      ),
    );
  }
}
