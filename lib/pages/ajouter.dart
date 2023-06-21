import 'package:flutter/material.dart';
import 'package:flutter_tp/db/tache_helper.dart';
import 'package:flutter_tp/model/tache.dart';

class Ajouter extends StatefulWidget {
  Ajouter({super.key});

  late Function? refreshFunc;

  Ajouter.refresh({required Function refreshFunc});

  @override
  State<Ajouter> createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  TextEditingController? tvTitleController = TextEditingController();
  String? tvStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une tache"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 22),
                  hintStyle: TextStyle(fontSize: 16),
                  icon: Icon(
                    Icons.title,
                    size: 24,
                  ),
                  hintText: "title de tache...",
                  labelText: "Title"),
              controller: tvTitleController,
            ),
            RadioListTile(
              title: Text("En cours"),
              value: "en cours",
              groupValue: tvStatus,
              selected: true,
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
              selected: false,
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
                  var tache = Tache(null,
                      title: tvTitleController!.text,
                      status: tvStatus.toString());

                  //ajouter a la base de donner
                  setState(() {
                    TacheHelper.instance!.add(tache);
                  });

                  tvTitleController!.clear();
                  tvStatus = "en cours";

                  //fermeture de l'activity
                  Navigator.pop(context);
                },
                child: const Text("Ajouter"))
          ],
        ),
      ),
    );
  }
}
