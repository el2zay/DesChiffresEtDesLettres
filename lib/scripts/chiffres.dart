// ! Ce code a été repris du code de Kenji qui se trouve dans python/chiffres.py

import 'dart:math';

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

List tirageChiffres() {
  final Random random = Random();
  final List<int> tousLesNombres = [...petits, ...grands];
  tousLesNombres.shuffle(random);
  
  final List<int> tirage = tousLesNombres.sublist(0, 6);
  final int cible = random.nextInt(900) + 100; 
  
  return [cible, tirage];
}

bool utiliserUniquementNombres(String chaine, List<int> nombres) {
  final regex = RegExp(r'\d+');
  final chiffresUtilises = regex.allMatches(chaine).map((match) => match.group(0)!).toList();
  final temp = List<int>.from(nombres);
  
  try {
    for (var c in chiffresUtilises) {
      final n = int.parse(c);
      if (temp.contains(n)) {
        temp.remove(n);
      } else {
        return false;
      }
    }
    return true;
  } catch (e) {
    return false;
  }
}