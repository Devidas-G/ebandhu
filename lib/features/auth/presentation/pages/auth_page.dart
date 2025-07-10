import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  int _currentCarousel = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<String> imgList = [
    'assets/images/luxuryfashion.jpg',
    'assets/images/man.jpg',
    'assets/images/bags.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 500.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentCarousel = index;
                            });
                          },
                        ),
                        carouselController: _carouselController,

                        items:
                            imgList
                                .map(
                                  (item) => ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset(item, fit: BoxFit.cover),
                                  ),
                                )
                                .toList(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Various collections of latest products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap:
                            () => _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(
                                  _currentCarousel == entry.key ? 0.9 : 0.4,
                                ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Create Account")),
              TextButton(
                onPressed: () {},
                child: Text("Already Have An Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
