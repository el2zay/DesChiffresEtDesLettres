import 'package:chiffresetlettres/scripts/lettres.dart';
import 'package:flutter/material.dart';

List lettres = [];
List boiteLettres = [];
List usedLettres = [];
List motTrouves = [];

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
  List<Widget> buildLettres(length, onTap, type) {
    return List.generate(
      length,
      (index) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => onTap(index),
              child: MouseRegion(
                cursor: usedLettres.contains(index) && type == 1 ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
                child: Card(
                  color: usedLettres.contains(index) && type == 1 ? Colors.grey[350] : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: type == 1
                          ? Text(
                              lettres[index],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.cyan[900],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              boiteLettres.isEmpty ? "" : boiteLettres[index],
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
            ),
            if (type == 1)
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/ruban.png", width: 20, height: 20),
              ),
          ],
        );
      },
    );
  }

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
                child: Container(
                  width: width * 0.6,
                  height: height * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 20),

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
                      Expanded(
                        child: GridView.builder(
                          itemCount: motTrouves.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            childAspectRatio: 2,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color.fromRGBO(242, 200, 214, 1),
                              child: Center(
                                child: Text(
                                  motTrouves[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.cyan[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
                      ...buildLettres(
                        boiteLettres.length,
                        (index) {
                          setState(() {
                            boiteLettres.removeAt(index);
                            usedLettres.removeAt(index);
                          });
                        },
                        0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...buildLettres(
                    9,
                    (index) {
                      if (usedLettres.contains(index)) {
                        return;
                      }
                      setState(() {
                        boiteLettres.add(lettres[index]);
                        usedLettres.add(index);
                      });
                    },
                    1,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  IconButton(
                      icon: Icon(Icons.close_rounded, size: 40),
                      onPressed: () {
                        setState(() {
                          boiteLettres.clear();
                          usedLettres.clear();
                        });
                      }),
                  ElevatedButton(
                    onPressed: () async {
                      if (boiteLettres.isEmpty || boiteLettres.length < 2 || motTrouves.contains(boiteLettres.join())) {
                        return;
                      }
                      final result = await existance_mot(boiteLettres.join());
                      if (result == true) {
                        setState(() {
                          motTrouves.add(boiteLettres.join());
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
                  // IconButton(
                  //     icon: Icon(Icons.loop_rounded, size: 40),
                  //     onPressed: () {
                  //       setState(() {
                  //         boiteLettres.clear();
                  //         usedLettres.clear();
                  //         lettres.clear();
                  //       });
                  //     }),
                ],
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
    );
  }
}
