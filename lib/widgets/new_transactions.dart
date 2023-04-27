import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';
import '../models/transactions_service.dart';

class NewTransaction extends StatefulWidget {
  // final Function addTx;
  // NewTransaction(this.addTx);
  @override
  NewTransactionState createState() => NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var myTransactionService = TransactionService();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                      ),
                    ),
                    AdaptiveButton('Choose date', _presentDatePicker)
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final txTitle = titleController.text;
                    final txAmount = double.parse(amountController.text);
                    final txDate = selectedDate;

                    print(
                        'Adding new transaction: title=$txTitle, amount=$txAmount, date=$txDate');

                    myTransactionService.addNewTransaction(
                        txTitle, txAmount, txDate);

                    setState(() {});
                  },
                  child: const Text('Add Transaction'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
