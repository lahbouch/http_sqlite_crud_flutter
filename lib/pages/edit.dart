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
  TextEditingController? tvTitleController = TextEditingController();
  bool? status;

  @override
  void initState() {
    tvTitleController!.text = widget.tache[TacheGlobals.columnTitle].toString();
    status = widget.tache[TacheGlobals.columnStatus].toString() == "terminé"
        ? true
        : false;
    super.initState();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("status", style: TextStyle(fontSize: 18)),
                  Switch(
                      activeColor: Colors.green,
                      value: status as bool,
                      onChanged: (value) {
                        setState(() {
                          status = value;
                        });
                      }),
                ],
              ),
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
                      status: status as bool ? "terminé" : "en cours");

                  //ajouter a la base de donner
                  setState(() {
                    TacheHelper.instance!.update(tache);
                  });

                  tvTitleController!.clear();
                  status = false;

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
