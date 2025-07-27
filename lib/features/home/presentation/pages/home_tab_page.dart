import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebandhu/features/home/presentation/widgets/product_grid.dart';
import 'package:ebandhu/features/home/presentation/widgets/sale_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
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
    return BlocBuilder<HomeBloc, HomeState>(
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
    );
  }
}
