import 'package:flutter/material.dart';

class RecentHeader extends StatelessWidget {
  const RecentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Expenses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          'See all',
          style: TextStyle(color: Colors.blue),
        ),
      ],
    );
  }
}
