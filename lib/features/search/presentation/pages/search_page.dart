import '../widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

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
                context.read<SearchBloc>().add(SearchQueryChanged(query));
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            return ProductGrid(products: state.products);
          } else if (state is SearchError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Start searching...'));
        },
      ),
    );
  }
}
