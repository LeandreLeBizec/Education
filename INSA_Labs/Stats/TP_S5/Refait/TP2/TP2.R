#------------------------------------I------------------------------------------
#Q1.1
mesures <- c(michelson$Speed)
moyenne <- mean(mesures)
ecartType <- sd(mesures)
n <- length(mesures)
groupes <- c(michelson$Expt)

#Q1.2
vecteur <- NULL
for (i in 1:n){
  Xn<-sum(michelson$Speed[1:i])/i
  vecteur <- c(vecteur,Xn)
}
plot(vecteur)

#Q1.3
#En appliquant le théorème de la loi des grands nombres on garde la valeur 852.4 ( soit la moyenne )

#Q1.4
hist(mesures, freq=F)
curve(dnorm(x, moyenne, ecartType), add=T, col="red")

#Q1.5
X20 <- tapply(mesures, groupes, mean)
hist(X20, freq=F, add=T, col="green")
curve(dnorm(x, mean(X20), sd(X20)), add=T, col="yellow")


#------------------------------------II-----------------------------------------
#Q2.1
n<-5000
QCM <- rbinom(n, 10, 1/4)
succes = 0
QCM_passe <- c()
for(i in 1:n){
  if (QCM[i]>=6){
    succes = succes +1
  }
  QCM_passe <- c(QCM_passe, succes/i)
  QCM_n <- QCM[i] 
}

print(QCM_n)
plot(1:n, QCM_passe, type="l")

#Q2.2
#loi de bernouilli(1/4)

#Q2.3
#Loi binomiale(10, 1/4)

#Q2.4
sum(dbinom(x=6:10, 10, 1/4))

#Q2.5
#On peut approcimer X10 par une loi normal N(mu, sigma/sqrt(10)) 
#avec mu=E(Xi)=1/4 et sigma=sqrt(1/4*3/4)

#Q2.6




















