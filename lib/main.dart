import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class BaseLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green, //TODO: change to #14A83D
        scaffoldBackgroundColor: Colors.green[400],
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.deepPurple,     //  <-- dark color
          textTheme: ButtonTextTheme.primary, //  <-- this auto selects the right color
        ),
      ),
      home: const MyHomePage(title: 'Debertz'),
    );
  }
}

class Game {
  int gameType;
  int usScore;
  int theyScore;

  Game({this.gameType = 162, this.usScore = 0, this.theyScore = 0});
}

class UserInput extends StatefulWidget {
  const UserInput({Key? key}) : super(key: key);

  @override
  _UserInputState createState() => _UserInputState();
}


class _UserInputState extends State<UserInput> {
  late int gameTypeInput;
  late int usScoreInput;
  late int theyScoreInput;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Game Score',
              ),
              onChanged: (val) {
                gameTypeInput = int.parse(val);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'US Score',
              ),
              onChanged: (val) {
                usScoreInput = int.parse(val);
                theyScoreInput = gameTypeInput - int.parse(val); //TODO: should be shown for user
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'They Score',
              ),
              onChanged: (val) {
                theyScoreInput = int.parse(val);
              },
            ),
            TextButton(
              child: const Text('submit'),
              onPressed: () {
                //TODO: call _dismissDialog() or lift this btn up
                events.add(Game(
                    gameType: gameTypeInput,
                    usScore: usScoreInput,
                    theyScore: theyScoreInput
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class GamesTable extends StatefulWidget {
  @override
  _GamesTableState createState() => _GamesTableState();
}

StreamController<Game> events = StreamController<Game>();


class _GamesTableState extends State<GamesTable> {
  List<Game> gameNodes = [];

  @override
  initState() {
    super.initState();  //TODO check if this nessesary
    events.stream.listen((data) {
      gameNodes.add(data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: gameNodes.map((node) {
          return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    // TODO: get game index and increment it
                    Text(gameNodes.indexOf(node).toString(), style: const TextStyle(color: Colors.green))
                  ]),
                  Column(children: [
                      Text(node.usScore.toString())
                  ]),
                  Column(children: [
                    Text(node.theyScore.toString())
                  ]),
                ],
              ),
          );
        }).toList(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/cards.png"),
            fit: BoxFit.scaleDown,
            scale: 0.5,
          ),
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have 6 the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                // textDirection: TextDirection.rtl,
                // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                // border:TableBorder.all(width: 2.0,color: Colors.red),
                children: const [
                  TableRow(
                    children: [
                      Text("Game #",textScaleFactor: 1.5,),
                      Text("US",textScaleFactor: 1.5),
                      Text("THEY",textScaleFactor: 1.5),
                    ]
                  ),
                  TableRow(
                    children: [
                      Text("Total",textScaleFactor: 1.5),
                      Text("total sum",textScaleFactor: 1.5),
                      Text("total sum",textScaleFactor: 1.5),
                    ]
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: GamesTable()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 24, color: Colors.green))
                  ),
                  onPressed: _showMaterialDialog,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Enter Points'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


void _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Material Dialog'),
            content: Column(
              children: const <Widget>[
                 Text(
                    'test',
                  ),
                Expanded(flex: 1, child: UserInput()),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: const Text('Close')),
              TextButton(
                onPressed: () {
                  print('HelloWorld!');
                  _dismissDialog();
                },
                child: const Text('HelloWorld!'),
              )
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }
}