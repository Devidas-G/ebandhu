import 'package:flutter/material.dart';

class ProductErrorPage extends StatelessWidget {
  const ProductErrorPage({
    super.key,
    required this.onTap,
    required this.errorMessage,
  });
  final VoidCallback onTap;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(errorMessage),
        ElevatedButton(onPressed: onTap, child: Text("Retry")),
      ],
    );
  }
}
