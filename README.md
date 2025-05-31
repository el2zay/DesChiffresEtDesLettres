# Projet de NSI : Des Chiffres et des Lettres


## Installation
### macOS — Jeu Des Chiffres et Des Lettres
1. Téléchargez le fichier Des.Chiffres.et.des.Lettres.app.zip depuis les releases de ce repository. Puis décompressez-le.

2. Intel : Faites un clic droit sur le fichier .app et sélectionnez "Ouvrir" puis "Ouvrir quand même" pour contourner les restrictions de sécurité macOS.  

2. Apple Silicon : Suivez la vidéo ci-dessous.

https://github.com/user-attachments/assets/447717a8-3058-488e-9249-8e42ac4c4beb

### macOS — Jeu Lettres (CLI) 
> Le jeu lettre est aussi disponible en version console.
1. Téléchargez le fichier Jeu.lettre.CLI.zip depuis les releases de ce repository. Puis décompressez-le.

2. Ouvrez le terminal dans le dossier décompressé
   
3. Exécutez la commande `chmod +x ./lettres` Puis `./lettres`

4. Suivez la vidéo ci-dessous

https://github.com/user-attachments/assets/02715d0e-4dc1-4b92-a44e-eb044364eaf7


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
