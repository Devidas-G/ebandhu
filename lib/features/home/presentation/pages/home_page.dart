import '../../../cart/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../search/search.dart';
import '../bloc/home_bloc.dart';
import '../widgets/product_grid.dart';
import '../widgets/sale_banner.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final List<String> imgList = [
    'assets/images/banners/sale_banner_1.jpg',
    'assets/images/banners/sale_banner_2.jpg',
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchContentEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()),
              );
            },
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeError) {
            return Column(
              children: [
                Text(state.message),
                ElevatedButton(onPressed: () {}, child: Text("Retry")),
              ],
            );
          } else if (state is HomeLoaded) {
            return ListView(
              children: [
                // Banner
                SaleBanner(imgList: imgList),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Arrivals",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(FetchContentEvent());
                        },
                        child: Text("See all"),
                      ),
                    ],
                  ),
                ),
                // New Arrivals Grid
                ProductGrid(products: state.products),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
