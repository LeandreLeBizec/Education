import re
from Q2 import Automate

class AutomateComptage(Automate):
    # Constructeur
    def __init__(self):
        super().__init__()
        self.struct["Nombre occurences"]=0
        # Description de l'automate
        self.automateDon={0: [[r"(INDI)",0,self.trait]]}

    # Traitement spécifique pour une ligne donnée
    def trait(self,m1):
        self.struct["Nombre occurences"]=self.struct["Nombre occurences"]+1


if __name__ == "__main__":
    autocpt = AutomateComptage()
    structure=autocpt.analyser("resultat.txt")
    print(structure)
