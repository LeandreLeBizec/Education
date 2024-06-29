import re
from Q2 import Automate
class AutomateNomProf(Automate):
    # Constructeur
    def __init__(self):
        super().__init__()
        self.currentName = ""
        # Description de l'automate
        self.reIndi=[r"(INDI)",1, self.traitIndi]
        self.reName=[r"\bNAME\b.*\/(.*)\/$",2, self.traitName]
        self.reOccu=[r"\bOCCU\b\s*(.*?)\s*$",3, self.traitOccu]
        self.automateDon={0: [self.reIndi],
                         1: [self.reName, self.reIndi],
                         2: [self.reOccu, self.reIndi],
                         3: [self.reIndi]}

    # Traitement spécifique pour une ligne donnée
    def traitIndi(self,m1):
        return
    def traitName(self,m1):
        self.currentName= m1
    def traitOccu(self,m1):
        # Gestion du cas où le nom n’est pas présent
        if(not(self.currentName in self.struct)):
            self.struct[self.currentName]={}
        # Séparation des professions
        m1=re.compile(r"\s*\(.*?\)").sub("",m1)
        prof = m1.split(",")
            
        # Balayage des professions séparées
        for p in prof:
            print(p)
            # Cas d'une profession existante
            if ( p in self.struct[self.currentName]):
                self.struct[self.currentName][p]=self.struct[self.currentName][p]+1
            else:
                self.struct[self.currentName][p] =1

    # Impression de la structure
    def afficher(self):
        for cle1 in self.struct.keys():
            print(cle1," : ",end="")
            for cle2 in self.struct[cle1].keys():
                print(cle2+" ("+str(self.struct[cle1][cle2])+")",end=", ")
            print("") 
if __name__ == "__main__":
    auto = AutomateNomProf()
    structure=auto.analyser("resultat.txt")
    auto.afficher()
