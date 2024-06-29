from Q2 import Automate

import re


class AutomateNomProf(Automate):
    # Constructeur
    def __init__(self):
        super().__init__()
        # Description de l'automate
        self.reIndi=[r"\b(INDI)\b", 1, self.traitIndi]
        self.reName=[r"\bNAME\b.*/(.*)/", 2, self.traitName]
        self.reOccu=[r"\bOCCU\b\s+(.*?)\s*$", 3, self.traitOccu]
        self.automateDon={0: [self.reIndi],
                          1: [self.reName, self.reIndi],
                          2: [self.reOccu, self.reIndi],
                          3: [self.reIndi]}

    # Traitement spécifique pour une ligne donnée
    def traitIndi(self, m1):
        return

    def traitName(self, m1):
        self.name=m1

    def traitOccu(self, m1):
        # Gestion du cas où le nom n’est pas présent
        if not (self.name in self.struct):
            self.struct[self.name]={}
        # Séparation des professions
        m1 = re.compile(r"\s*\(.*?\)").sub("", m1)
        prof = m1.split(",")
        # Balayage des professions séparées
        for p in prof:
            # Cas d'une profession existante
            if p in self.struct[self.name]:
                self.struct[self.name][p] += 1
            else:
                # Cas où la profession qui n'existe pas
                self.struct[self.name][p] = 1

    # Impression de la structure
    def afficher(self):
        for cle1 in self.struct.keys():
            print(cle1, " : ", end="")
            for cle2 in self.struct[cle1].keys():
                print(cle2 + " (" + str(self.struct[cle1][cle2]) + ")", end=", ")
            print("\n")


if __name__ == "__main__":
    a=AutomateNomProf()
    a.analyser("sabotiers.ged")
    a.afficher()
