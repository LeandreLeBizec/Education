import subprocess
import sys

class Names:
    def __init__(self,stem='adult'):
        self.typeattribut=dict()
        self.posattribut=dict()
        self.valeurpossibles=dict()
        data = open(stem+'.names','r').readlines()
        data_filtered= [x for x in data if x[0]!='|' and x[0]!='\n']
        tmp=data_filtered[0].split('.')[0].split(',')
        self.targets=dict()
        for i,e in enumerate(tmp):
            self.targets[e]=i

        for i,line in enumerate(data_filtered[1:]):
            tmp=line.split(':')
            attr=tmp[0].strip()
            val=tmp[1]
            self.posattribut[attr]=i
            if val.find(',')>=0:#lignes avec attributs discrets                               
                self.typeattribut[attr]='discret'
                self.valeurpossibles[attr]=dict()
                for e in val.split('.')[0].split(','):
                    self.valeurpossibles[attr][e.strip()]=1
            else:
                self.typeattribut[attr]='numeric'
        #print(self.typeattribut)
        #print(self.posattribut)
        #print(self.valeurpossibles)
    def checkval(self,attr,val):
        if attr not in self.typeattribut:
            raise Exception(attr+" n'est pas un attribut connu")
        
        if self.typeattribut[attr]=='discret':
            if val not in self.valeurpossibles[attr]:
                raise Exception(val+" n'est pas une valeur connue de l'attribut "+attr)
        return val
    def position(self,attr):
        if attr not in self.posattribut:
            raise Exception(attr+" n'est pas un attribut connu")
        return  str(self.posattribut[attr])
    def type(self,attr):
        if attr not in self.typeattribut:
            raise Exception(attr+" n'est pas un attribut connu")
        return  str(self.typeattribut[attr])


class Node:
    names = Names()
    def __init__(self, attribut,question):
        self.yes = None
        self.no = None
        self.attribut = attribut
        self.question= question
    
    def to_bonzaimodel(self):
        save='<node type="node">\n'
        save+='<question gain="19" position="'+Node.names.position(self.attribut)+'" name="'+self.attribut+'" type="'+Node.names.type(self.attribut)+'" patron="'+Node.names.checkval(self.attribut,self.question)+'"/>\n'
        save+='<population 0="1" 1="1"/>\n'
        if self.yes:
            save+=self.yes.to_bonzaimodel()
        if self.no:
            save+=self.no.to_bonzaimodel()        
        save+='</node>\n'
        return save

class Leaf:
    def __init__(self, predicted_class):
        targets={'infeq50K':'0','sup50K':'1'}
        self.inf='0'
        self.sup='0'
        if targets[predicted_class]=='0':
            self.inf='1'
        else:
            self.sup='1'
    def to_bonzaimodel(self):
        save='<node type="leaf">\n'
        save+='<population 0="'+self.inf+'" 1="'+self.sup+'"/>\n'
        save+='</node>\n'
        return save
        
        

class bonzai:
    def __init__(self, stem='adult',bonzaipath='./bonzaiboost',compatibility=False):
        self.stem=stem
        self.bonzaipath=bonzaipath
        self.compatibility=compatibility
    #fonction pour utiliser bonzaiboost en prediction: renvoie les statistiques d'erreurs
    def predict(self,file,boosting=False):  
        if boosting:
            res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -boost adamh -C -o backoff -c single < '+file)       
        else:
            res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -C < '+file)
        
    #fonction pour lancer l'apprentissage de bonzaiboost: ArbresDeDécision + Boosting D'arbres
    def fit(self,depth=1,iter=0,mdlpc=False,n_jobs=1,verbose=False):
        #depth = profondeur max de l'arbre
        #iter = nombre d'itération dans l'algorithm de boosting qui combine *iter* arbres de profondeur depth
        v=""
        if depth<=2 and verbose:
            v=' -v 4'
        if mdlpc:
            res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -mdlpc -jobs '+str(n_jobs))
        elif iter==0:
            res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -d '+str(depth)+' -jobs '+str(n_jobs)+v)
        else:
            res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -d '+str(depth)+' -boost adamh -n '+str(iter)+' -jobs '+str(n_jobs))
              
    def get_learning_curves(self,file='adult.data'):       
        import shutil
        from IPython.display import Image, display
        #subprocess.run(self.bonzaipath+' -S '+self.stem+' -boost adamh -draw cer -c single -o backoff -C <'+file,shell=True)
        self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -boost adamh -draw cer -c single -o backoff -C <'+file)
        self.__run_cmd('gnuplot adult.boost.plot.head')
        if file.find('.data')>=0:
            shutil.copyfile('adult.boost.png','adult.boost.data.png')
            display(Image(filename='adult.boost.data.png'))
        else:
            shutil.copyfile('adult.boost.png','adult.boost.test.png')
            display(Image(filename='adult.boost.test.png'))

    def feedback(self,filter=0.2):
        subprocess.run(self.bonzaipath+' -S adult -boost adamh -n 100 --info -o '+str(filter),shell=True)
        from IPython.display import HTML,display_html
        display_html(HTML(filename="adult.boost.log.html"))
    def visualize_tree(self,file='adult.data'):    
        res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -C < '+file)
        res=self.__run_cmd('dot -Tpng '+self.stem+'.tree.dot > arbre.png')
        from IPython.display import Image, display
        display(Image(filename='arbre.png'))
    def to_bonzaimodel(self,root):
        save='<?xml version="1.0" encoding="iso-8859-1"?>\n'
        save+='<run algorithm="Tree" induction="Entropie" min_leaf_size="0" gain="1e-08" mdlpc="false" nb_rounds="2" depth="10000" fs="0" bs="0.62">\n'
        save+='<target_labels 0="infeq50K" 1="sup50K"/>\n<tree>\n'
        save+=root.to_bonzaimodel()
        save+='</tree>\n'
        save+='</run>\n'
        f=open(self.stem+'.tree.xml','w')
        f.write(save)
        f.close()

    def update_decisions(self):
        res=self.__run_cmd(self.bonzaipath+' -S '+self.stem+' -d 2 -resume')
        #print(res)    

    def __run_cmd(self,cmd: str):
        if self.compatibility:
            res=subprocess.run(cmd,shell=True,stdout=subprocess.DEVNULL,stderr=subprocess.PIPE)
            print(res.stderr.decode('utf-8'))
            return ""
        process = subprocess.Popen(cmd, shell = True,bufsize = 1,stdout=subprocess.DEVNULL, stderr = subprocess.PIPE,encoding='utf-8', errors = 'replace' ) 
        while True:
            realtime_output = process.stderr.readline()
            if realtime_output == '' and process.poll() is not None:
                break
            if realtime_output:
                if realtime_output.find('it/s')>=0: 
                    if realtime_output.find('[100%]')>=0:                                    
                        print('\r',realtime_output.rstrip(), flush=True,end='\n')
                    else:
                        print('\r',realtime_output.rstrip(), flush=True,end='')
                else:
                    print('\n',realtime_output.rstrip(), flush=True,end='')
                sys.stderr.flush()
        return ""

        

if __name__ == '__main__':
    arbre = Node('age','25') #for numeric question the rule is "<" so the yes branch contains people <35 and no branch >=35
    arbre.yes = Node('native-country','United-States')
    arbre.yes.yes=Leaf('infeq50K')
    arbre.yes.no=Leaf('infeq50K')
    arbre.no = Node('race','black')
    arbre.no.yes=Leaf('sup50K')
    arbre.no.no=Leaf('infeq50K')

    clf = bonzai()
    clf.fit(iter=10)
    #clf.predict('adult.test',boosting=True)
    #clf.get_learning_curves('adult.test')
    clf.feedback()
