import 'package:flutter/material.dart';
import 'package:flutter_tp/pages/edit.dart';
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
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Modifier.data(tache: tache)),
                );

                Navigator.pop(context);
              },
              icon: Icon(Icons.edit))
        ],
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
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.timelapse_outlined,
                      color: Colors.red,
                    ),
              title: Text(tache[TacheGlobals.columnStatus].toString()),
            ),
          ],
        ),
      ),
    );
  }
}
