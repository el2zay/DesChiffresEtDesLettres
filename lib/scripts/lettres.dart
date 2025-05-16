// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

List<String> lettres = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

List<String> voyelles = [
  "A",
  "E",
  "I",
  "O",
  "U",
  "Y"
];

List mot = [];

int nb_voyelles = 0;

List choisir_lettres() {
  for (int i = 0; i < 9; i++) {
    mot.add(lettres[Random().nextInt(lettres.length)]);
    if (voyelles.contains(mot[i])) {
      nb_voyelles += 1;
    }
  }

  return mot;
}

Future<bool> existance_mot(String mot) async {
  Uri uri = Uri.https('fr.wiktionary.org', '/w/api.php', {
    "action": "query",
    "titles": mot.toLowerCase(),
    "format": "json"
  });

  http.Response reponse = await http.get(uri);
  Map<String, dynamic> data = jsonDecode(reponse.body);

  bool estUnMot = !data['query']['pages'].containsKey("-1");

  return estUnMot;
}
