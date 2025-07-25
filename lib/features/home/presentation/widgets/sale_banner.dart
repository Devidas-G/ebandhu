import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SaleBanner extends StatefulWidget {
  final List<String> imgList;

  const SaleBanner({super.key, required this.imgList});

  @override
  State<SaleBanner> createState() => _SaleBannerState();
}

class _SaleBannerState extends State<SaleBanner> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentCarousel = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            height: 150,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarousel = index;
              });
            },
          ),
          carouselController: _carouselController,
          items:
              widget.imgList
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(item, fit: BoxFit.cover),
                      ),
                    ),
                  )
                  .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor.withValues(
                        alpha: _currentCarousel == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
