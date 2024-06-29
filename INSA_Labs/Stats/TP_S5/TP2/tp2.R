lybrary(MASS)
summary(michelson)
head(michelson)

print(michelson$Speed)

#Q1.1

moy <- mean(michelson$Speed)
ecart_type <- sd(michelson$Speed)

#Q1.2
m<-NULL
for(n in 1:100){
  moy <- sum(michelson$Speed[1:n])/n
  m <- c(m,moy)
}
plot(m)

#Q1.4
hist(michelson$Speed, freq=F)
curve(dnorm(x, moy, ecart_type) , add=T,col="red")

#Q1.5
moyExpt<-tapply(michelson$Speed, michelson$Expt, mean)
hist(moyExpt, freq=F, add=T, col="green")
curve(dnorm(x , mean(moyExpt), sd(moyExpt)/sqrt(20)  ), add=T, col="yellow"  )

#Q2.1


de<-1:4
res<-0
moyenne<-NULL

for (n in 1:5000){
  r<-sample(de,replace=TRUE,size=10)
  s<-sum(r==1)
  if(s>=6){
    res <- res+1
  }
  moyenne <- c(moyenne, res/n)
}
plot(moyenne, type="l")

dernieremoyenne <- moyenne[5000]

#Q2.2 C'est bernouilli
#Q2.3 Loi binomiale

#Q2.4
#somme de loi binomiale
#P(X>=6)=P(X=6)+P(X=7)+P(X=8)+P(X=9)+P(X=10)
sum(dbinom(x=6:10,size=10,prob = 0.25))

#Q2.5
#Loi Normale

#Q2.6




