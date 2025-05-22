// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/services.dart';

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

List<String> mot = [];

int nb_voyelles = 0;

List<String> choisirLettres() {
  for (int i = 0; i < 9; i++) {
    mot.add(lettres[Random().nextInt(lettres.length)]);
    if (voyelles.contains(mot[i])) {
      nb_voyelles += 1;
    }
  }
  
  while (nb_voyelles < 2) {
    mot.clear();
    choisirLettres();
  }

  return mot;
}

Future<bool> existanceMot(String mot) async {
  try {
    final contents = await rootBundle.loadString('assets/dictionnaire.txt');
    List<String> mots = contents.split('\n');
    for (String m in mots) {
      if (m.trim().toUpperCase() == mot.toUpperCase()) {
        return true;
      }
    }
    return false;
  } catch (e) {
    print('Erreur lors de la vérification du mot: $e');
    return false;
  }
}

Map lettresToDico(List<String> lettres) {
  var result = {};
  for (String lettre in lettres) {
    if (result.containsKey(lettre)) {
      result[lettre] += 1;
    } else {
      result[lettre] = 1;
    }
  }
  return result;
}

Future<List> chrToDico() async {
  var result = [];
  final contents = await rootBundle.loadString('assets/dictionnaire.txt');
  List<String> mots = contents.split('\n');
  for (String m in mots) {
    var dico = {};
    for (int i = 0; i < m.length; i++) {
      String lettre = m[i].toUpperCase();
      if (dico.containsKey(lettre)) {
        dico[lettre] += 1;
      } else {
        dico[lettre] = 1;
      }
    }
    result.add(dico);
  }
  print(result[0]);
  return result;
}
