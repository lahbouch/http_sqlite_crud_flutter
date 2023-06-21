import 'package:flutter/material.dart';
import 'package:flutter_tp/db/tache_helper.dart';
import 'package:flutter_tp/globals/tache_globals.dart';
import 'package:flutter_tp/model/tache.dart';

class Modifier extends StatefulWidget {
  Modifier({super.key});

  late Map<String, Object?> tache;

  Modifier.data({required this.tache});

  @override
  State<Modifier> createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
  TextEditingController? tvTitleController = TextEditingController(
      text: widget.tache[TacheGlobals.columnTitle].toString());
  String? tvStatus;

  bool getSelected(String status) {
    return status == "terminé" ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier une tache"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 22),
                  hintStyle: TextStyle(fontSize: 16),
                  icon: Icon(
                    Icons.title,
                    size: 24,
                  ),
                  hintText: widget.tache[TacheGlobals.columnTitle].toString(),
                  labelText: "Titre de tache"),
              controller: tvTitleController,
            ),
            RadioListTile(
              title: Text("En cours"),
              value: "en cours",
              groupValue: tvStatus,
              selected: getSelected(
                  widget.tache[TacheGlobals.columnStatus].toString()),
              onChanged: (value) {
                setState(() {
                  tvStatus = value;
                });
              },
            ),
            RadioListTile(
              title: Text("Terminé"),
              value: "terminé",
              groupValue: tvStatus,
              selected: getSelected(
                  widget.tache[TacheGlobals.columnStatus].toString()),
              onChanged: (value) {
                setState(() {
                  tvStatus = value;
                });
              },
            ),
            // TextField(
            //   controller: ,
            // ),

            ElevatedButton(
                onPressed: () {
                  //creation de tache
                  var tache = Tache(
                      int.parse(widget.tache[TacheGlobals.columnId].toString()),
                      title: tvTitleController!.text,
                      status: tvStatus.toString());

                  //ajouter a la base de donner
                  setState(() {
                    TacheHelper.instance!.update(tache);
                  });

                  tvTitleController!.clear();
                  tvStatus = "en cours";

                  //fermeture de l'activity
                  Navigator.pop(context);
                },
                child: const Text("Modifier"))
          ],
        ),
      ),
    );
  }
}
