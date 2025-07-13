import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 10,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Hero(
          tag: 'search-bar',
          flightShuttleBuilder: (_, animation, __, fromHero, toHero) {
            animation.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                Future.delayed(Duration.zero, () {
                  _focusNode.requestFocus();
                });
              }
            });
            return toHero.widget;
          },
          child: Material(
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
      body: Placeholder(),
    );
  }
}
