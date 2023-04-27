import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class transactionCard extends StatefulWidget {
  const transactionCard({
    super.key,
    required this.transaction,
    required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<transactionCard> createState() => TransactionCardState();
}

class TransactionCardState extends State<transactionCard> {
  late Color bgColor;
  @override
  void initState() {
    const availbleColors = [
      Colors.amber,
      Colors.yellow,
      Colors.greenAccent,
      Colors.deepOrange
    ];
    bgColor = availbleColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () => widget.deleteTx(widget.transaction.id),
              ),
      ),
    );
  }
}
