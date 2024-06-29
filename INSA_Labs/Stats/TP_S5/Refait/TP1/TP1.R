pipo<-'texte'
nombre<-3
print(class(pipo))
txt<-"11"
nbr<-as.integer(txt)
print(class(nbr))
mot<-"petite"
phrase1<-paste("une ",mot," phrase")
print(phrase1)
print(nchar(phrase1))
tmp <- 3 / 0
nsp <- NA
resultat <- paste(tmp, tmp+1, tmp+nsp)
vecteur1 <- c(1, 3, 5, 7, 9)
vecteur2 <- seq(from=0, to=10, by=2)
vecteur3 <- 0:10
vecteur4 <- rep(1:2, 5)
print(vecteur1[1])

curve(dexp(x,2),from=0, to=10, col="red")
curve(dexp(x,1),from=0, to=10, add=T, col="blue")
curve(dexp(x,0.5),from=0, to=10, add=T, col="green")


data<-rexp(80,2)
hist(data,freq=F)
curve(dexp(x,2), add=T)


urne<-function(k,p,q){
  u<-rep(c("Rouge","Noire"),c(p,q))
  sample(u,size=k,replace=FALSE)
}

freq<-function(n){
  de<-1:6
  ech<-sample(de,size=n,replace=TRUE)
  barplot(table(ech)/n)
  print(sum(ech==5)/n)
}
