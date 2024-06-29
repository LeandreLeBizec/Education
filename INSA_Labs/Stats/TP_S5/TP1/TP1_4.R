# nbElem <-80
# data <- rnorm(nbElem,mean=1,sd=3)
# hist(data,freq=F)

# curve(dexp(x,2),from=0,to=5)
# curve(dexp(x,1),from=0,to=5,add=T,col="red")
# curve(dexp(x,0.5),from=0,to=5,add=T,col = "blue")
# nbElem <- 80
# data <- rexp(nbElem,2)
# hist(data,freq=F)
# curve(dexp(x,2),from=0,to=5,add=T)

de <- 1:6
c <- sample(de, size=10000, replace=TRUE)
hist(c)

N<-20
n<-10
p<-0.3
ech<-rbinom(N,n,p)
barplot(table(ech)/N)


#Exercice1
Urne <- function(k,p,q){
  u<-rep(c("ROUGE","NOIRE"),c(p,q))
  sample(u,size=k,replace=F)
}

print(Urne(6,8,5))

#Exercice2
Freq  <- function(n){
  de<-1:6
  ech <- sample(de,size=n,replace=T)
  rep <- sum(ech==5)
  rep <- rep/n
}
print(Freq(100000))
