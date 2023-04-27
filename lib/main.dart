import 'dart:io';

import 'package:flutter/cupertino.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';
import './widgets/transactions_list.dart';
import './models/transactions_service.dart';
import './widgets/sum_all.dart';

void main() {
  // WidgetsFlutterBinding();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Власні витрати',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Helvetica',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleSmall: const TextStyle(
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  var myTransactionService = TransactionService();

  void _deleteTransaction(String id) {
    setState(() {
      myTransactionService.userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Switch.adaptive(
            activeColor: Colors.yellow,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          )
        ],
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: Chart(myTransactionService.userTransactions))
          : txListWidget
    ];
  }

  List<Widget> buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.2,
          child: Chart(myTransactionService.userTransactions)),
      Column(
        children: [
          Center(
            child: TextButton(
                child: Text('Sum of all transactions'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TotalAmountPage(
                                totalAmount:
                                    myTransactionService.userTransactions.fold(
                                        0.0, (sum, item) => sum + item.amount),
                              )));
                }),
          )
        ],
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('main.dart');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final iosBar = CupertinoNavigationBar(
      middle: const Text('Flutter App'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => myTransactionService.startAddNewTransaction(context),
          ),
        ],
      ),
    );

    final androidBar = AppBar(
      title: const Text('Flutter App'),
      actions: <Widget>[
        IconButton(
            onPressed: () =>
                {myTransactionService.startAddNewTransaction(context)},
            icon: const Icon(Icons.add)),
      ],
    );
    final appBar = androidBar;
    final txListWidget = SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(
            myTransactionService.userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ...buildLandscapeContent(mediaQuery, appBar, txListWidget),
            if (!isLandscape)
              ...buildPortraitContent(mediaQuery, appBar, txListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: iosBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: androidBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      myTransactionService.startAddNewTransaction(context);
                    },
                  ),
          );
  }
}
