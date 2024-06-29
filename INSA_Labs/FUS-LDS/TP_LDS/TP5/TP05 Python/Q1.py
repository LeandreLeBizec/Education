import re
# Fonction de recherche des sabotiers
def listePatronymes(nom, dct):
    f = open(nom,'r')
    etat=0
    reg1=re.compile(r"\bINDI\b") 
    name =""
    # …
    for ligne in f:
        if (etat==0):     # Etat initial
            reg1=re.compile(r"\bINDI\b")
            res=reg1.search(ligne)
            if res!=None: # Etat individu détecté
                etat=1
        elif (etat==1):
            reg1=re.compile(r"\bNAME\b.*\/(.*)\/$")
            res=reg1.search(ligne)
            name = res.group(1)
            if res!=None: # Etat individu détecté
                etat=2
        elif (etat==2):
            reg1=re.compile(r"\bOCCU\b.*sabot.*")
            res=reg1.search(ligne)
            if res!=None: # Etat individu détecté
                etat=3
            else:
                reg1=re.compile(r"\bINDI\b")
                res=reg1.search(ligne)
                if res!=None: # Etat individu détecté
                    etat=1
        elif (etat==3):
            if(name in dct):
                nb = dct[name]
                dct[name] = nb+1
            else:
                dct[name]=1
            #dct[name]+1
            etat=0
    f.close()
# Affichage d’un dictionnaire
def affichageDict(dct):
    for c in dct.keys():
        print(c," : ",dct[c])

# Programme principal
if __name__ == "__main__":
    dct={}
    listePatronymes("resultat.txt",dct)
    affichageDict(dct)
