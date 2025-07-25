import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebandhu/features/home/presentation/widgets/sale_banner.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextButton(onPressed: () {}, child: Text("See all")),
            ],
          ),
        ),

        // New Arrivals Grid
      ],
    );
  }
}
