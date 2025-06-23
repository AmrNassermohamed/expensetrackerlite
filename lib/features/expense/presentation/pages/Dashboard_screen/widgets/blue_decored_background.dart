import 'package:flutter/material.dart';

class BlueDecorBackground extends StatelessWidget {
  const BlueDecorBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        children: [
          Positioned(
            left: -80,
            top: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF246BFD),
              ),
            ),
          ),
          Positioned(
            right: -60,
            top: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF246BFD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}