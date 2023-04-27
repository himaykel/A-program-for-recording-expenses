import 'package:flutter/material.dart';

class TotalAmountPage extends StatelessWidget {
  final double totalAmount;

  TotalAmountPage({required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total amount'),
      ),
      body: Center(
        child: Text(
          'Total amount: \$${totalAmount.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
