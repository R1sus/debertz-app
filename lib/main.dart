import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

var appColors = const {
  'primary': Color.fromARGB(255, 0, 140, 14),
  'totalCellBg': Color.fromARGB(105, 0, 0, 0),
  'evenCellBg': Color.fromARGB(158, 255, 255, 255),
  'oddCellBg': Color.fromARGB(209, 255, 255, 255),
  'buttonBg': Colors.white
};

class Cell extends StatelessWidget {
  const Cell(
      {Key? key, required this.text, this.isTotal = false, this.isEven = false})
      : super(key: key);
  final bool isEven;
  final bool isTotal;
  final String text;

  _getTextColor() {
    return isTotal ? Colors.white : Colors.black;
  }

  _getBackgroundColor() {
    return isTotal
        ? appColors['totalCellBg']
        : isEven
            ? appColors['evenCellBg']
            : appColors['oddCellBg'];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          margin: const EdgeInsets.fromLTRB(0, 0, 1, 1),
          decoration: BoxDecoration(color: _getBackgroundColor()),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                      color: _getTextColor(),
                      fontSize: 16,
                      fontFamily: 'Roboto')))),
    );
  }
}

class Record extends StatelessWidget {
  const Record(
      {Key? key,
      required this.number,
      required this.usValue,
      required this.theyValue,
      this.isTotal = false,
      this.isEven = false})
      : super(key: key);

  final bool isEven;
  final bool isTotal;
  final String number;
  final String usValue;
  final String theyValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Cell(text: number, isTotal: isTotal, isEven: isEven),
        Cell(text: usValue, isTotal: isTotal, isEven: isEven),
        Cell(text: theyValue, isTotal: isTotal, isEven: isEven),
      ],
    );
  }
}

class TopContent extends StatelessWidget {
  const TopContent({Key? key}) : super(key: key);

  _getRecords() {
    var records = <Record>[];
    for (var i = 1; i <= 20; i++) {
      var r = Record(
        number: i.toString(),
        usValue: '100',
        theyValue: '82',
        isEven: i % 2 == 0,
      );
      records.add(r);
    }
    return records;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        shrinkWrap: true,
        children: [
          const Record(
              number: '#', usValue: 'US', theyValue: 'THEY', isTotal: true),
          ..._getRecords(),
          const Record(
              number: 'TOTAL', usValue: '200', theyValue: '164', isTotal: true),
        ],
      ),
    );
  }
}

class BottomContent extends StatelessWidget {
  const BottomContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(color: Colors.red),
      height: 100,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Expanded(
          child: OutlinedButton(
              onPressed: () {
                print(1);
              },
              child: Text('Enter points'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                  primary: appColors['primary'],
                  backgroundColor: appColors['buttonBg']))),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: appColors['primary'],
              image: const DecorationImage(
                  image: AssetImage('assets/images/cards.png'))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [TopContent(), BottomContent()])),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Debertz Record', home: Home());
  }
}
