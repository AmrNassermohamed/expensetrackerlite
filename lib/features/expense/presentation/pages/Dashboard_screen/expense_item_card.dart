import 'package:flutter/material.dart';
import '../../../domain/entities/expense.dart';


class ExpenseItemCard extends StatelessWidget {
  final Expense item;

  const ExpenseItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFF1F3F6),
            child: Icon(Icons.shopping_cart, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.category,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const Text("item.description",
                    style: TextStyle(color: Colors.grey)), // Optional placeholder
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("\$${item.amount}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(item.date.toIso8601String().split("T")[0],
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}