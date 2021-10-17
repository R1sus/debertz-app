class GameRecord {
  int full = 162;
  int us = 0;
  bool ourBite = false;
  int they = 0;
  bool theirBite = false;
  bool validate() => full > 0 && us + they == full;

  GameRecord({int? full, int? us, int? they}) {
    this.full = full ?? this.full;
    this.us = us ?? this.us;
    this.they = they ?? this.they;
  }

  void biteUs() {
    ourBite = true;
    theirBite = false;
    if (full > 0) {
      us = 0;
      they = full;
    }
  }

  void biteThem() {
    ourBite = false;
    theirBite = true;
    if (full > 0) {
      they = 0;
      us = full;
    }
  }

  @override
  String toString() {
    var result = 'Total game: $full, We got $us, They got $they';
    if (ourBite) {
      result += '; We have bite';
    }
    if (theirBite) {
      result += '; They have bite';
    }
    return result;
  }
}
