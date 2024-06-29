import java.util.ArrayList;
import java.util.List;

public class Board {
    private int N;
    private int[][] blocks;

    public Board(int[][] blocks) {
        this.blocks = blocks;
        this.N = blocks.length;
    }

    public int dimension() {
        return this.N;
    }

    public int hamming() {
        int wrongPosition = 0;
        for(int i=0; i<this.dimension(); i++){
            for(int j=0; j<this.dimension(); j++){
                if(this.blocks[i][j] !=0 && this.blocks[i][j] != i*this.dimension()+j+1) {
                    wrongPosition++;
                }
            }
        }
        return wrongPosition;
    }

    public int manhattan() {
        int manhattanSum = 0;
        for(int i=0; i<this.dimension(); i++) {
            for (int j = 0; j < this.dimension(); j++) {
                if(this.blocks[i][j] !=0 && this.blocks[i][j] != i*this.dimension()+j+1) {
                    int i_goal = (this.blocks[i][j]-1) / this.dimension(); // line
                    int j_goal = (this.blocks[i][j]-1) % this.dimension(); // column
                    manhattanSum += Math.abs(i-i_goal)+Math.abs(j-j_goal);
                }
            }
        }
        return manhattanSum;
    }

    public boolean isGoal() {
        return this.manhattan() == 0;
    }

    public Board twin() {
        return null;
    }

    public boolean equals(Object that) {
        if (that instanceof Board){
            if(this.dimension() == ((Board) that).dimension()){
                for(int i=0; i<this.dimension(); i++) {
                    for (int j = 0; j < this.dimension(); j++) {
                        if (this.blocks[i][j] != ((Board) that).blocks[i][j]){
                            return false;
                        }
                    }
                }
                return true;
            }
        }
        return false;
    }


    public Board copy(){
        Board res = new Board(new int[this.dimension()][this.dimension()]);
        for(int i=0; i<this.dimension(); i++) {
            for (int j = 0; j < this.dimension(); j++) {
                res.blocks[i][j] = this.blocks[i][j];
            }
        }
        return res;
    }

    public Iterable<Board> neighbors() {
        List<Board> boards = new ArrayList<>();
        for(int i=0; i<this.dimension(); i++) {
            for (int j = 0; j < this.dimension(); j++) {
                if (this.blocks[i][j] == 0){
                    if(i>0){
                        Board b1 = this.copy();
                        b1.blocks[i][j] = b1.blocks[i-1][j];
                        b1.blocks[i-1][j] = 0;
                        boards.add(b1);
                    }
                    if(i<this.dimension()-1){
                        Board b2 = this.copy();
                        b2.blocks[i][j] = b2.blocks[i+1][j];
                        b2.blocks[i+1][j] = 0;
                        boards.add(b2);
                    }
                    if(j>0){
                        Board b3 = this.copy();;
                        b3.blocks[i][j] = b3.blocks[i][j-1];
                        b3.blocks[i][j-1] = 0;
                        boards.add(b3);
                    }
                    if(j<this.dimension()-1){
                        Board b4 = this.copy();;
                        b4.blocks[i][j] = b4.blocks[i][j+1];
                        b4.blocks[i][j+1] = 0;
                        boards.add(b4);
                    }
                }
            }
        }
        return boards;
    }

    public String toString() {
        StringBuilder s = new StringBuilder();
        s.append(N + "\n");
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                s.append(String.format("%2d ", blocks[i][j]));
            }
            s.append("\n");
        }
        return s.toString();
    }
}
