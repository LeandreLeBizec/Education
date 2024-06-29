
v1 <- c(175, 182, 165, 187, 158)
v2<-c(19,18,21,22,20)
v3<-c("Louis","Paule","Pierre","Rémi","Claude")
tableau<-data.frame(prenom=v3,taille=v1,age=v2)
print(names(tableau))
print(tableau$prenom)
write.table(tableau, "sortie.csv", sep=";" ,row.names=FALSE, col.names=FALSE)

curve(dnorm)
curve(dnorm(x,mean=1,sd=2),from=-3,to=3)
curve(dnorm(x,mean=1,sd=2),from=-3,to=5)
curve(dnorm(x,mean=1,sd=5),from=-3,to=5,add=T,col="red")
curve(dnorm(x,mean=1,sd=0.5),from=-3,to=5,add=T,col="blue")
curve(dnorm(x,mean=1,sd=1),from=-3,to=5,add=T,col="blue")
curve(dnorm(x),from=-3,to=3)


x <- 0:10
plot(dbinom(x,10,0.2),type='h',lend="square",lwd=30)

