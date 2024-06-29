#Exo1
poids<-c(1150, 1500, 1700, 1800, 1800, 1850, 2200, 2700, 2900, 3000, 3100, 3500,3900, 4000, 5400)
moy<-mean(poids)
n<-15
var<-var(poids)
sd<-sqrt(var)
inf<-moy-qt(1-0.1/2,n-1)*sd/sqrt(n)
sup<-moy+qt(1-0.1/2,n-1)*sd/sqrt(n)
#H0 : 𝜇 = 𝜇0
#H1 : 𝜇 != 𝜇0
#Statistique de la loi : T = Xbarre-𝜇0/(σchappeau/sqrt(n))
#t=x_nbarre-𝜇0/(σchappeau/sqrt(n))
t<-(moy-3000)/(sd/sqrt(n))
#loi(T) = 𝑡n-1 loi de Student à n-1 degré de liberté
res_test <- t.test(poids, mu=3000, conf.level =0.9)
print(res_test)
#intervalle 1 : [2173, 3227]
#intervalle 2 : [2173, 3227]
inf2<-qt(0.1/2,n-1)
sup2<-qt(1-0.1/2,n-1)
#intervalle : [-1.76, 1.76]
#p-value>0.05 -> hypothèse validée (H0)
#t appartient à [-1.76, 1.76] -> hypothèse validée (H0)

#Exo2
#hypothèse : moyenne théorique même pour tous soit 𝜇1=𝜇2 (H0)
#Statistique de test : 𝜇1=𝜇2 => D = VarAl1 - VarAl2 =, D suit une loi normale d'ecart type sigmaDhat(diapo 55 )
#loi : loi(D/sigmaDhat)->suit une loi de student
#règle de décision : on regarde si (xaBarre - xbBarre)/sigmaDhat -> si dans l'intervalle de confiance, on confirme H0
sigma2<-((12-1)*0.95**2+(8-1)*1.35**2)/(12+8-2)
sigmaD<-sigma2*(1/12+1/8)
