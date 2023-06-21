import 'package:flutter/material.dart';
import '../globals/tache_globals.dart';

class Details extends StatelessWidget {
  Details({super.key});

  late Map<String, Object?> tache;

  Details.data({required Map<String, Object?> this.tache});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.numbers),
              title: Text(tache[TacheGlobals.columnId].toString()),
            ),
            ListTile(
              leading: Icon(Icons.title),
              title: Text(tache[TacheGlobals.columnTitle].toString()),
            ),
            ListTile(
              leading: tache[TacheGlobals.columnStatus] == "terminé"
                  ? Icon(Icons.done)
                  : Icon(Icons.timelapse),
              title: Text(tache[TacheGlobals.columnTitle].toString()),
            ),
          ],
        ),
      ),
    );
  }
}
