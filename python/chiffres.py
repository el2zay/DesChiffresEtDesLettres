# Ici vous retrouverez le script python fait par Kenji pour la partie chiffre.

# Sa version en Dart se trouve dans lib/scripts/chiffres.dart

import random
import re

PETITS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] * 2
GRANDS = [25, 50, 75, 100]

def tirage_chiffres():
    tous_les_nombres = PETITS + GRANDS
    random.shuffle(tous_les_nombres)
    tirage = tous_les_nombres[:6]
    cible = random.randint(100, 999)
    return tirage, cible

def utiliser_uniquement_nombres(chaine, nombres):
    chiffres_utilises = re.findall(r'\d+', chaine)
    temp = nombres[:]
    try:
        for c in chiffres_utilises:
            n = int(c)
            if n in temp:
                temp.remove(n)
            else:
                return False
        return True
    except:
        return False

def jeu_chiffres():
    print("=== Jeu des chiffres ===")
    tirage, cible = tirage_chiffres()
    print("Nombres tirés :", tirage)
    print("Nombre à atteindre :", cible)

    solution = input("Entrez votre solution (ex: (100 + 25) * 3) : ")

    if not utiliser_uniquement_nombres(solution, tirage):
        print("Votre solution utilise des nombres non autorisés.")
        return

    try:
        resultat = eval(solution)
        if not isinstance(resultat, (int, float)):
            print("Résultat invalide.")
            return
        difference = abs(cible - resultat)
        print(f"Résultat obtenu : {resultat}")
        if difference == 0:
            print("Bravo ! Cible atteinte.")
        else:
            print(f"Écart par rapport à la cible : {difference}")
    except Exception as e:
        print("Erreur dans l'expression :", e)

jeu_chiffres()