<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
   <!-- Paramétrage de la sortie au format html --> 
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Gestion des espaces parasites -->
    <xsl:strip-space elements="*"/>
    
    <!-- Configuration des sorties HTML -->
    <xsl:template match="/">
        <!-- Récupération du nom et du chemin du fichier courant -->
        <xsl:variable name="file">
            <xsl:value-of select="replace(base-uri(./edition_numerique), '.xml', '')"/>
        </xsl:variable>
        <!-- Définition des variables contenant les chemins vers chaque page HTML -->
        <!--Vers la page d'accueil qui est également celle d'affichage de la lettre éditée -->
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($file,'accueil','.html')"/>
        </xsl:variable>
        <!--Vers la page affichant les métadonnées des éditions imprimée et numérique de la correspondance -->
        <xsl:variable name="pathPresentation">
            <xsl:value-of select="concat($file,'presentation','.html')"/>
        </xsl:variable>
        <!--Vers la page affichant les données du contexte épistolaire d'où la lettre éditée est extraite -->
        <xsl:variable name="pathContexteEpistolaire">
            <xsl:value-of select="concat($file,'contexteEpistolaire','.html')"/>
        </xsl:variable>
        <!--Vers la page de l'index des personnes -->
        <xsl:variable name="pathIndexPers">
            <xsl:value-of select="concat($file,'indexpers','.html')"/>
        </xsl:variable>
        <!--Vers la page de l'index des lieux -->
        <xsl:variable name="pathIndexLieux">
            <xsl:value-of select="concat($file,'indexlieux','.html')"/>
        </xsl:variable> 
        <!--Vers la page du dictionnaire contenant à la fois le dictionnaire des personnes et le dictionnaire des lieux -->
        <xsl:variable name="pathDico">
            <xsl:value-of select="concat($file,'dico','.html')"/>
        </xsl:variable> 
        <!-- Vers la page du glossaire contenant les définitions synchroniques des mots -->
        <xsl:variable name="pathGlossaire">
            <xsl:value-of select="concat($file,'glossaire','.html')"/>
        </xsl:variable>  
        
        <!-- Définition des variables contenant les éléments communs à toutes les pages html -->
          
        <!-- Métadonnées -->
        <xsl:variable name="background">
                <head>
                     <link rel="stylesheet" type="text/css" href="csssevigne.css"/>
                     <meta charset="UTF-8"/>
                     <title>Transformation HTML des lettres de Madame de Sévigné</title>       
                     <meta name="author" content="Pauline Breton-Chauvet"/>
                </head>
                <!-- En-tête de chaque page -->
                <div class="background" >
                    <div class="titres">
                        <!-- Sélection du titre du tome d'où la lettre éditée est extraite, avec pour sous-titre l'intitulé de l'ensemble de la correspondance -->
                        <h1>
                            <xsl:value-of select="//fileDesc/titleStmt[1]/title"/>
                        </h1>
                        <h2>
                            <xsl:value-of select="//seriesStmt/respStmt/resp"/>
                        </h2>
                    </div>
                </div>
            </xsl:variable>

            <!-- Barre de navigation -->
            <xsl:variable name="navbar">
                  <nav class="nav">
                        <ul>
                            <li class="nav-link">
                                <a href="{$pathPresentation}">Présentation</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$pathAccueil}">Lettre 1287</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$pathIndexPers}">Index des individus</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$pathIndexLieux}">Index des lieux</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$pathContexteEpistolaire}">Contexte épistolaire</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$pathGlossaire}">Glossaire</a>
                            </li>
                            <li class="nav-link">
                                <a href="{$pathDico}">Dictionnaire</a>
                            </li>
                        </ul>
                    </nav> 
                  </xsl:variable>

             <!-- Bas-de-page contenant la mention de responsabilité de l'édition numérique -->
             <xsl:variable name="footer">
                    <div class="footer">
                        <xsl:value-of select="concat(//fileDesc/titleStmt/respStmt/resp, ' par Pauline Breton-Chauvet')"/>
                        <br/>
                        <br/>
                        <xsl:value-of select="//fileDesc/publicationStmt/p"/>
                    </div>
             </xsl:variable>
           
        <!-- Définition des sorties pour chaque page html -->
        <!-- Page d'accueil -->
          <xsl:result-document href="{$pathAccueil}" method="html" indent="yes">
          <html>
              <!-- Je récupère les valeurs des variables 'background' et 'navbar' pour afficher les éléments d'en-tête ainsi que la barre de navigation -->
             <xsl:copy-of select="$background"/>
              <body>
                  <xsl:copy-of select="$navbar"/>
                  <div class="lettre">
                      <div align="center">
                         <!-- Récupération de l'intitulé de la lettre en valeur de titre, et de la formule d'ouverture en sous-titre -->
                       <h3><xsl:value-of select="//biblScope[@unit='letter']"/></h3>
                       <h4><xsl:value-of select="//body/div/opener"/></h4>
                      </div>
                          <xsl:copy select="/TEI//div">
                              <!-- Pour chaque paragraphe, je récupère et affiche le contenu des éléments enfants -->
                              <xsl:for-each select="p">
                                  <p>
                                      <xsl:apply-templates/>
                                  </p>
                              </xsl:for-each>
                              <!-- Récupération et affichage de la formule de conclusion de la lettre-->
                              <xsl:value-of select="//closer"/>
                          </xsl:copy>
                      </div>
                  <!-- La valeur de la variable 'footer' permet d'afficher les éléments de bas de page -->
                  <xsl:copy-of select="$footer"/>
              </body>
          </html>
          </xsl:result-document>
             
            <!-- Page de présentation de la source, imprimée et numérique -->
           <xsl:result-document href="{$pathPresentation}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$background"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                        <div>
                            <div class="lettre">
                              <xsl:call-template name="presentation"/>
                              </div>
                        </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
           </xsl:result-document>
        
        <!-- Page de l'index des individus -->
        <xsl:result-document href="{$pathIndexPers}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$background"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <div class="lettre">
                        <h3>INDEX DES NOMS DE PERSONNES</h3>                                                           
                       <div>
                          <!-- Affichage des éléments du template 'indexPers', dont les règles sont définies dans la suite de la feuille de transformation -->
                           <xsl:call-template name="indexPers"/>
                       </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Page de l'index des lieux -->
        <xsl:result-document href="{$pathIndexLieux}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$background"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <div class="lettre">
                        <h3>INDEX DES NOMS DE LIEUX</h3>
                        <div>
                            <xsl:call-template name="indexLieux"/>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Page de présentation du contexte épistolaire -->
        <xsl:result-document href="{$pathContexteEpistolaire}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$background"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <div class="lettre">
                        <h1>Contexte épistolaire</h1>
                        <div>
                            <xsl:call-template name="contexteEpistolaire"/>
                        </div>
                    </div> 
                </body>
                <xsl:copy-of select="$footer"/>
            </html>
        </xsl:result-document>
        
        <!-- Page du dictionnaire contenant à la fois le dictionnaire des individus et le dictionnaire des lieux -->
        <xsl:result-document href="{$pathDico}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$background"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <div class="lettre">
                        <h1>Dictionnaire des individus</h1>
                        <div>
                            <xsl:call-template name="dicoPers"/>
                        </div>
                        <h1>Dictionnaire des lieux</h1>
                        <div>
                            <xsl:call-template name="dicoLieux"/>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Page du glossaire -->
        <xsl:result-document href="{$pathGlossaire}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$background"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <div class="lettre">
                        <h1>Glossaire</h1>
                        <div>
                            <xsl:call-template name="glossaire"/>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
        
      <!-- Règles spécifiques (appelées à l'aide de call-template)-->
    
    <!-- Règle pour la page de présentation des sources imprimée et numérique de la page éditée-->
    <xsl:template name="presentation">
       <!-- En amont de la définition de la règle pour la page de présentation, création d'une variable permettant de structurer l'affichage des noms d'auteurs avec leurs prénoms et leurs éventuelles particules -->
        <xsl:variable name="nomAuteur">
            <!-- Pour chaque auteur...-->
            <xsl:for-each select="//sourceDesc//seriesStmt//persName">
                <!-- récupération du prénom... -->
                <xsl:value-of select="forename"/> 
                <!-- de l'éventuelle particule... -->
                <xsl:if test="nameLink">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="nameLink"/>
                </xsl:if>
                <xsl:text> </xsl:text>
                <!-- de son nom de famille... -->
                <xsl:value-of select="surname"/>
                <!-- de son titre/statut -->
                <xsl:if test="roleName">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="roleName"/>
                    <xsl:text>); </xsl:text>
                </xsl:if>         
            </xsl:for-each>
        </xsl:variable>  
    <xsl:copy select="//sourceDesc">
        <h3>Édition imprimée</h3>
        <ul><b>Titre: </b><xsl:value-of select="//titleStmt/title[1]"/><xsl:text> </xsl:text><xsl:value-of select="//sourceDesc//notesStmt/note[2]"/></ul>
        <ul><b>Sous-titre: </b><xsl:value-of select="//biblScope[@unit='volume']"/></ul>
        <ul><b>Auteur(s): </b><xsl:value-of select="$nomAuteur"/></ul>
        <ul><b>Éditeur: </b><xsl:value-of select="//titleStmt/editor/forename/text()"/><xsl:text> </xsl:text><xsl:value-of
            select="//titleStmt/editor/surname/text()"/></ul>
        <ul><b>Lieu d'édition: </b><xsl:value-of select="//publicationStmt/pubPlace"/></ul>
        <ul><b>Maison d'édition: </b><xsl:value-of select="//publicationStmt/publisher"/></ul>
        <ul><b>Date d'édition: </b><xsl:value-of select="//publicationStmt/date[@type='premiere_edition']"/></ul>
        <ul><b>Organisme responsable de la diffusion: </b><xsl:value-of select="//publicationStmt/distributor"/></ul>
        <ul><b>Notice: </b><a href="https://catalogue.bnf.fr/ark:/12148/cb30487834x">https://catalogue.bnf.fr/ark:/12148/cb30487834x</a></ul>
        <ul><b>Licence: </b><xsl:value-of select="//publicationStmt/availability"/></ul>
        <h3>Extrait objet de l'édition numérique</h3>
        <ul><b>Intitulé: </b><xsl:value-of select="//biblScope[@unit='letter']"/></ul>
        <ul><b>Reproduction numérique: </b><a href="https://gallica.bnf.fr/ark:/12148/bpt6k6323006w/f11.item">https://gallica.bnf.fr/ark:/12148/bpt6k6323006w/f11.item</a></ul>
        <ul><b>Pagination: </b><xsl:value-of select="//biblScope[@unit='page']"/></ul>
        <ul><b>Note: </b><xsl:value-of select="//notesStmt/note[1]"/></ul>
        <ul><b>Normalisation: </b><xsl:value-of select="//encodingDesc/editorialDecl/normalization"/></ul>  
    </xsl:copy>
    </xsl:template>
    
      <!-- Règle pour l'index des personnes -->
        <xsl:template name="indexPers">
           <!-- Récupération structurée des entrées de l'index des personnes du teiHeader -->
            <xsl:for-each select="//particDesc//person/persName">
                <!-- Tri dans l'ordre alphabétique ascendant par le nom de famille -->
                <xsl:sort select="surname" order="ascending"/>   
                <li>
                <!-- Affichage d'une ligne avec le nom de famille, la particule si elle existe et le nom de famille -->
                    <span style="font-weight:bold;">
                        <xsl:value-of select="surname"/>
                        <xsl:if test="nameLink">
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="nameLink"/>
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </span>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="forename"/>
                    <xsl:text> (</xsl:text>
                    <!--Affichage du titre/statut s'il existe-->
                    <xsl:if test="roleName">
                       <xsl:value-of select="roleName"/>
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <!-- Affichage des dates de naissance et de mort si elles existent. Sinon, une croix en substitution -->
                    <xsl:choose>
                        <xsl:when test="following-sibling::birth and following-sibling::death">
                            <xsl:value-of select="following-sibling::birth"/>
                            <xsl:text>-</xsl:text>
                            <xsl:value-of select="following-sibling::death"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>†</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    <!-- Création d'un renvoi vers la notice data.bnf.fr -->
                    <xsl:if test="idno">
                        <xsl:text>, voir </xsl:text>
                        <a href="{idno}">notice data.bnf.fr</a>
                    </xsl:if>
                    <xsl:text>)</xsl:text>
                    <!-- Création d'une variable utilisée ensuite pour récupérer l'id de chaque individu-->
                    <xsl:variable name="idPerson">
                        <xsl:value-of select="parent::person/@xml:id"/>
                    </xsl:variable>
                    <xsl:text> : </xsl:text>
                    <!-- Pour chaque individu, récupération des occurences de son nom dans les pages de la lettre éditée et indication des pages où il/elle est mentionné(e)-->
                    <xsl:for-each-group select="ancestor::TEI//body//persName[replace(@ref, '#','')=$idPerson]" group-by="ancestor::p[@n]">
                        <xsl:text>Page</xsl:text>
                        <!-- Si la valeur de l'attribut @n de l'ancêtre <p> du noeud courant <persName> est égale à 1, mention de la page pour l'individu. 'group-by' permet de regrouper les mentions de page récurrentes en une seule mention. La même règle est répétée pour les pages suivantes de la lettre -->
                        <xsl:if test="ancestor::p[@n='1']">
                            <xsl:value-of select="ancestor::p/@n"/>
                        </xsl:if>
                        <xsl:if test="ancestor::p[@n='2']">
                            <xsl:value-of select="ancestor::p/@n"/>
                        </xsl:if>
                        <xsl:if test="ancestor::p[@n='3']">
                            <xsl:value-of select="ancestor::p/@n"/>
                        </xsl:if>
                        <xsl:if test="ancestor::p[@n='4']">
                            <xsl:value-of select="ancestor::p/@n"/>
                        </xsl:if>
                        <xsl:if test="ancestor::p[@n='5']">
                            <xsl:value-of select="ancestor::p/@n"/>
                        </xsl:if>
                        <!-- Si une mention de page n'est pas la dernière, elle est suivie d'une virgule pour la séparer de la mention d'une autre page-->
                        <xsl:if test="position()!= last()">, </xsl:if>
                        <xsl:if test="position() = last()"> </xsl:if>
                    </xsl:for-each-group>   
                </li>  
                </xsl:for-each> 
        </xsl:template>
    
    <!-- Création des hyperliens vers le dictionnaire des individus à partir de leurs mentions dans la lettre éditée -->
    <xsl:template match="body//persName">
        <a href="dico.html">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
         
    <xsl:template name="dicoPers">
        <!-- Sur le modèle du template pour l'index des individus, récupération de chaque personne recensée, affichée dans l'ordre alphabétique ascendant par le nom de famille -->
        <xsl:for-each select="//particDesc//person/persName">
            <xsl:sort select="surname" order="ascending"/>   
                <br/>
               <li>
                <span style="font-size:25;"><b>
                    <xsl:value-of select="surname"/>
                    <xsl:if test="nameLink">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="nameLink"/>
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </b>
                </span>
                <xsl:text> </xsl:text>
                <xsl:value-of select="forename"/>
                <xsl:text> (</xsl:text>
                <!--Affichage de son titre/statut -->
                <xsl:if test="roleName">
                    <xsl:value-of select="roleName"/>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <!-- Même règle que pour l'affichage des dates de naissance et de mort dans l'index des individus -->
                <xsl:choose>
                    <xsl:when test="following-sibling::birth and following-sibling::death">
                        <xsl:value-of select="following-sibling::birth"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="following-sibling::death"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>†</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>)</xsl:text>
            </li>
            <!-- Récupération et affichage des fonctions/responsabilités de l'individu si elles sont renseignées dans le document source -->
            <xsl:if test="following-sibling::occupation">
                <h5><i>Fonction(s)/Rôle</i></h5>
                <xsl:value-of select="following-sibling::occupation"/>
                <br/>
            </xsl:if>
            <!-- Récupération et affichage de(s)/de la résidence(s) si celle(s)-ci est/sont renseignée(s) dans le document source -->
            <xsl:if test="following-sibling::residence">
                <h5><i>Résidence</i></h5>
                <xsl:value-of select="following-sibling::residence"/>
                <br/>
            </xsl:if>
            <!-- Récupération et affichage d'une présentation biographique en rapport avec la correspondance de la marquise de Sévigné, si elle existe -->
            <xsl:if test="following-sibling::note">
                <h5><i>Présentation</i></h5>
                <xsl:value-of select="following-sibling::note"/>
                <br/>
            </xsl:if>
            <!-- Récupération et affichage des informations bibliographiques inhérentes à la personne - si elles existent -, avec un renvoi vers la notice s'il y en a une -->
            <xsl:if test="following-sibling::bibl">
              <h5><i>Bibliographie</i></h5>
                <xsl:for-each select="parent::person/bibl">
               <xsl:value-of select="author"/>, <i><xsl:value-of select="title"/></i>, <xsl:value-of select="publisher"/>, <xsl:value-of select="date"/>     
                  <xsl:if test="idno">
                 <br/>
                 <a href="{idno}">Voir notice</a>
                 <br/>
             </xsl:if>
               </xsl:for-each>     
            </xsl:if>  
        </xsl:for-each> 
    </xsl:template>
    
    <!-- Règle pour l'index des lieux -->
    <xsl:template name="indexLieux">
        <!-- A l'instar de l'index des individus, récupération de chaque lieu recensé dans l'index du teiHeader-->
       <xsl:for-each select="//listPlace/place">
           <!-- Chaque lieu est affiché selon un tri alphabétique ascendant -->
           <xsl:sort select="name" order="ascending"/>
           <!-- Création d'une ligne qui affiche...-->
            <li>
               <span style="font-weight:bold;">
               <!-- le nom du lieu en gras... -->
               <xsl:value-of select="placeName/name"/>
               </span>
                <xsl:choose>
                    <!-- le nom de la localité et du pays ou juste du pays (pour éviter une redondance) -->
                    <xsl:when test="location/settlement">
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="location/settlement"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="location/country"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="location/country"/>
                        <xsl:text>)</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <!-- Création d'une variable utilisée ensuite pour récupérer l'id de chaque lieu -->
                <xsl:variable name="idPlace">
                    <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <!-- Pour chaque lieu, récupération de ses occurences dans les pages de la lettre éditée et indication des pages où il/elle est mentionné(e)-->
                <xsl:for-each-group select="ancestor::TEI//body//placeName[replace(@ref, '#','')=$idPlace]" group-by="ancestor::p[@n]">
                    <xsl:text>Page</xsl:text>
                    <!-- Si la valeur de l'attribut @n de l'ancêtre <p> du noeud courant <placeName> est égale à 1, mention de la page pour le lieu. 'group-by' permet de regrouper les mentions de page récurrentes en une seule mention. La même règle est répétée pour les pages suivantes de la lettre -->
                    <xsl:if test="ancestor::p[@n='1']">
                        <xsl:value-of select="ancestor::p/@n"/>
                    </xsl:if>
                    <xsl:if test="ancestor::p[@n='2']">
                        <xsl:value-of select="ancestor::p/@n"/>
                    </xsl:if>
                    <xsl:if test="ancestor::p[@n='3']">
                        <xsl:value-of select="ancestor::p/@n"/>
                    </xsl:if>
                    <xsl:if test="ancestor::p[@n='4']">
                        <xsl:value-of select="ancestor::p/@n"/>
                    </xsl:if>
                    <xsl:if test="ancestor::p[@n='5']">
                        <xsl:value-of select="ancestor::p/@n"/>
                    </xsl:if>
                    <!-- Si une mention de page n'est pas la dernière, elle est suivie d'une virgule pour la séparer de la mention d'une autre page -->
                    <xsl:if test="position()!= last()">, </xsl:if>
                    <xsl:if test="position() = last()"> </xsl:if>
                </xsl:for-each-group> 
              </li>
       </xsl:for-each>    
    </xsl:template>
    
    <!-- Création des hyperliens vers le dictionnaire des lieux (qui succède directement à celui des individus sur la même page) à partir de leurs mentions dans la lettre éditée et affichée en page d'accueil -->
    <xsl:template match="body//placeName">
        <a href="dico.html">
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
        
    <!-- Règle pour le dictionnaire des lieux, qui succède au dictionnaire des individus sur la page de dictionnaire -->
    <xsl:template name="dicoLieux">
        <xsl:for-each select="//listPlace/place">
            <xsl:sort select="name" order="ascending"/>
            <br/>
            <li>
                <span style="font-size:25;">
                 <b>
                    <xsl:value-of select="placeName/name"/>
                </b>
                </span>
                <xsl:choose>
                    <!-- nom de la localité et du pays ou juste du pays (pour éviter une redondance) -->
                    <xsl:when test="location/settlement">
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="location/settlement"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="location/country"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="location/country"/>
                        <xsl:text>)</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </li>
            <!-- Récupération et affichage des coordonnées géographiques du lieu si elles sont renseignées dans le document source -->
            <xsl:if test="location/geo">
                <h5><i>Coordonnées géographiques</i></h5>
                <xsl:value-of select="location/geo"/>
                <br/>
            </xsl:if>
            <!-- Description - si elle est renseignée - en rapport avec le contexte de la correspondance de la marquise de Sévigné -->
            <xsl:if test="note">
                <h5><i>Description</i></h5>
                <xsl:value-of select="note"/>
                <br/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Règle pour l'affichage du contexte épistolaire de la lettre éditée, avec les informations inhérentes à la lettre qui lui précède et à celle qui lui succède -->
    <xsl:template name="contexteEpistolaire">
        <xsl:copy select="//correspDesc">
            <div>
                <div class="col-2">
                <h3 align="center">Lettre précédente</h3>
                    <ul><b>Date: </b><xsl:value-of select="correspContext/ref[@type='prev']/date"/></ul>
                    <ul><b>Expéditrice: </b><xsl:value-of select="correspContext/ref[@type='prev']/persName[1]/forename"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='prev']/persName[1]/nameLink"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='prev']/persName[1]/surname"/><xsl:text>, </xsl:text><xsl:value-of select="correspContext/ref[@type='prev']/persName[1]/roleName"/>.</ul>
                    <ul><b>Réceptrice: </b><xsl:value-of select="correspContext/ref[@type='prev']/persName[2]/forename"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='prev']/persName[2]/nameLink"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='prev']/persName[2]/surname"/><xsl:text>, </xsl:text><xsl:value-of select="correspContext/ref[@type='prev']/persName[2]/roleName"/></ul>
                    <ul><b>Résumé: </b><xsl:value-of select="correspContext/ref[@type='prev']/note"/></ul>
                    <h3 align="center">Lettre suivante</h3>
                    <ul><b>Date: </b><xsl:value-of select="correspContext/ref[@type='next']/date"/></ul>
                    <ul><b>Expéditrice: </b><xsl:value-of select="correspContext/ref[@type='next']/persName[1]/forename"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='next']/persName[1]/nameLink"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='next']/persName[1]/surname"/><xsl:text>, </xsl:text><xsl:value-of select="correspContext/ref[@type='next']/persName[1]/roleName"/>.</ul>
                    <ul><b>Réceptrice: </b><xsl:value-of select="correspContext/ref[@type='next']/persName[2]/forename"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='next']/persName[2]/nameLink"/><xsl:text> </xsl:text><xsl:value-of select="correspContext/ref[@type='next']/persName[2]/surname"/><xsl:text>, </xsl:text><xsl:value-of select="correspContext/ref[@type='next']/persName[2]/roleName"/></ul>
                    <ul><b>Résumé: </b><xsl:value-of select="correspContext/ref[@type='next']/note"/></ul>
                </div>
            </div>
       </xsl:copy>
        <div>           
            <img src="portrait_sevigne.jpg" float="right" alt="portrait marquise de sevigne" title="Portrait de la marquise de Sévigné"/> 
        </div>
    </xsl:template>
    
    <!-- Règle pour l'affichage du glossaire -->
    <xsl:template name="glossaire">
        <xsl:for-each select="//body/div/p/emph">
            <xsl:sort select="note/@xml:id" order="ascending"/>   
            <li>
                <span style="font-weight:bold;">
                    <xsl:value-of select="note/@xml:id"/>
                </span>
                <ul><i>Définition: </i><xsl:value-of select="note/interp"/></ul>
                <!-- Renvoi vers la notice Furetière d'où est extraite la définition synchronique de chaque mot recensé -->
                <ul><a href="{note/interp/@facs}">Voir notice Furetière</a></ul>
            </li>
        </xsl:for-each>
    </xsl:template> 
    
    <!-- Création des hyperliens vers le glossaire depuis les mots définis dans la lettre éditée -->
    <xsl:template match="body/div/p/emph">
        <a href="glossaire.html">
            <xsl:value-of select="note/text()"/>
        </a>
    </xsl:template>
    
    <!-- Règle pour la mise en forme des régularisations inhérentes à la conjugaison -->
    <xsl:template match="body/div/p/choice">
      <!-- Pour chaque séquence de régularisation, cette dernière est indiquée entre parenthèses avant l'affichage de la forme d'origine -->
        <xsl:text>(</xsl:text>
           <xsl:value-of select="reg"/>
        <xsl:text>) </xsl:text>
        <xsl:value-of select="orig"/>
        <xsl:text> </xsl:text>
    </xsl:template>
    

</xsl:stylesheet>