#Exo1
vec1 <- rep(1:5,3)
vec2 <- rep(c(1:5), each=3)
vec3 <- rep(c(1:4), c(2:5))

q2 <- c(1,2,3,NA,4,NA,5)
q2[is.na(q2)] = 0

q3 <- runif(15,-1,1)
q3[q3<0] = -q3[q3<0]

q4 <- sum(c((10:100)^3 + 4*(10:100)^2))

x <- rnorm(100)
y <- sample(0:99)
z <- y[-1]-x[-100]
z2 <- sin(y[-100])/cos(x[-1])

#Exo2
M <- matrix(c(1,0,3,4,5,5,0,4,5,6,3,4,0,1,3,2), 4, 4)
M

diag(M)
M[1:2, ]
M[ ,1:2]
M[ ,-3]

det(M)
solve(M)

apply(M, 2, mean)

#Exo3
df <- mtcars
y <- mtcars$mpg
X <- cbind(1, mtcars$mpg, mtcars$hp)

t(X)

t(X) %*% X

solve(t(X) %*% X)

t(X) %*% y

solve((t(X) %*% X) %*% (t(X) %*% X))

#Exo4
test1 <- read.csv2("test1.csv")
test2 <- read.csv2("test2.csv", dec = ".")
test3 <- read.csv2("test3.csv", dec = ".")

etat1 <- read.csv2("etat1.csv")
etat2 <- read.csv("etat2.csv", dec =".")
etat3 <- read.table("etat3.csv", header = TRUE, sep = " ")

#read.csv -> sep = ","
#read.csv2 -> sep = ";"
#repose sur read.table

#cbind(df1, df2) : ajoute les colone de df2 à la suite de df1, il faut le même nombre de ligne 
#rbind(df1, df2) : ajoute les lignes de df2 à la suite de df1, il faut que les colones de df1 et df2 aient le même nom*
#merge(df1, df2, by='nomColone') : fusionne df1 et df2 suivant nomColone, que 2 df en même temps

etat <- merge(etat1, etat2, by="etat")
etat <- merge(etat, etat3, by="region")

#Exo5
curve(dnorm(x), from = -4, to = 4, main = "Comparaison de distibution")
curve(dt(x,5), from = -4, to = 4, col="red", add=T)
curve(dt(x,30), from = -4, to = 4, col="green", add=T)
legend(x=-4,y=0.4,legend=c("loi normal", "student dt = 5","student dt =30"), col = 1:3, lty=1)

#Exo6
curve(x^2+1, from = -3, to = 3, col="red", ylim=c(-10,10))
curve(x*0, col="blue", add=T)
curve(2*x+2 , col="green", add=T)
curve(x^2 + 2*x +3, from = -3, to = 0, col="black", add=T)
curve(x+3, from = 0, to = 2, col="black", add=T)
curve(x^2 + 4*x - 7, from = 2, to = 3, col="black", add=T)
legend(x=-3,y=-0,legend=c("f", "0","g", "h"), col = c("red", "blue", "green", "black"), lty=1)

#Exo7

#Q1
intensite <- read.table("Intensite.txt", head = T)
dommages <- read.table("Dommages.txt", head = T, dec=",")
mortalite <- read.csv2("Mortalite.csv")
mortalite <- mortalite[order(mortalite$nom),]

#df[1,] -> ligne 1
#df[,1] -> colone 1

#Q2
intensite <- subset(intensite, noeuds>=64)
#intensite=intensite[intensite$noeuds>=63,]

#Q3
dommages=dommages[apply(!is.na(dommages),1,all), ]

#Q4
# cat1 <- subset(intensite, noeuds<=82)
# cat <- data.frame(categorie=(rep(1, length(cat1$nom))))
# cat1 <- cbind(cat1,cat)
# 
# cat2 <- subset(intensite, noeuds>=83 & noeuds<=95)
# cat <- data.frame(categorie=(rep(2, length(cat2$nom))))
# cat2 <-cbind(cat2,cat)
# 
# cat3 <- subset(intensite, noeuds>=96 & noeuds<=113)
# cat <- data.frame(categorie=(rep(3, length(cat3$nom))))
# cat3 <- cbind(cat3,cat)
# 
# cat4 <- subset(intensite, noeuds>=114 & noeuds<=135)
# cat <- data.frame(categorie=(rep(4, length(cat4$nom))))
# cat4 <- cbind(cat4,cat)
# 
# cat5 <- subset(intensite, noeuds>135)
# cat <- data.frame(categorie=(rep(5, length(cat5$nom))))
# cat5 <- cbind(cat5,cat)
# 
# cat <- rbind(cat1,cat2)
# cat <- rbind(cat, cat3)
# cat <- rbind(cat, cat4)
# cat <- rbind(cat, cat5)
# dommages <- cat
categorie=rep("ouragan 5", nrow(intensite))
categorie[intensite$noeuds<=135]="ouragan 4"
categorie[intensite$noeuds<=113]="ouragan 3"
categorie[intensite$noeuds<=95]="ouragan 2"
categorie[intensite$noeuds<=82]="ouragan 1"
categorie=as.factor(categorie)
intensite=cbind(intensite, categorie)

#Q5
Ouragan <- merge(intensite, dommages)
Ouragan <- merge(Ouragan, mortalite)

#Q6
Ouragan <- Ouragan[order(Ouragan$annee),]

#Q7
by(Ouragan$cout, Ouragan$categorie, mean)

#Q8
hist(Ouragan$annee)
barplot(table(Ouragan$annee))
