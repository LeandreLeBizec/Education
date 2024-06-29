package defaut;

public abstract class Noeud {

        private String value;

        public String getValue(){
            return this.value;
        }

        public void setValue(String v){
            this.value = v;
        }

        public Noeud getFilsD(){
            return null;
        }

        public Noeud getFilsG(){
            return null;
        }

        @Override
        public String toString(){
            return this.value;
        }


}
