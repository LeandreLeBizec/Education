#Exo 1
#loi binomiale de paramètre p=0.75 n=150 ou >150, µ=np=112.5 , σ=sqrt(np(1-p))=5.303301
max <- qbinom(0.95,150,0.75)
n<-150
while (max<150){
  n=n+1
  max<-qbinom(0.95,n,0.75)
}
print(n)

max<-0
n<-300
while (max<300){
  n=n+1
  max<-qbinom(0.95,n,0.5)
}
print(n)

max<-0
n<-300
while (max<300){
  n=n+1
  max<-qbinom(0.95,n,0.8)
}
print(n)


#Exo2
n<-10
t1 <- rnorm(n,0,1)**2 + rnorm(n,0,1)**2 +rnorm(n,0,1)**2 + rnorm(n,0,1)**2 + rnorm(n,0,1)**2
print(t1)
hist(t1)

#Exo4
data <- read.csv2(file="vitesse.csv",sep=";")
Moyenne<-tapply(data$vecVitesses,data$vecNum,mean)
EcartType<-tapply(data$vecVitesses,data$vecNum,sd)
#n=6, σ=10 n*S**2/σ**2 -> loi : (chi_n-1)**2
Variance<-tapply(data$vecVitesses,data$vecNum,var)*6/100
hist(Variance,freq=F)
curve(dchisq(x,df=6),add=T)

#Exo5
data <- read.csv2(file="vitesse.csv",sep=";")
Moyenne<-tapply(data$vecVitesses,data$vecNum,mean)



