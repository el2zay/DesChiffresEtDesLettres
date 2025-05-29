// ! Ce code a été repris du code de Kenji qui se trouve dans python/chiffres.py

import 'dart:math';

import 'package:math_expressions/math_expressions.dart';

const petits = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10
];

const grands = [
  25,
  50,
  75,
  100
];

// Tirage de 6 chiffres aléatoires et d'une cible
List tirageChiffres() {
  final Random random = Random();
  final List<int> tousLesNombres = [...petits, ...grands];
  tousLesNombres.shuffle(random);
  
  final List<int> tirage = tousLesNombres.sublist(0, 6);
  final int cible = random.nextInt(900) + 100; 
  
  return [cible, tirage];
}

// Utilisation de la librairie math_expression pour calculer un string
int calculer(String expression) {
  Parser p = Parser();
  Expression exp = p.parse(expression);
  ContextModel cm = ContextModel();
  return (exp.evaluate(EvaluationType.REAL, cm)).round();
}