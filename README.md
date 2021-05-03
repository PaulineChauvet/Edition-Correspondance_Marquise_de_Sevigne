# Édition-Correspondance_Marquise_de_Sevigne

Ce dépôt contient l'ensemble des éléments nécessaires à l'édition numérique d'un extrait (lettre 1287) de la correspondance de Marie de Rabutin-Chantal, dite Marquise de Sévigné.
Il comprend: 
- un document encodé selon les principes de la ```TEI```
- un schéma ```RNG```
- une ```ODD``` aux formats ```XML``` et ```HTML``` 
- un fichier ```XSL``` et les fichiers ```HTML```générés par la transformation.

L'indexation et l'affichage structuré des données contextuelles, textuelles, prosopographiques et lexicales doivent permettre la reconstitution des sphères de sociabilité et de représentation dans laquelle évolue l'illustre Madame de Sévigné, tout en réinsérant la source décrite dans l'ensemble épistolaire dont elle est interdépendante. 
Les pages issues de la transformation vers html forment un site affichant: une présentation des sources imprimée et numérique, l'édition de la lettre 1287 enrichie d'hyperliens, un glossaire, une restitution du contexte épistolaire, un index des lieux, un index des personnes, un dictionnaire comprenant un dictionnaire des individus et un dictionnaire des lieux.

L'ensemble des éléments se trouve dans le dossier `edition_numerique`. Pour ouvrir le site html, ouvrir [accueil.html](edition_numerique/accueil.html).

Rappel des consignes générales des évaluations XML et XSLT ci-dessous.

## Évaluation ```TEI```

### Consignes générales

* Structurer le texte en ```XML-TEI``` en vue d’une édition et en respectant le genre littéraire auquel il appartient ;
* Compléter de la manière la plus précise possible le teiHeader de l'édition, en fonction des éléments nécessaires à son établissement et à la compréhension du texte ;
* Écrire un schéma ```ODD``` adapté à l'encodage et documenté.
  - Générer une ```ODD``` à partir de oddbyexample et associer le schéma rng correspondant au fichier ```XML```.
	- À partir de l'```ODD```, générer la documentation ```HTML``` du projet.
		- Présenter en introduction le projet et ses exploitations possibles ;
		- Documenter le fonctionnement de l'encodage et le choix des balises.
* Créer une feuille de transformation simple ;
* Maîtriser ```XPath```et ses fonctions de base ;

### Consignes de l'édition d'une correspondance

* Télécharger le texte via l’interface de Gallica ;
* Nettoyer le texte (doubles espaces, problème sur les caractères accentués, coquilles…) ;
* Structurer le texte en prenant en compte le genre de la correspondance ;
* Ajouter dans le texte toutes les notes nécessaires à la compréhension du texte ;
* Signaler dans le texte les dates, les noms de personnages, les noms de lieux ;
* Faire un index des noms de personnages et de lieux ;
* Compléter le TEIheader ;
* Écrire l’```ODD``` la plus restrictive possible en fonction de votre encodage ;
* Ajouter dans votre ```ODD``` la documentation sur votre projet d’encodage, les éléments que vous avez encodés : pourquoi et comment, et quels pourront être à terme les usages de votre édition.

## Évaluation ```XSLT```

### Consignes générales

* Mettre en place une structure d'accueil en ```HTML``` ;
* Rédiger des règles simples avec un ```XPath``` valide pour insérer des informations du document source dans le document de sortie ;
* Créer une ou des règles avec des conditions ;
* Utiliser une ou des règles avec ```<xsl:for-each>``` *(uniquement si cela est nécessaire)* ;
* Proposer un code facile à lire et commenté ;
* Simplifier le plus possible ses règles ```XSL```.

## Crédits

Les illustrations d'arrière-plan et du contexte épistolaire proviennent des bases de données Joconde et Paris Musées Collections.
