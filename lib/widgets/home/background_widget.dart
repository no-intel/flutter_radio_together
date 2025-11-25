import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF9333EA), // purple-600
            Color(0xFF4F46E5), // indigo-600
            Color(0xFF2563EB), // blue-600
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}
