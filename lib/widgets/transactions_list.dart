// import 'package:flutter/material.dart';
// import '../models/transactions.dart';
// import 'package:intl/intl.dart';

// class TransactionList extends StatelessWidget {
//   final List<Transaction> transactions;

//   TransactionList(this.transactions);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: transactions.map((tx) {
//         return Card(
//           child: Row(children: <Widget>[
//             Container(
//               margin: EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(32),
//                 border: Border.all(
//                   color: Theme.of(context).primaryColor,
//                   width: 3,
//                 ),
//               ),
//               padding: EdgeInsets.all(16),
//               width: 130,
//               child: Center(
//                 child: Text(
//                   '₴ ${tx.amount.toStringAsFixed(1)}',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: Theme.of(context).primaryColor),
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   tx.title,
//                   style: Theme.of(context).textTheme.titleSmall,
//                 ),
//                 Text(
//                   DateFormat().add_yMMMEd().format(tx.date),
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
//                 )
//               ],
//             )
//           ]),
//         );
//       }).toList(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
