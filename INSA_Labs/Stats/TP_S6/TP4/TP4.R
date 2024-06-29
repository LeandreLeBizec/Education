#Exo1---------------------------------------------------------------------------

#Q1
tab<-read.table("hotdogs.txt", header=TRUE)

attach(tab)

tab=tab[-which(tab$Type==4),]
# on a enlevé du df les lignes pour lesquels Type = 4 ( 1 ligne )

tab$Type=as.factor(tab$Type)
# type : int -> type : factor ("1", "2", "3", "4")

#Q2
summary(Calories)
summary(Sodium)

by(tab, tab$Type, summary)
boxplot(Calories~Type)
boxplot(Sodium~Type)
# boeuf et melange de boeuf assez haut en calorie, volail moins riche en calories
# le boeuf est globalement moins riche en sel mais peut atteindre ponctuellement des taux de sodium plus élévé

#Q3

# modele assoccié à l'experience :
# Pour tous i=1,2,3 et pour tout j = 1,...,n  Calories_ij = mu + a_i + e_ij avec e_ij iid ~ N(0,s²)
#Calories_ij ~ N(mu + ai, s²)

mod1=lm(Calories~Type, data=tab)
#mod = lm(Calories~Type, data=Tab, contrast=list(Type="contr.sum")) 
#Pour forcer la contrainte naturelle au lieu de la contrainte par défaut de R
par(mfrow=c(2,2))
plot(mod1)
par(mfrow=c(1,1))

# Répartie de manière homogène autour et 0 et homoscédastique
# aligné sur les valeurs ajusté des factors
# Q-Q plot -> modèle de la loi observé s'éloigne du modèle d'une loi normale

anova(mod1)

# Df : degré de liberté, Sum Sq : sommes des carré ( SCM et SCR), Mean Sq : carré moyen ( CCM et CCR), F value = F0 = CCM / CCR, Pr : Proba critique
# H0 : Type n'a pas d'influence sur le modèle : a1 = a2 = a3 = 0
# H1 : Type à une influence sur le modèle : il existe i tq ai != 0
# la proba critique est < 0.05 => on rejette H0, donc type à une influence sur le modèle => au moins un ai != 0

summary(mod1)

# mû : 156.850 ( nb de calories moyen pour tous les sandwichs de type 1)
# contrainte utilisé : Contrainte témoin â1 = 0
# â2 : 1.856 ( nb de claories en plus d'un sandwich de type 2 /r à type 1)
# â3 : -38.085 ( nb de claories en moins en moyenne d'un sandwich de type 3 /r à type 1)

# nb calories prédit
# Type1 = 156.85
# Type2 = 2012.85
# Type3 = 118.765

# R² = 0.3866

#s⁵ = 23.46

library(emmeans)
emmeans(mod1, pairwise~Type, adjust="bonferroni")
# bonferroni permet d'ajuster le niveaux de confiance de tous les intervalles ( intervalle de confiance sur les moyenne )
# test de comapraison de moyenne
# 1 - 2, 1.86 calorie en moins dans le sandwich de type 1 /r au sandwich du type 2
# 1 - 3, 38.09 calorie en plus dans le sandwich de type 1 /r au sandwich du type 3
# 2 - 3, 39.94 calorie en plus dans le sandwich de type 2 /r au sandwich du type 3

# Le sandwich le moins calorique est le sandwich à la volail

#Exo2---------------------------------------------------------------------------
#Yij = mu + ai + bj + eijk
#a1 = 0
#B1 = 0
#anova(mod)....


#Exo3---------------------------------------------------------------------------

#Q1
library(emmeans)

#Q2
resistance <- read.table("resistance_textile.txt", header = T)
attach(resistance)
resistance$position = as.factor(position)
resistance$cycle = as.factor(cycle)

#Q3
#boite a moustache : plot(int~factor)
plot(perte_poids~textile)
abline(h=mean(perte_poids), col="red", lwd=3)
# Le textile A perd moins de poids en moyenne que les autres textiles
# Le textile qui perd le plus de poids est le textile B

#Q4
# lm(int~factor, data)
mod1 = lm(perte_poids~textile, data=resistance)
par(mfrow=c(2,2))
plot(mod1)
par(mfrow=c(1,1))
anova(mod1)
anova(mod1)[1,5]<0.05
# TRUE -> On peut affirmer qu'il y a un effet significatif du type de textile sur la perte de poid avec un risque d'erreur de 5%

#Q5
mod2 = lm(perte_poids~textile+position+cycle, data=resistance)
par(mfrow=c(2,2))
plot(mod2)
par(mfrow=c(1,1))
# Pour le graphe des resius : Répartie de manière homogène autour et 0 et homoscédastique
anova(mod2)
anova(mod2)[,5]<0.05
# Les trois variables position, cycle et textile ont une influence sur la perte de poids ( avec un risque de 5%)

#Q6
summary(mod2)$coefficients["textileD",4] < 0.05
# True -> le coefficient associé au textileD est significativement diférent de 0 avec un risque de 0.05

#Q7
emmeans(mod2, pairwise~textile, adjust="bonferroni")
# il y a une différence significative entre A-B et A-D ( avec un risque de 5% )
# Le textile le plus résistant à l'usure est le textile A

