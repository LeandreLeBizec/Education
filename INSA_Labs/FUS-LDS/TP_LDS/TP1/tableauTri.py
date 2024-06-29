# -*- coding: utf-8 -*-
# ...
from random import randint
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
        for i in range(len(self.tab)):
            val=randint(vmin, vmax)
            self.tab[i] =val
        return self.tab
    # Création d'un nouveau tableau identique à celui qui sert à appeler la méthode
    def copie(self):
        nvTab=TableauTri(len(self.tab))
        for i in range(len(self.tab)):
            nvTab.tab[i]=self.tab[i]
        return nvTab
    # Affichage du tableau
    def afficher(self):
        print(self.tab)
    # Tri par sélection du tableau contenu dans la classe
    def triSelection(self):
        for i in range(len(self.tab)):
            m = i
            for j in range(i+1, len(self.tab), 1): #range(depart, arrive(non inclus), valeur d'incrementation)
                if self.tab[j]<self.tab[m]:
                    m=j
            if m != i:
                tmp = self.tab[i]
                self.tab[i]=self.tab[m]
                self.tab[m]=tmp        
        return self.tab
            
    
if __name__ == "__main__":
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
