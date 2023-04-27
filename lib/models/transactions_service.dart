import './transactions.dart';
import 'package:flutter/material.dart';
import '../widgets/new_transactions.dart';

class TransactionService {
  double getTotalAmount() {
    return userTransactions.fold(0.0, (sum, item) => sum + item.amount);
  }

  List<Transaction> userTransactions = [
    Transaction(
      id: '73',
      title: 'Jeans',
      amount: 600,
      date: DateTime.now(),
    ),
  ];

  TransactionService();

  List<Transaction> get recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTX = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: date,
    );
    userTransactions.add(newTX);
    print('New transaction added: $newTX');
    print(userTransactions.length);
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(),
        );
      },
    );
  }
}
