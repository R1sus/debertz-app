import 'package:debertz_app/game_record.dart';
import 'package:flutter/material.dart';

int boolToInt(bool input) => input ? 1 : 0;

class GameModel extends ChangeNotifier {
  List<GameRecord> gameRecords = [];

  void add(GameRecord gameRecord) {
    gameRecords.add(gameRecord);
    notifyListeners();
  }

  Map<String, int> get total {
    var us = 0;
    var they = 0;
    var ourBites = 0;
    var theirBites = 0;
    for (var i = 0; i < gameRecords.length; i++) {
      var gameRecord = gameRecords[i];
      us += gameRecord.us;
      they += gameRecord.they;
      ourBites += boolToInt(gameRecord.ourBite);
      theirBites += boolToInt(gameRecord.theirBite);
      if (ourBites == 3) {
        us -= 100;
      }
      if (theirBites == 3) {
        they -= 100;
      }
    }
    return {'us': us, 'they': they};
  }

  bool get finished {
    int us = total['us'] ?? 0;
    int they = total['they'] ?? 0;
    return us > 1000 || they > 1000;
  }

  void restart() {
    gameRecords = [];
    notifyListeners();
  }
}
