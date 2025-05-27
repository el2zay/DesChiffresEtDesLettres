import 'dart:async';

import 'package:chiffresetlettres/scripts/lettres.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as audio_player;
import 'package:just_audio_background/just_audio_background.dart';

List<String> lettres = [];
List boiteLettres = [];
List usedLettres = [];
List motTrouves = [];
List lePlusLong = [];
int time = 40;
bool wrong = false;
int gameState = 0; // 0 = jeu en cours, 1 = gagné, 2 = perdu
String titre = "Head Empty";
late audio_player.AudioPlayer player;
final player2 = audio_player.AudioPlayer();
bool muted = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  lettres = choisirLettres();
  lePlusLong = await trouverMotsPossibles(lettres);
  print(lePlusLong);
  await JustAudioBackground.init();
  player = audio_player.AudioPlayer();
  if (player.playing == false) {
    player
        .setAudioSource(
      audio_player.AudioSource.asset(
        "assets/Head Empty.mp3",
        tag: MediaItem(
          id: "assets/Head Empty.mp3",
          title: "Head Empty",
        ),
      ),
    )
        .then((_) {
      player.setLoopMode(audio_player.LoopMode.one);
      player.play();
    });
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
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time == 0) {
        timer.cancel();
        if (motTrouves.any((mot) => lePlusLong.contains(mot))) {
          setState(() {
            gameState = 1;
          });
        } else {
          setState(() {
            gameState = 2;
          });
        }
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

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
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(248, 143, 175, 1),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(248, 143, 175, 1),
            title: Row(
              children: [
                IconButton(
                  icon: Icon(muted ? Icons.music_off_rounded : Icons.music_note_rounded),
                  onPressed: () {
                    if (player.playing) {
                      player.pause();
                      setState(() {
                        muted = true;
                      });
                    } else {
                      player.play();
                      setState(() {
                        muted = false;
                      });
                    }
                  },
                ),
                SizedBox(width: 5),
                !muted
                    ? Text(
                        titre,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    : SizedBox(),
              ],
            ),
            actions: [
              Icon(Icons.timer),
              SizedBox(width: 5),
              Text(
                "0:${time < 10 ? "0$time" : time}",
                style: TextStyle(fontSize: 16, fontFeatures: [
                  const FontFeature.tabularFigures()
                ]),
              ),
              SizedBox(width: 25),
            ],
            bottom: TabBar(
              labelColor: Color.fromRGBO(176, 20, 85, 1),
              indicatorColor: Color.fromRGBO(176, 20, 85, 1),
              dividerColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 12),
              tabs: [
                Tab(text: "Lettres"),
                Tab(text: "Chiffres"),
              ],
            ),
          ),
          body: gameState == 0
              ? Stack(
                  children: [
                    Center(
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
                                  final result = await existanceMot(boiteLettres.join());
                                  if (result == true) {
                                    setState(() {
                                      motTrouves.add(boiteLettres.join());
                                      boiteLettres.clear();
                                      usedLettres.clear();
                                    });
                                  } else {
                                    player.pause();
                                    player2.setAsset(
                                      "assets/to.m4a",
                                    );
                                    player2.play();
                                    setState(() {
                                      wrong = true;
                                    });
                                    await Future.delayed(Duration(seconds: 1));
                                    setState(() {
                                      wrong = false;
                                    });
                                    player2.stop();
                                    player.play();
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
                    if (wrong)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/non.png",
                            height: height * 0.6,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  ],
                )
              : Stack(
                  children: [
                    Center(
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
                              child: Center(
                                child: Text(
                                  "VOUS AVEZ ${gameState == 1 ? "GAGNÉ" : "PERDU"}",
                                  style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.cyan[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Image.asset(
                            gameState == 2 ? "assets/pleure.png" : "assets/gagne.gif",
                            height: height * 0.2,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gameState = 0;
                                time = 40;
                                lettres.clear();
                                boiteLettres.clear();
                                usedLettres.clear();
                                motTrouves.clear();
                                lettres = choisirLettres();
                                // lePlusLong = await lePlusLongMot(lettres);
                                // print(lePlusLong);
                              });
                              startTimer();
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
                              "REJOUER",
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
