#Exo1 --------------------------------------------------------------------------
courrier = read.table("Courrier.txt", header = T)

#Q1) Utiliser directement les variables du df
attach(courrier) 

#Q2) Graphe des données
plot(Poids,Nb_lettres,xlab="Poids du courrier (t)",ylab="Nombre de lettres",pch=19, xlim=c(9,39),ylim=c(700,2500))
#graphiquement, un modèle linéaire semble justifié

#Q3) Régression linéaire
reg=lm(Nb_lettres~Poids,data=courrier)
resume=summary(reg)
resume

#Q4) droite
x=c(min(Poids),max(Poids))
y=198+57.7*x
#on recupère Estimate de la partie Coeff
lines(x,y,col="blue",lwd=3)

#Q5) R
#R² = 0.9628
resume$r.squared

#Q6) Graphe des résidus
plot(reg$fitted.values,reg$residuals,xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#residus uniformement réparti autour de 0, hypothèse de linéarité validé !

#Q7) Hypothèse de nullité
resume$coefficients[8] < 0.05 #le test sur B1<5% on en déduit que B1(57.7) est != 0

#Q8)
x=27.5
p=198+57.7*x
predict(reg,data.frame(Poids=27.5))

#Q9)
predict(reg,data.frame(Poids=27.5),interval = "prediction")

#Q10)
I<-predict(reg,data.frame(Poids=0:40),interval = "prediction")
plot(Poids,Nb_lettres,xlab="Poids",ylab="Nombre de lettres")
lines(0:40,I[,"lwr"])
lines(0:40,I[,"upr"])

detach(courrier)


#Exo2---------------------------------------------------------------------------

tomassone <- read.table("tomassone.txt", header = T)
attach(tomassone)

#Y1
plot(X,Y1)
reg=lm(Y1~X, data=tomassone)
resume=summary(reg)
resume
x <- tomassone$X
y=0.5215+0.8084*x
lines(x,y,col="blue",lwd=3)
#droite ok
plot(reg$fitted.values,reg$residuals,xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
#point réparti uniformement, semble ok

#Y2
plot(X,Y2)
reg=lm(Y2~X, data=tomassone)
resume=summary(reg)
resume
x <- tomassone$X
y=0.5228+0.8086*x
lines(x,y,col="blue",lwd=3)
#tendance parabolique, R²=0.62 bof
plot(reg$fitted.values,reg$residuals,xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
#repartition des résidus non uniforme, il faut changer de modèle
#cela signifie qu'il manque une variable expliquatif, on peut ajouter par exemple la variable x2
plot(X,Y2)
X2 <- tomassone[,"X"]^2
tomassone2 <- cbind(tomassone, X2)
reg2=lm(Y2~X+X2, data=tomassone2)
resume=summary(reg2)
resume
x <- tomassone2$X
y= -26.11211 + 4.84334*x + -0.13696*x^2
# ou y <- predict(reg2)
lines(x,y,col="blue",lwd=3)

#Y3
plot(X,Y3)
reg=lm(Y3~X, data=tomassone)
resume=summary(reg)
resume
x <- tomassone$X
y=0.5258+0.8084*x
lines(x,y,col="blue",lwd=3)
#droite pas terrible(ressemble plus à un exp), R²=0.62 bof
plot(reg$fitted.values,reg$residuals, ylim = c(-10,10), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#Une valeur semble abérante, on refait la régression linéaire en supprimant cette valeur
tomassone2 <- tomassone[-16,]
detach(tomassone)
attach(tomassone2)
plot(X,Y3)
reg2=lm(Y3~X, data=tomassone2)
resume=summary(reg2)
resume
x <- tomassone2$X
y=4.24794+0.50213*x
lines(x,y,col="blue",lwd=3)
#droite ok
plot(reg2$fitted.values,reg2$residuals, ylim = c(-3,3), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#top

detach(tomassone)
attach(tomassone)

#Y4
plot(X,Y4)
reg=lm(Y4~X, data=tomassone)
resume=summary(reg)
resume
x=tomassone$X
y=0.5169+0.8088*x
lines(x,y,col="blue",lwd=3)
#droite pas terrible(ressemble plus à une fonction trigo), R²=0.62 bof
plot(reg$fitted.values,reg$residuals, ylim = c(-8,8), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#non uniforme, on peut utiliser le log ou racine
reg2=lm(log(Y4)~X, data=tomassone)
resume=summary(reg2)
resume
plot(X,log(Y4))
x=tomassone2$X
y=1.24266+0.08006*x
lines(x,y,col="blue",lwd=3)
plot(reg2$fitted.values,reg2$residuals, ylim = c(-1,1), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#allure parabollique -> refaire comme pour le 1
plot(X,log(Y4))
X2 <- tomassone[,"X"]^2
tomassone2 <- cbind(tomassone, X2)
reg2=lm(log(Y4)~X+X2, data=tomassone2)
resume=summary(reg2)
resume
x <- tomassone2$X
y <- predict(reg2)
lines(x,y,col="blue",lwd=3)
#droite ok
plot(reg2$fitted.values,reg2$residuals, ylim = c(-1/2,1/2), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#ok


detach(tomassone)


#Exo3---------------------------------------------------------------------------

#Q1
freinage <- read.table("freinage.txt", header = T)
attach(freinage)

#Q2
#on veut expliquer la distance d'arrêt en fonction de la vitesse
#Dist : variable à expliquer (y)
#Vitesse : variable explicatif (x)
plot(Vitesse, Dist)

#Q3
#lm(variable à expliquer ~ variable explicatif, data)
#lm(y~x, data)
reg=lm(Dist~Vitesse, data=freinage)
resume=summary(reg)
resume
#B0 = -40.02545
#B1 = 1.01109
# % de variabilité de la distance expliqué par la vitesse : R²=0.98 soit 98%
# La vitesse à une influence sur la distance d'arrêt : Proba critique < 0.05

#Q4
x <- Vitesse
y <- predict(reg)
lines(x,y,col="blue",lwd=3)

#Q5
plot(reg$fitted.values,reg$residuals, ylim = c(-10,10), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
# Les valeurs ne sont aléatoirement réparties autour de 0 -> allure parabolique 
# cela signifie qu'il manque une variable expliquatif, on peut ajouter par exemple la variable Vitesse²
Vitesse2 <- freinage[,"Vitesse"]^2
freinage2 <- cbind(freinage, Vitesse2)
plot(Vitesse2, Dist)
reg2=lm(Dist~Vitesse+Vitesse2, data=freinage2)
resume=summary(reg2)
resume
x <- Vitesse2
y <- predict(reg2)
lines(x,y,col="blue",lwd=3)
#droite ok
plot(reg2$fitted.values,reg2$residuals, ylim = c(-10,10), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#r épartie aléatoirement et homoscédastique

#Q6
p1 = predict(reg, data.frame(Vitesse=85)) #modèle1
p2 = predict(reg2, data.frame(Vitesse=85, Vitesse2=85^2)) #modèle2

#distance moyenne arrêt = distance parcourue pendant la durée de la réaction + distance d'arrêt
# 85 km/h = 85/3.6 = 23.6 m/s
Da1 = p1 + (85/3.6)*2 #avec le modèle1 -> 93.1m
Da2 = p2 + (85/3.6)*2 #avec le modèle2 -> 89m


detach(freinage)

#Exo4---------------------------------------------------------------------------

#Q1
porcs <- read.csv2("porcs.csv")
attach(porcs)

#Q2
#On veut expliquer le gain en protéine grâce à l'ingestion journalière
# gain : variable à expliquer (y)
# ingestion : variable explicative (x)
plot(ingestion, gain)

#Q3 
#reg(y~x, data)
reg=lm(gain~ingestion, data=porcs)
resume=summary(reg)
resume
#B0 = 27.3259
#B1 = 4.8404
# % de variabilité du gain journalier en protéine expliqué par l'a vitesse'ingesiton journalière : R²=0.63 soit 63%
# L'ingestion journalière à une influence sur le gain journalier en protéine : Proba critique < 0.05

#Q4
x <- ingestion
y <- predict(reg)
lines(x,y,col="blue",lwd=3)

#Q5
plot(reg$fitted.values,reg$residuals, ylim = c(-50,50), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#Les valeurs ne sont pas réparti de manière homogène autour de 0, un semblant de parabole se forme
# Pour améliorer la pertinence du modèle, on peut ajouter une variable explicative (ingestion² par exemple) ce qui coincide avec le fait que la courbe de départ semble exp
ingestion2 <- porcs[,"ingestion"]^2
porcs2 <- cbind(porcs, ingestion2)
plot(ingestion2, gain)
reg2=lm(gain~ingestion+ingestion2, data=porcs2)
resume=summary(reg2)
resume
x <- porcs2$ingestion2
y <- predict(reg2)
lines(x,y,col="blue",lwd=3)
#droite ok
plot(reg2$fitted.values,reg2$residuals, ylim = c(-40,40), xlab="residus",ylab="valeur ajusté")
abline(h=0, col="blue")
abline(h=-2*resume$sigma, col="red")
abline(h=2*resume$sigma, col="red")
#semble ok

#Q6
#contrainte de continuité => B0 + B1*x si x<=28 et B0 + B1*28 si s>28

porcs6 <- porcs[ingestion<=28,]
plot(porcs6$ingestion, porcs6$gain)

#Y = XB + E 
# => XB = Y - E (ok car Y et E de taille n)
# => X = (Y-E)*B^-1 (ok car n*1 * 1*2 -> n*2)
reg3=lm(gain~ingestion, data=porcs6)
resume=summary(reg3)
resume
#B0 = -65.890
#B1 = 8.667
plot(ingestion, gain)
x <- porcs6$ingestion
y <- predict(reg3)
lines(x,y,col="blue",lwd=3)
x<-porcs[ingestion>28,]$ingestion
y<-rep(predict(reg3, data.frame(ingestion=28)),length(porcs[ingestion>28,]$ingestion))
lines(x,y, col="blue",lwd=3)


detach(porcs)
