import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tp/model/tache.dart';
import 'package:flutter_tp/pages/ajouter.dart';
import 'package:flutter_tp/pages/details.dart';
import 'package:logger/logger.dart';
import './db/tache_helper.dart';
import './globals/tache_globals.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TpApp());
  }
}

class TpApp extends StatefulWidget {
  const TpApp({super.key});

  @override
  State<TpApp> createState() => _TpAppState();
}

class _TpAppState extends State<TpApp> {
  Future<void> loadData() async {
    //parsing url
    var url = Uri.parse(
        "https://my-json-server.typicode.com/youssefyazidi/api3/taches");

    //response
    var response = await http.get(url);

    var log = Logger();

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      await TacheHelper.instance!.deleteAll();
      for (int i = 0; i < jsonResponse.length; i++) {
        var tache = Tache(null,
            title: jsonResponse[i]["titre"], status: jsonResponse[i]["status"]);

        log.e(tache.toMap());

        TacheHelper.instance!.add(tache);
      }
    }
  }

  @override
  void initState() {
    setState(() {
      loadData();
    });
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQFLITE TP"),
      ),
      body: Center(
        child: FutureBuilder(
          future: TacheHelper.instance!.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 6,
                  ),
                  Text("Loading", style: TextStyle(fontSize: 26))
                ],
              );
            }

            if (snapshot.hasError) {
              return Column(
                children: [
                  const Icon(
                    Icons.error,
                    size: 64,
                  ),
                  Text(snapshot.error.toString(),
                      style: const TextStyle(fontSize: 26))
                ],
              );
            }

            if (!snapshot.hasData) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 64,
                  ),
                  Text("error fetching data", style: TextStyle(fontSize: 26))
                ],
              );
            }

            if (snapshot.data!.isEmpty) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 64,
                  ),
                  Text("liste des tache est vide...",
                      style: TextStyle(fontSize: 26))
                ],
              );
            }

            return ListView(
              children: snapshot.data!.reversed.map((e) {
                return Card(
                  child: ListTile(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details.data(tache: e)));
                      setState(() {});
                    },
                    leading: e["status"] == "terminé"
                        ? const Icon(
                            Icons.notifications_active,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.notifications_active,
                            color: Colors.red,
                          ),
                    title: Text(e["title"].toString()),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            TacheHelper.instance!
                                .delete(e[TacheGlobals.columnId] as int);
                          });
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => Ajouter()));
            refresh();
          }),
    );
  }
}
