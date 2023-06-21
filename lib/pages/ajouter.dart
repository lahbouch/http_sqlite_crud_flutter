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
            // TextField(
            //   controller: ,
            // ),

            ElevatedButton(
                onPressed: () {
                  //creation de tache
                  var tache = Tache(null,
                      title: tvTitleController!.text, status: "en cours");

                  //ajouter a la base de donner
                  setState(() {
                    TacheHelper.instance!.add(tache);
                  });

                  tvTitleController!.clear();

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
