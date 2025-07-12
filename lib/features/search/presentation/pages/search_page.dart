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
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
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
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: "Search products...",
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        // TODO: Add search logic
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
