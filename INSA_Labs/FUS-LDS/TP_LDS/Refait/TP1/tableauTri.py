# -*- coding: utf-8 -*-
# ...
from random import randint
import copy
from time import time


# La classe TriTablau contient un tableau de valeurs numériques et des méthodes
# travaillant sur ce tableau
class TableauTri:
    # Le constructeur qui alloue un tableau vide ou d'une certaine taille
    # en fonction du paramètre
    def __init__(self, taille=-1):
        self.tab = []
        for i in range(taille):
            self.tab.append(None)

    # Initialisation d'un tableau avec l'ajout de valeurs
    def initialiserTableau(self, *t):
        self.tab = []
        for e in t:
            self.tab.append(e)
        return self.tab

    # Initialisation d'un tableau déjà dimmensionné avec des valeurs aléatoires
    def initialiserAleatoire(self, vmin, vmax):
        for k in range(len(self.tab)):
            self.tab[k] = (randint(vmin, vmax))
        return self.tab

    # Création d'un nouveau tableau identique à celui qui sert à appeler la méthode
    def copie(self):
        nvTab = copy.deepcopy(self)
        return nvTab

    # Affichage du tableau
    def afficher(self):
        print(self.tab)

    # Tri par sélection du tableau contenu dans la classe
    def triSelection(self):
        for i in range(len(self.tab)):
            m = i
            for j in range(i + 1, len(self.tab), 1):
                if (self.tab[j] < self.tab[m]):
                    m = j
            if (m != i):
                tmp = self.tab[i]
                self.tab[i] = self.tab[m]
                self.tab[m] = tmp
        return (self.tab)

    def triInsertion(self):
        for i in range(len(self.tab)):
            x = self.tab[i]
            j = i
            while (j > 0 and self.tab[j - 1] > x):
                self.tab[j] = self.tab[j - 1]
                j = j - 1
            self.tab[j] = x
        return self.tab

    def triABulles(self):
        for i in range(len(self.tab) - 1, 1, -1):
            tableauTrie = True
            for j in range(i):
                if self.tab[j + 1] < self.tab[j]:
                    tmp = self.tab[j + 1]
                    self.tab[j + 1] = self.tab[j]
                    self.tab[j] = tmp
                    tableauTrie = False
            if (tableauTrie):
                return self.tab
        return self.tab

    def partitionner(self, premier, dernier, pivot):
        mem = self.tab[dernier]
        self.tab[dernier] = self.tab[pivot]
        self.tab[pivot] = mem
        j = premier
        for i in range(premier, dernier):
            if self.tab[i] <= self.tab[dernier]:
                mem = self.tab[i]
                self.tab[i] = self.tab[j]
                self.tab[j] = mem
                j = j + 1
        mem = self.tab[dernier]
        self.tab[dernier] = self.tab[j]
        self.tab[j] = mem
        return j

    def triRapide(self, premier, dernier):
        if (premier < dernier):
            pivot = randint(premier, dernier)
            pivot = self.partitionner(premier, dernier, pivot)
            self.triRapide(premier, pivot - 1)
            self.triRapide(pivot + 1, dernier)

    def triRapide2(self):
        self.triRapide(0, len(self.tab) - 1)

    def instrumentaliser(self, fct):
        debut = time()
        # Appel de la fonction à instrumentaliser
        fct()
        print("Durée d'exécution : " + str(time() - debut))


if __name__ == "__main__":
    """
    # Test constructeur d'un tableau vide   
	t1=TableauTri()
    # Test ajout de valeurs au tableau    
	t1.initialiserTableau(5,4,3,7,6,2,1,10,8,9)
    # Test tri par sélection    
	t1.triSelection()
    # Test tri et affichage    
	t1.afficher()
    # Test constructeur d'un tableau d'une taille donnée   
	t2=TableauTri(10)
    # Test remplissage aléatoire d'un tableau dimensionné    
	t2.initialiserAleatoire(0,50)
    # Test copie de tableau    
	t3=t2.copie()
    # Test tri et affichage sur la copie    
	t3.triSelection()
    # Les deux affichages suivants doivent donner des valeurs différentes
	t2.afficher()
	t3.afficher()
    """
    t4 = TableauTri(5000)
    t4.initialiserAleatoire(0, 5000)
    t4.instrumentaliser(t4.triSelection)
    t4.instrumentaliser(t4.triInsertion)
    t4.instrumentaliser(t4.triABulles)
    t4.instrumentaliser(t4.triRapide2)
