import 'package:chiffresetlettres/scripts/lettres.dart';
import 'package:flutter/material.dart';

List lettres = [];
List boiteLettres = [];
List usedLettres = [];
List mottrouves = [];

void main() {
  lettres = choisir_lettres();

  while (nb_voyelles < 2) {
    lettres.clear();
    lettres = choisir_lettres();
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(248, 143, 175, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(248, 143, 175, 1),
          title: Text("9 Lettres"),
          actions: [
            Icon(Icons.timer),
            SizedBox(width: 5),
            Text(
              "0:30", // TODO timer
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 40),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: width * 0.6,
                  height: height * 0.5,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "MOTS TROUVÉS",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.cyan[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // TODO
                    ],
                  ),
                ),
              ),
              Container(
                width: width * 0.6,
                height: height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(242, 200, 214, 1),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        boiteLettres.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                boiteLettres.removeAt(index);   
                                usedLettres.removeAt(index);
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    boiteLettres.isEmpty
                                        ? ""
                                        : boiteLettres[index].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.cyan[900],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    9,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          if (usedLettres.contains(index)) {
                            return;
                          }
                          setState(() {
                            boiteLettres.add(lettres[index]);
                            usedLettres.add(index);
                          });
                        },
                        child: MouseRegion(
                          cursor: usedLettres.contains(index)
                              ? SystemMouseCursors.forbidden
                              : SystemMouseCursors.click,
                          child: Card(
                            color: usedLettres.contains(index)
                                ? Colors.grey[350]
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: Text(
                                  lettres[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.cyan[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                 final result =  await existance_mot(boiteLettres.join());
                 if (result) {
                   setState(() {
                     mottrouves.add(boiteLettres.join());
                     boiteLettres.clear();
                     usedLettres.clear();
                   });
                 }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Color.fromRGBO(176, 20, 85, 1),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                  ),
                ),
                child: Text(
                  "VALIDER",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}