#Exo1---------------------------------------------------------------------------

#Q1
pub <- read.csv("Advertising.csv")
attach(pub)

#Q2
cor(pub)
#TV et Sales sont plutot corrélé

#Q3
plot(TV, Sales)
reg=lm(Sales~TV, data=pub)
resume=summary(reg)
resume
x <- TV
y=predict(reg)
lines(x,y,col="blue",lwd=3)
#R² pas dingue
#Pr petite donc on rejette H0 <- influence de la pub sur les ventes 
plot(reg$fitted.values,reg$residuals,xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#non homoscédastique -> log
plot(TV, log(Sales))
reg2=lm(log(Sales)~TV, data=pub)
resume=summary(reg2)
resume
x <- TV
y=predict(reg2)
lines(x,y,col="blue",lwd=3)
plot(reg2$fitted.values,reg2$residuals, ylim=c(-2,2), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#2 valeus qui se baladent mais ça nous satisfait

#Q4
plot(TV, Radio)
reg=lm(Radio~TV, data=pub)
resume=summary(reg)
resume
x <- TV
y=predict(reg)
lines(x,y,col="blue",lwd=3)
#R² pas dingue
#Pr petite donc on rejette H0 <- influence de la pub sur les ventes 
plot(reg$fitted.values,reg$residuals, ylim=c(-30, 30), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#semble ok

plot(TV, Newspaper)
reg=lm(Newspaper~TV, data=pub)
resume=summary(reg)
resume
x <- TV
y=predict(reg)
lines(x,y,col="blue",lwd=3)
#R² pas dingue
#Pr petite donc on rejette H0 <- influence de la pub sur les ventes 
plot(reg$fitted.values,reg$residuals, ylim=c(-80,80), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#semble ok

#Q5
regm=lm(Sales~TV+Radio+Newspaper, data=pub)
resume=summary(regm)
resume
#89% de la variabilité des ventes est expliquée (R² = 0.89)

#Q6
#F-statistic = 570.3 on 3 and 196 DF, p-value < 2.2e-16
#Donc on valide l'hypothèse

#on valide aussi pour la radio mais pas pour newspaper car p-value trop haute

#Q8
#on garde la TV et la Radio seulement
#regression multiple sur les variables TV et Radio
reg2=lm(Sales~TV+Radio, data=pub)
summary(reg2)
#radio : 0.189799 vs TV : 0.04575 la Radio à une influence plus forte

#Q9
library(rgl)
library(car)
scatter3d(Sales~TV+Radio, data=pub)

#Q10
x0 = data.frame(TV=100, Radio=20)
predict(reg2, newdata=x0, interval="prediction")

#Exo2---------------------------------------------------------------------------

#Q1
lait <- read.table("lait.txt", header = T)
attach(lait)

#Q2
cor(lait[,1:5])
#ExSec~Densite 0.76, TxCase~TxProt très corrélé 0.96
#redondance d'information... un modèle avec moins de variable peut aussi bien marcher

#Q3
plot(Densite, Rendement)
#semble pas linéaire
plot(TxButy, Rendement)
#semble linéaire
plot(TxProt, Rendement)
#semble linéaire
plot(TxCase, Rendement)
#semble linéaire
plot(ExSec, Rendement)
#semble linéaire

#Q4
reg=lm(Rendement~Densite+TxButy+TxProt+TxCase+ExSec, data=lait)
summary(reg)
#TxButy, ExSec pvalue<0.05 donc les seules qui ont un effet significatif
5*reg$coefficient[3] + 5*reg$coefficient[4] - 2*reg$coefficient[5] 
#graphe des résidus
x <- TV
plot(reg$fitted.values,reg$residuals, ylim=c(-1,1), xlab="valeur ajusté",ylab="residus")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
plot(reg, which=1)
plot(reg, which=2)
#par(mfrow=c(2,2))
#plot(reg)
#plutôt pas mal

#Q5
reg2=step(reg, direction="backward")
#calcul l'AIC, enleve une variable à chaque tour et recalcul l'AIC puis le compare
#obj -> trouver l'AIC le plus petit
#backward : commence au nbr max de variable plus enleve
#forward : commence à une variable puis ajoute 
#s'arrête quand il ne trouve pas de plus petit
#modele conservé : Densite + TxButy + TxProt + ExSec

#Q6
reg3=lm(Rendement ~ -1+Densite+TxButy+TxProt+ExSec, data=lait)
#enlève l'ordonnée à l'origine -> forcer à passer par 0

#Q7
extractAIC(reg)
extractAIC(reg2)
extractAIC(reg3)

summary(reg)$adj.r.squared
summary(reg2)$adj.r.squared
summary(reg3)$adj.r.squared

#on garde le modèle 3 car R2 plus intéressant même si AIC > reg2

#Q8
df = data.frame(rbind(c(Densite=1.032,TxButy=39.7,TxProt=31.9,ExSec=130),c(Densite=1.032,TxButy=42.8,TxProt=34.5,ExSec=130)))
predict(reg3, newdata = df, interval = "prediction")
#La meilleure vache est la Normande

#Exo3---------------------------------------------------------------------------

#Q1
eucal <- read.table("eucalyptus.txt", header = T)
attach(eucal)

#Q2
# on veut expliquer la hauteur grâce à la circonférence de l'arbre
# variable à expliquer : hauteur (y)
# variable explicative : circonférence (x)
plot(circ, ht)

#Q3
#modele : Yi = B_0 + B_1*x_i + e_i
# e_i erreurs résiduelles, indépendante et de même loi ~> N(0,sigma²)
#lm(y~x, data)
reg=lm(ht~circ, data=eucal)
resume=summary(reg)
resume
#B0 = 9.037476 
#B1 = 0.257138

#Q4
lines(circ, predict(reg),col="red",lwd=3)
plot(reg$fitted.values,reg$residuals, ylim = c(-10,10), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
# non homoscédastique

#Q5

#a 
# ecriture matricielle : Y = X*B + E 
Y = ht
X0 <- c(rep(1, length(circ)))
X1 <- circ
X2 <- sqrt(circ) 
X <- cbind(X0,X1,X2)

#b
# B = c(B0,B1,B2)
B = solve(t(X)%*%X)%*%t(X)%*%Y

#c
x <- circ
y <- B[1]+B[2]*x+B[3]*sqrt(x) #valeurs ajustées
e <- ht - y # residu
sigma <- sqrt(sum(e^2)/(length(e)-2-1))

#d

#sigma = sqrt(variance)
B0 = sqrt(solve(t(X)%*%X)[1,1]*sigma^2)
B1 = sqrt(solve(t(X)%*%X)[2,2]*sigma^2)
B2 = sqrt(solve(t(X)%*%X)[3,3]*sigma^2)

#e
# racine carré de la circonférence influe sur la hauteur ?
# hypothese : H0 { B2 = 0 } vs H1 { B2 != 0}
# stat de test et loi  : sous H0, T0 = B2 / sigma_B2 
T0 = B[2] / B2  
#t_n-p+1    n : nb obs, p : nb coeff
# region de rejet : ]-inf, -t1426,0.975]U[t1426,0.975, +inf[ = ]-inf, -1.96[U]1.96, +inf[
# T0 n'appartient pas a la region de rejet => la racine de la criconference influe sur la hauteur avec un risque de 5%

#f
eucal2 <- cbind.data.frame(eucal,rcirc=sqrt(eucal[,"circ"]))
reg2=lm(ht~eucal$circ+eucal2$rcirc, data=eucal2)
resume2=summary(reg2)
resume2

#g
plot(circ, ht)
lines(circ, predict(reg),col="red",lwd=3)
x = seq(min(eucal[,"circ"]),max(eucal[,"circ"]),length=100)
result = B[1]+B[2]*x+B[3]*sqrt(x)
lines(x, result, col="blue", lwd=3)
