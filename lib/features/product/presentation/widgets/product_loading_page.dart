import 'package:flutter/material.dart';

class ProductLoadingPage extends StatelessWidget {
  const ProductLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
