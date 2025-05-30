# Projet de NSI : Des Chiffres et des Lettres


## Installation
### macOS
1. Téléchargez le fichier .zip depuis les releases de ce repository. Puis décompressez-le.

2. Intel : Faites un clic droit sur le fichier .app et sélectionnez "Ouvrir" puis "Ouvrir quand même" pour contourner les restrictions de sécurité macOS.  

2. Apple Silicon : Suivez la vidéo si dessous.
<video controls src="Installation.mov" title="Ouvrir le .app Apple Silicon"></video>

## Règles du jeu
* **Jeu lettres** : Le but est de former le plus de mots possible à partir de 9 lettres tirées au hasard. Chaque mot doit contenir au moins 2 lettres et être présent dans le dictionnaire français. Chaque lettre ne peut être utilisée qu'une seule fois par mot.

    Pour gagner, il faut trouver le.s mot.s le.s plus long.s possible.

* **Jeu chiffres** : Le but est d'atteindre un nombre cible en utilisant 6 chiffres tirés au hasard et les opérations de base. Chaque chiffre ne peut être utilisé qu'une seule fois.

    Pour gagner, il faut trouver une expression qui donne le résultat exact du nombre cible.

## Fonctions
* Jeu lettres
    * `choisirLettres()` : Choisit 9 lettres aléatoires avec au minimum 2 voyelles.
   
    * `existanceMot(String mot)` : Vérifie si le mot existe dans le dictionnaire.
    
    * `lettresToDico(List<String> lettres)` : Transforme une liste de lettres en un dictionnaire.

    *  `estInclus(Map mot1, Map mot2)` : Vérifie si le mot 1 est inclus dans le mot 2.

    * `trouverMotsPossibles(List<String> lettresDisponibles)` : Trouve tous les mots possibles à partir des lettres disponibles. Et renvoie les mots les plus longs.


* Jeu chiffres
    * `tirageChiffres()` : Tire 6 chiffres et choisis un nombre cible de manière aléatoire.

    * `calculer(String expression)` : Calcule le résultat d'une expression mathématique à partir de la chaîne de caractères `expression`.
