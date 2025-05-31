// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:chalkdart/chalkdart.dart';

// Pour le mode console.
void main() async {
  print(chalk.pink("Bienvenue dans le jeu des lettres !"));
  print(chalk.pink("Voici les lettres disponibles :"));
  final lettresDisponibles = choisirLettres(); // Choisir 9 lettres aléatoires avec au moins 2 voyelles
  final motsPossibles = await trouverMotsPossibles(lettresDisponibles); // Trouver les mots possibles avec les lettres disponibles
  print(chalk.lightPink(lettresDisponibles.join(' ')));
  print(chalk.hotPink("Essayez de former le mot le plus long possible avec ces lettres."));
  print(chalk.deepPink("Appuyez sur Q pour quitter le jeu à tout moment."));
  bool gagne = false; // Booléen qui vérifie si le joueur a gagné
  bool enCours = false; // Booléen qui vérifie si le jeu est en cours

  while (!gagne) {
    if (!enCours) {
      enCours = true;
      print(chalk.pink("\nEntrez un mot :"));
      String? inputMot = stdin.readLineSync()?.toUpperCase().trim(); // L'équivalent de input() en Python
      if (inputMot == "Q") {
        print(chalk.hotPink("\nÀ bientôt !"));
        break;
      }
      if (inputMot != null && inputMot.isNotEmpty) {
        bool existe = await existanceMot(inputMot); // Booléen qui vérifie si le mot existe dans le dictionnaire
        if (existe) {
          // Si le mot existe dans le dictionnaire
          final lettresMap = lettresToDico(lettresDisponibles);
          final motMap = lettresToDico(inputMot.split(''));
          // On vérifie si le mot peut être formé avec les lettres disponibles et s'il est l"un de mots les plus longs
          if (estInclus(motMap, lettresMap) && motsPossibles.contains(inputMot.toUpperCase())) {
            print(chalk.hotPink("Bravo ! Le mot '$inputMot' est un des plus longs mots."));
            gagne = true;
          } else if (estInclus(motMap, lettresMap) && !motsPossibles.contains(inputMot.toUpperCase())) {
            print(chalk.hotPink("Le mot '$inputMot' est correct mais n'est pas le plus long possible."));
            enCours = false;
          } else {
            print(chalk.hotPink("Le mot '$inputMot' n'est pas formé avec les lettres disponibles."));
            enCours = false;
          }
        } else {
          enCours = false;
          print(chalk.deepPink("Le mot '$inputMot' n'existe pas dans le dictionnaire."));
        }
      } else {
        enCours = false;
        print(chalk.hotPink("Aucun mot entré. Veuillez réessayer."));
      }
    }
  }
}

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
List<Map<dynamic, dynamic>> dictionnaire = [];

int nbVoyelles = 0;

/* 
? Précision :
? Ici se trouve le code où les fonctions pour le jeux lettres sont définies. Vous trouverez les fonctions pour le jeux chiffre dans le fichier chiffres.dart 

? Le type qui se trouve devant le nom des fonctions est le type de retour de la fonction.
? Les <> sont utilisés pour les sous-types, par exemple List<String> signifie une liste de chaînes de caractères.
*/

// Fonction pour choisir 9 lettres aléatoires, avec au moins 2 voyelles
List<String> choisirLettres() {
  for (int i = 0; i < 9; i++) {
    mot.add(lettres[Random().nextInt(lettres.length)]);
    if (voyelles.contains(mot[i])) {
      nbVoyelles += 1;
    }
  }

  while (nbVoyelles < 2) {
    mot.clear();
    choisirLettres();
  }

  return mot;
}

// Fonction qui vérfie si un mot existe dans le dictionnaire
Future<bool> existanceMot(String mot) async {
  try {
    final file = File('assets/dictionnaire.txt');
    final contents = await file.readAsString();

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

// Fonction pour transformer une liste de lettres en un dictionnaire où chaque lettre est une clé et le nombre de fois où elle apparait est la valeur
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

bool estInclus(Map mot1, Map mot2) {
  for (var entry in mot1.entries) {
    var cle = entry.key;
    var valeur = entry.value;

    if (mot2.containsKey(cle)) {
      if (valeur > mot2[cle]) {
        return false;
      }
    } else {
      return false;
    }
  }
  return true;
}

Future<List<String>> trouverMotsPossibles(List<String> lettresDisponibles) async {
  final file = File('assets/dictionnaire.txt'); // Chargement du dictionnaire
  final contents = await file.readAsString(); // Chargement du dictionnaire
  List<String> tousLesMots = contents.split('\n'); // Lister tous les mots du dictionnaire sans le transformer en List<String>

  dictionnaire.clear(); // Vider le dictionnaire pour éviter de retrouver les mots de la partie précédente

  for (String mot in tousLesMots) {
    mot = mot.trim().toUpperCase(); // Les lettres en minuscules deviennent majuscules
    var dico = {};
    for (int i = 0; i < mot.length; i++) {
      String lettre = mot[i]; // On prend chaque lettre du mot
      if (dico.containsKey(lettre)) {
        // Si la lettre est déjà dans le dictionnaire
        dico[lettre] += 1; // On incrémente le nombre de fois qu'elle apparaît
      } else {
        dico[lettre] = 1; // Sinon, on l'ajoute
      }
    }
    dictionnaire.add(dico); // Ajouter le mot transformé en Map (ou dict en python) au dictionnaire
  }

  Map lettresMap = lettresToDico(lettresDisponibles);
  List<String> motsPossibles = [];

  // On parcourt tous les mots du dictionnaire et vérifier s'ils peuvent être formés avec les lettres disponibles
  for (int i = 0; i < tousLesMots.length; i++) {
    String mot = tousLesMots[i].trim().toUpperCase(); // On prend chaque mot du dictionnaire, on le transforme en majuscules et on enlève les espaces

    if (estInclus(dictionnaire[i], lettresMap)) {
      // On vérifie si le mot peut être formé avec les lettres disponibles
      motsPossibles.add(mot); // Si oui, on l'ajoute à la liste des mots possibles
    }
  }

  // En cas de problème, on retourne une liste vide
  if (motsPossibles.isEmpty) return [];

  // On cherche les mots les plus longs dans la liste des mots possibles
  int maxLength = motsPossibles.map((mot) => mot.length).reduce((max, length) => length > max ? length : max);

  // On filtre les mots pour ne garder que ceux qui ont la longueur maximale
  return motsPossibles.where((mot) => mot.length == maxLength).toList();
}
