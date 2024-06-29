import java.util.*;

public class Solver {
    private static class SearchNode implements Comparable<SearchNode> {
        Board currentState;
        SearchNode previousState;
        int countMoves;

        public SearchNode(Board current, SearchNode previous, int count){
            this.currentState = current;
            this.previousState = previous;
            this.countMoves = count;
        }
        @Override
        public int compareTo(SearchNode searchNode) {
            return (this.countMoves + this.currentState.manhattan()) - (searchNode.countMoves + searchNode.currentState.manhattan());
        }
    }

    Queue<SearchNode> queue;
    SearchNode root;
    SearchNode finalState;
    boolean solvable;
    public Solver(Board initial) {
        queue = new PriorityQueue<>();
        root = new SearchNode(initial, null, 0);
        aStar();
        finalState = queue.peek();
    }

    private void aStar() {
        solvable = true;
        queue.add(root);
        SearchNode previous = null;
        while(!queue.peek().currentState.isGoal()){
            previous = queue.poll();
            for(Board b : previous.currentState.neighbors()){
                if (b != previous.currentState){
                    queue.add(new SearchNode(b, previous, previous.countMoves+1));
                }
            }
        }
    }

    public boolean isSolvable() {
        return solvable;
    }

    public int moves() {
        if(!solvable){
            return -1;
        }
        return finalState.countMoves;
    }

    public Iterable<Board> solution() {
        List<Board> res = new ArrayList<>();
        SearchNode state = finalState;
        res.add(state.currentState);
        while (state.previousState != null){
            res.add(state.previousState.currentState);
            state=state.previousState;
        }
        Collections.reverse(res);
        return res;
    }

    public static void main(String[] args) {
        // create initial board from file
        In in = new In(args[0]);
        int N = in.readInt();
        int[][] blocks = new int[N][N];
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                blocks[i][j] = in.readInt();
        Board initial = new Board(blocks);

        // solve the puzzle
        Solver solver = new Solver(initial);

        // print solution to standard output
        if (!solver.isSolvable())
            StdOut.println("No solution possible");
        else {
            StdOut.println("Minimum number of moves = " + solver.moves());
            for (Board board : solver.solution())
                StdOut.println(board);
        }
    }
}
