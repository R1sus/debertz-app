import 'package:debertz_app/form_input_container.dart';
import 'package:debertz_app/game_model.dart';
import 'package:debertz_app/game_record.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'form_input.dart';
import 'dialog_button.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => GameModel(),
    child: const MyApp(),
  ));
}

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
        ? AppColors.totalCellBg
        : isEven
            ? AppColors.evenCellBg
            : AppColors.oddCellBg;
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
      required this.weValue,
      required this.theyValue,
      this.isTotal = false,
      this.isEven = false})
      : super(key: key);

  final bool isEven;
  final bool isTotal;
  final String number;
  final String weValue;
  final String theyValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Cell(text: number, isTotal: isTotal, isEven: isEven),
        Cell(text: weValue, isTotal: isTotal, isEven: isEven),
        Cell(text: theyValue, isTotal: isTotal, isEven: isEven),
      ],
    );
  }
}

class TopContent extends StatelessWidget {
  const TopContent({Key? key}) : super(key: key);

  _getRecords(List<GameRecord> gameRecords) {
    var records = <Record>[
      const Record(number: '#', weValue: 'WE', theyValue: 'THEY', isTotal: true)
    ];
    if (gameRecords.isEmpty) {
      return records;
    }
    for (var i = 0; i < gameRecords.length; i++) {
      var gameRecord = gameRecords[i];
      var r = Record(
        number: '${i + 1}',
        weValue: '${gameRecord.us}',
        theyValue: '${gameRecord.they}',
        isEven: i % 2 == 0,
      );
      records.add(r);
    }
    return records;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Consumer<GameModel>(builder: (context, gameModel, child) {
      var us = gameModel.total['us'];
      var they = gameModel.total['they'];
      var records = _getRecords(gameModel.gameRecords);
      records.add(Record(
          number: 'TOTAL', weValue: '$us', theyValue: '$they', isTotal: true));
      return ListView(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.width < 600 ? 40 : 20, 20, 20),
        shrinkWrap: true,
        children: records,
      );
    }));
  }
}

class InputData {
  String value;

  InputData(this.value);

  // String get value => _value;
  // set value(String v) => value = v;
}

class PointsForm extends StatefulWidget {
  const PointsForm({required this.hideDialog, Key? key}) : super(key: key);
  final VoidCallback hideDialog;
  @override
  PointsFormState createState() => PointsFormState();
}

class PointsFormState extends State<PointsForm> {
  final _formKey = GlobalKey<FormState>();
  final _totalController = TextEditingController();
  final _usController = TextEditingController();
  final _theyController = TextEditingController();
  final GameRecord gameRecord = GameRecord();
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _totalController.addListener(_changeTotal);
    _usController.addListener(_changeUs);
    _theyController.addListener(_changeThey);
  }

  @override
  void dispose() {
    _totalController.dispose();
    _usController.dispose();
    _theyController.dispose();
    super.dispose();
  }

  void _changeTotal() {
    setState(() {
      gameRecord.full = int.tryParse(_totalController.text) ?? 0;
    });
  }

  void _changeUs() {
    setState(() {
      gameRecord.us = int.tryParse(_usController.text) ?? 0;
    });
  }

  void _changeThey() {
    setState(() {
      gameRecord.they = int.tryParse(_theyController.text) ?? 0;
    });
  }

  void _biteUs() {
    _usController.text = '';
    setState(() {
      gameRecord.biteUs();
    });
  }

  void biteThem() {
    _theyController.text = '';
    setState(() {
      gameRecord.biteThem();
    });
  }

  void onCancel() {
    widget.hideDialog();
  }

  void onCommit() {
    var isValid = gameRecord.validate();
    var gameRecords = context.read<GameModel>();
    if (isValid) {
      gameRecords.add(gameRecord);
      onCancel();
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  List<Widget> _renderChildren() {
    List<Widget> children = [
      FormInputContianer(
          child: DebertzFormInput(
              controller: _totalController,
              autofocus: true,
              label: 'GAME',
              hintText: '162')),
      FormInputContianer(
          child: DebertzFormInput(
        controller: _usController,
        label: 'US',
        hintText: '0',
        withBite: true,
        onBitePressed: _biteUs,
      )),
      FormInputContianer(
          child: DebertzFormInput(
        controller: _theyController,
        label: 'THEY',
        hintText: '0',
        withBite: true,
        onBitePressed: biteThem,
      )),
      Text('Check points',
          style: TextStyle(color: _error ? Colors.red : Colors.transparent)),
      // Text(gameRecord.toString(),
      //     style: TextStyle(color: _error ? Colors.red : Colors.blue)),
      SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DialogButton(
                label: 'CANCEL',
                onPressed: onCancel,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: DialogButton(
                label: 'COMMIT',
                onPressed: onCommit,
              ),
            )
          ],
        ),
      )
    ];
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _renderChildren()),
    );
  }
}

class BottomContent extends StatefulWidget {
  const BottomContent({Key? key}) : super(key: key);

  @override
  _BottomContentState createState() => _BottomContentState();
}

class _BottomContentState extends State<BottomContent> {
  void _hideDialog() {
    Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                  width: 332,
                  height: 262,
                  padding: const EdgeInsets.all(16),
                  child: PointsForm(
                    hideDialog: _hideDialog,
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Expanded(
          child: Consumer<GameModel>(
            builder: (context, gameModel, child) {
              var text = gameModel.finished ? 'RESTART' : 'ENTER POINTS';
              return OutlinedButton(
                  onPressed: () {
                    if (gameModel.finished) {
                      gameModel.restart();
                    } else {
                      _showDialog();
                    }
                  },
                  child: Text(text,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                      primary: AppColors.primary,
                      backgroundColor: AppColors.buttonBg));
            },
          ),
        ));
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              color: AppColors.primary,
              image: const DecorationImage(
                  image: AssetImage('assets/images/cards.png'))),
          child: Flex(
              direction: MediaQuery.of(context).size.width < 600
                  ? Axis.vertical
                  : Axis.horizontal,
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
