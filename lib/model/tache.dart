import '../globals/tache_globals.dart';

class Tache {
  int? id;
  late String title;
  late String status;

  Tache(this.id, {required this.title, required this.status});

  Tache.fromMap(Map<String, dynamic> tache) {
    title = tache[TacheGlobals.columnTitle];
    status = tache[TacheGlobals.columnStatus];
    if (id != null) {
      id = tache[TacheGlobals.columnId];
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[TacheGlobals.columnStatus] = status;
    map[TacheGlobals.columnTitle] = title;
    if (id != null) {
      map[TacheGlobals.columnId] = id;
    }
    return map;
  }
}
