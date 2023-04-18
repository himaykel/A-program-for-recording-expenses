// import 'package:flutter/material.dart';

// class NewTransaction extends StatefulWidget {
//   final Function addTx;

//   NewTransaction(this.addTx);

//   @override
//   _NewTransactionState createState() => _NewTransactionState();
// }

// class _NewTransactionState extends State<NewTransaction> {
//   final titleController = TextEditingController();

//   final amountController = TextEditingController();

//   void submitData() {
//     final enteredTitle = titleController.text;
//     final enteredAmount = double.parse(amountController.text);

//     if (enteredTitle.isEmpty || enteredAmount <= 0) {
//       return;
//     }

//     widget.addTx(
//       enteredTitle,
//       enteredAmount,
//     );

//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(labelText: 'Що було куплено?'),
//               controller: titleController,
//               onSubmitted: (_) => submitData(),
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Ввести суму'),
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               onSubmitted: (_) => submitData(),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16),
//               child: ElevatedButton(
//                   onPressed: submitData, child: Text('Добавити')),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

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
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Add Transaction'),
                onPressed: _submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
