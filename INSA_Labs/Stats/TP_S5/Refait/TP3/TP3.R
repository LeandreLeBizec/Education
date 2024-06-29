#---------------------------------Exo1------------------------------------------

# Q1.1
# X suit une loi binomiale B(150, 0.75)
# E(X) = np = 150*0.75 = 112.5
# V(X) = npq = 150*0.75*0.25 = 28.125 => σ=sqrt(V(X))=5.303301

#Q1.2
n <- 150
max <- qbinom(0.95,n,0.75)
print(paste("Si la conmpanie vend", n, "billets alors elle est sur à 95% d'avoir", max, "personnes max"))

#Q1.3
n <- 150
max <- qbinom(0.95,n,0.75)
while(max<150){
  n <- n+1
  max <- qbinom(0.95,n,0.75)
}
print(paste("Pour être sur à 95% de ne rebourser personnes, la companie peut vendre", n,"billets max"))

#Q1.4
n <- 300
max <- qbinom(0.95,n,0.75)
while(max<300){
  n <- n+1
  max <- qbinom(0.95,n,0.75)
}
print(paste("Pour être sur à 95% de ne rebourser personnes, la companie peut vendre", n,"billets max"))

#---------------------------------Exo2------------------------------------------

#Q2.1
n<-5
nb<-10000
t<-0
for(i in 1:n){
  t <- t + rnorm(nb,0,1)**2
}

# n<-10000
# t <- rnorm(n,0,1)**2 + rnorm(n,0,1)**2 + rnorm(n,0,1)**2 + rnorm(n,0,1)**2 + rnorm(n,0,1)**2 

hist(t, freq=F)
curve(dchisq(x, df=n), add=T)

#---------------------------------Exo3------------------------------------------

n<-1000
nb<-10000
S<-0
for(i in 1:n){
  S <- S+rnorm(nb,0,1)**2
}
t<-rnorm(nb,0,1)/sqrt(S/n)
hist(t, freq=F)
curve(dt(x, df=n), add=T, col='blue')
#curve(dnorm(x,0,1), add=T, col='red')
#les 2 courbes se superposent

#---------------------------------Exo4------------------------------------------

#Q4.1
data <- read.csv2(file="vitesse.csv", sep=";")

#Q4.2
str(data)
Variance <- tapply(data$vecVitesse,data$vecNum, var)

#Q4.3
n<-6
hist(Variance*6/100, freq=F)
curve(dchisq(x, df=n), add=T)

#---------------------------------Exo5------------------------------------------




