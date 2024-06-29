# -*- coding: utf-8 -*-
"""
Created on Sat Jan  6 08:30:18 2018

@author: leplumey

Module de gestion des codes-barres
"""

# Importation module expressions régulières
import re

class EAN13:
    LGEAN13=13
    
    def __init__(self,code="3333299304137"):
        self.code=code
        self.valide=self.verification()
        
    # Vérification du code-barre et ajout si nécessaire du chiffre de contrôle    
    def verification(self):
        #verifie qu'il n'y a pas autre chose qu'un nombre dans la chaîne de caractère
        if re.compile("\D").search(self.code)!=None:
            return(False)
        if (len(self.code) == 13):
            verif = EAN13.cle(self)
            if(self.code[11]==verif):
                return(True)
        else:
            self.code + EAN13.cle(self)
        return(False)
    
    # Calcul du chiffre de contrôle rendu sous forme de chaine de caractères        
    def cle(self):
        res=0
        for k in range (0, 11, 2) :
            res += int(self.code[k]) + int(self.code[k+1])*3
        if (res%10==0):
            res =0
        else:
            res= 10 - (res%10)
        return(str(res))
        
# Programme principal
if __name__ == "__main__":
    ean13=EAN13("732195134545")
    print(ean13.cle())

    # Liste de DVD récents
    lst=["3333299304137","3344428069940","3475001049988","3475001052476","3475001054487",\
         "3700724902778","5051889599852","5051889606659","5051889606666","7321950126194"]
    print("Test de la classe EAN13 sur {0} codes".format(len(lst)))
    for i in range(len(lst)):
        ean13=EAN13(lst[i])
        
    
