
// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  print(choisir_mot());

  if (nb_voyelles < 2) {
    mot.clear();
    print(choisir_mot());
  }

  var response = http.get(Uri.parse("https://fr.wiktionary.org/w/api.php"));

  print(response);
}

List<String> lettres = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z',
];

List<String> voyelles = ["a", "e", "i", "o", "u", "y"];

List mot = [];

int nb_voyelles = 0;

List choisir_mot() {
  for (int i = 0; i < 9; i++) {
    mot.add(lettres[Random().nextInt(lettres.length)]);
   if (voyelles.contains(mot[i])) {
      nb_voyelles += 1;
   }
  }

  print(nb_voyelles);

  return mot;
}
