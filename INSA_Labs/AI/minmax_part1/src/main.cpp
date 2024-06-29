#include "tree.hpp"

using namespace std;

// Cut this node and all nodes below it.
void cut(node& n)
{
  n.value = CUT;
  for (int i = 0; i < n.nb_children; ++i)
    {
      cut(n.children[i]);
    }
}

// Number of nodes we have visited in the game tree.
int nb_nodes = 0;

// MINMAX
int min_value(node& n);
int max_value(node& n)
{
  ++nb_nodes;
  if (n.nb_children == 0) return n.value;
  int res = -INF;
  for (int i = 0; i < n.nb_children; ++i)
    {
      res = max(res, min_value(n.children[i]));
    }
  n.value = res;
  return res;
}

int min_value(node& n)
{
  ++nb_nodes;
  if (n.nb_children == 0) return n.value;
  int res = INF;
  for (int i = 0; i < n.nb_children; ++i)
    {
      res = min(res, max_value(n.children[i]));
    }
  n.value = res;
  return res;
}

void minmax(tree& t)
{
  nb_nodes = 0;
  max_value(t.root);
  cout << t << endl;
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}

// MINMAX ALPHA BETA
int min_value_alpha_beta(node& n, int alpha, int beta);
int max_value_alpha_beta(node& n, int alpha, int beta)
{
  ++nb_nodes;
  if (n.nb_children == 0) return n.bound = EXACT, n.value;
  // By default, we set the bound to upper. It corresponds to the case where
  // all of our children return a value v <= alpha. So they have been cut-off by
  // the alpha bound and so they could have got a better value (note that it is
  // possible that this value is exact, you should see an example in the example tree)
  n.bound = UPPER_BOUND;
  int res = -INF;
  for (int i = 0; i < n.nb_children; ++i)
    {
      int v = min_value_alpha_beta(n.children[i], alpha, beta);
      if (v >= beta)
        {
          n.value = v;
          // If we cut in a MAX node, the value is a lower bound because we could have got better if allowed to scan all the children.
          n.bound = LOWER_BOUND;
          // The following line is here just to decorate the tree and is not present
          // in a real max alpha/beta function
          for (++i; i < n.nb_children; ++i) cut(n.children[i]);
          return v;
        }
      if (v > alpha)
        {
          // The value is exact because it has not been cut-off by any lower node
          n.bound = EXACT;
        }
      alpha = max(alpha, v);
      res = max(v, res);
    }
  n.value = res;
  return res;
}

int min_value_alpha_beta(node& n, int alpha, int beta)
{
  ++nb_nodes;
  if (n.nb_children == 0) return n.bound = EXACT, n.value;
  n.bound = LOWER_BOUND;
  int res = INF;
  for (int i = 0; i < n.nb_children; ++i)
    {
      int v = max_value_alpha_beta(n.children[i], alpha, beta);
      if (v <= alpha)
        {
          n.value = v;
          n.bound = UPPER_BOUND;
          for (++i; i < n.nb_children; ++i) cut(n.children[i]);
          return v;
        }
      if (v < beta) n.bound = EXACT;
      beta = min(beta, v);
      res = min(v, res);
    }
  n.value = res;
  return res;
}

void minmax_alpha_beta(tree& t)
{
  nb_nodes = 0;
  max_value_alpha_beta(t.root, LOSE, WIN);
  cout << t << endl;
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}


// NEGAMAX

// Q1) In the minmax function, the min_value and max_value functions are very similar. We
// can avoid duplicating the code by evaluating the leaves from the point of view of the current
// player and not, as we did for minmax, from the point of view of the MAX player.
// Now, we can write a single function that maximize the negative value of the other player.

// Note: negamax evaluates positions from the point of view of each player. This
// is different from minmax which evaluates positions from the point of view of the
// MAX player. Therefore, the negamax value and the minmax value will be different for the
// same game tree.
int negamax(node& n)
{
  // TO DO
  return 0;
}

void negamax(tree& t)
{
  nb_nodes = 0;
  negamax(t.root);
  cout << t << endl;
  cout << nb_nodes << endl;
}
// END Q1)


// NEGAMAX ALPHA BETA

// Q2) We can avoid the duplication of code in the minmax_alpha_beta function by using the previous idea.
//     From one call of negamax_alpha_beta to the other, -beta will become the alpha value of the other player, and -alpha will
//     become the beta value for the other player.
int negamax_alpha_beta(node& n, int alpha, int beta)
{
  // TO DO
  return 0;
}

void negamax_alpha_beta(tree& t)
{
  nb_nodes = 0;
  negamax_alpha_beta(t.root, LOSE, WIN);
  cout << t << endl;
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}
// END Q2)

// The following function is based on the following theorem (Knuth and Moore):
// The return value g of an alpha-beta search with window ]alpha, beta[ can be one of three things:
//   1) alpha < g < beta. g is equal to the minmax value f of the game tree.
//   2) g <= alpha (failing low). g is an upper bound on the minmax value f of the game, or f <= g.
//   3) g >= beta (failing high). g is a lower bound on the minmax value f of the game, or f >= g.

// mtdf uses a null-window search to cut a lot of nodes, and uses the value g to update its search window based
// on the previous theorem.
void mtdf_without_memory(const tree& t)
{
  nb_nodes = 0;
  int lower_bound = LOSE;
  int upper_bound = WIN;
  int alpha = 0, beta = 1;
  // We use a null window search (]beta - 1 (= alpha), beta[) to cut a maximum number of nodes.
  // Because of the size of this window, max_value_alpha_beta will return an inexact value g.
  // But we know that if g >= beta, g is a lower bound on the minmax value.
  // Whereas, if g < beta (g <= alpha), g is an upper bound on the minmax value.
  // When the lower_bound is equal to the upper_bound, we have found the minmax value of the game.

  // Note that without using a transposition table, this is not very usefull because we will actually
  // explore more nodes. But with a transposition table this is good stuff! (the last question will
  // show it).
  while (lower_bound < upper_bound)
    {
      cout << "[" << lower_bound << ".." << upper_bound << "]" << endl;
      cout << "alpha = " << alpha << ", beta = " << beta << endl;
      tree t1 = t;
      int v = max_value_alpha_beta(t1.root, alpha, beta);
      if (v < beta) upper_bound = v, alpha = v - 1;
      else lower_bound = v, alpha = v;
      beta = alpha + 1;
      cout << t1 << endl;
      string _;
      getline(cin, _);
    }
  cout << "Game value: " << lower_bound << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}

// MTDBI WITHOUT MEMORY
// Q3) mtdbi uses the same idea as mtdf, but we binary search the interval [lower_bound, upper_boud]
//     to find the minmax value.
void mtdbi_without_memory(const tree& t)
{
  nb_nodes = 0;
  int lower_bound = LOSE;
  int upper_bound = WIN;
  int alpha = 0, beta = 1;
  while (lower_bound < upper_bound)
    {
      cout << "[" << lower_bound << ".." << upper_bound << "]" << endl;
      cout << "alpha = " << alpha << ", beta = " << beta << endl;
      tree t1 = t;
      // TO DO: as mtdf but using binary search.
      cout << t1 << endl;
      string _;
      getline(cin, _);
    }
  cout << "Game value: " << lower_bound << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}
// END Q3)




// WITH MEMORY

/*
          _.-'~~~~~~`-._
         /      ||      \
        /       ||       \
       |        ||        |
       | _______||_______ |
       |/ ----- \/ ----- \|
      /  (     )  (     )  \
     / \  ----- () -----  / \        ________________________________________________
    /   \      /||\      /   \      /                                                \
   /     \    /||||\    /     \  __/ Now we will unleash the full power of the force! |
  /       \  /||||||\  /       \   \_________________________________________________/
 /_        \o========o/        _\
   `--...__|`-._  _.-'|__...--'
           |    `'    |
*/

#include "transposition_table.hpp"
transposition_table transposition;

// MINMAX WITH MEMORY
int min_value_with_memory(node& n);
int max_value_with_memory(node& n)
{
  ++nb_nodes;
  if (n.nb_children == 0) return n.value;
  bool already_seen = transposition.exists(n.state);
  entry& e = transposition.get(n.state);
  // We have already seen the game state corresponding to this node.
  // We get its value from the transposition table.
  if (already_seen) { cut(n); n.value = TRANSPOSITION; return e.value; }
  int res = -INF;
  for (int i = 0; i < n.nb_children; ++i)
    {
      res = max(res, min_value_with_memory(n.children[i]));
    }
  n.value = res;
  // We add the value of the game state corresponding to this node to the transposition table.
  e.value = res;
  return res;
}

int min_value_with_memory(node& n)
{
  ++nb_nodes;
  if (n.nb_children == 0) return n.value;
  bool already_seen = transposition.exists(n.state);
  entry& e = transposition.get(n.state);
  if (already_seen) { cut(n); n.value = TRANSPOSITION; return e.value; }
  int res = INF;
  for (int i = 0; i < n.nb_children; ++i)
    {
      res = min(res, max_value_with_memory(n.children[i]));
    }
  n.value = res;
  e.value = res;
  return res;
}

void minmax_with_memory(tree& t)
{
  nb_nodes = 0;
  transposition.clear();
  max_value_with_memory(t.root);
  cout << t << endl;
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}

// NEGAMAX WITH MEMORY
// Q4) Add the transposition table into the negamax function.
int negamax_with_memory(node& n)
{
  // TO DO
  return 0;
}

void negamax_with_memory(tree& t)
{
  nb_nodes = 0;
  transposition.clear();
  negamax_with_memory(t.root);
  cout << t << endl;
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}
// END Q4)

// MINMAX ALPHA BETA WITH MEMORY
// Q5) Add the transposition table into the minmax_alpha_beta function.
//     You need to refer to the algorithm described in the minmax_ab.pdf document.
int min_value_alpha_beta_with_memory(node& n, int alpha, int beta);
int max_value_alpha_beta_with_memory(node& n, int alpha, int beta)
{
  // TO DO
  return 0;
}

int min_value_alpha_beta_with_memory(node& n, int alpha, int beta)
{
  // TO DO
  return 0;
}

void minmax_alpha_beta_with_memory(tree& t)
{
  nb_nodes = 0;
  transposition.clear();
  max_value_alpha_beta_with_memory(t.root, LOSE, WIN);
  cout << t << endl;
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}
// END Q5)

// NEGAMAX ALPHA BETA WITH MEMORY
// Q6) Add the transposition table into the negamax alpha beta function. Should be
//     easier now that you have brilliantly written the minmax alpha beta with memory.
int negamax_alpha_beta_with_memory(node& n, int alpha, int beta)
{
  // TO DO
  return 0;
}

void negamax_alpha_beta_with_memory(tree& t)
{
  nb_nodes = 0;
  transposition.clear();
  negamax_alpha_beta_with_memory(t.root, LOSE, WIN);
  cout << t << endl; // <-- comment this line for Q7) or be prepared for desolation.
  cout << "Game value: " << t.root.value << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}
// END Q6)

// MTDBI
// Q7) Now for the big boss. You should have only one thing to modify from your
//     version of mtdbi_without_memory.
void mtdbi(const tree& t)
{
  nb_nodes = 0;
  transposition.clear();
  int lower_bound = LOSE;
  int upper_bound = WIN;
  int alpha = 0, beta = 1;
  while (lower_bound < upper_bound)
    {
      tree t1 = t;
      // TO DO
    }
  cout << "Game value: " << lower_bound << endl;
  cout << "Number of nodes: " << nb_nodes << endl << endl;
}
// END Q7)

int main(int argc, char *argv[])
{
  // WITHOUT MEMORY
  // When using minmax and minmax alpha beta, you must get the SAME game value. But you should visit
  // less nodes with the alpha beta version.

  // When using negamax and negamax alpha beta, you must get the SAME game value. But you should visit
  // less nodes with the alpha beta version. Note that you won't get the same game value you obtained from minmax
  // and minmax alpha beta.

  tree game_tree(3, 3);
  tree game_tree1 = game_tree;
  tree game_tree2 = game_tree;
  tree game_tree3 = game_tree;
  tree game_tree4 = game_tree;
  tree game_tree5 = game_tree;

  cout << game_tree << endl;

  // minmax
  game_tree.apply([](tree& t) { minmax(t); });

  // minmax alpha beta
  game_tree1.apply([](tree& t) { minmax_alpha_beta(t); });

  // Q1)
  // negamax
  // game_tree2.apply([](tree& t) { negamax(t); }); // <-- uncomment this line for Q1)
  // END Q1)

  // Q2)
  // negamax alpha beta
  // game_tree3.apply([](tree& t) { negamax_alpha_beta(t); }); // <-- uncomment this line for Q2)
  // END Q2)



  // With mtdf and mtdbi without memory, you must get the same game value as minmax (or minmax alpha beta), but
  // you will explore more nodes (because we don't yet use a transposition table).

  // Q3)
  // mtdf without memory
  // game_tree4.apply([](tree& t) { mtdf_without_memory(t); }); // <-- uncomment this line for Q3)

  // mtdbi without memory
  // game_tree5.apply([](tree& t) { mtdbi_without_memory(t); }); // <-- uncomment this line for Q3)
  // END Q3)

  // After completing Q3), comment all code from beginning of main to here


  // WITH MEMORY
  // You should decrease the number of visited nodes when using a transposition table, but you must not
  // change the game value.

  // We create a tree with transpositions (some common game states in different nodes of the game tree).
  // tree game_tree(3, 3, 0, 0.8); // <-- uncomment this line after Q3)
  // tree game_tree1 = game_tree;  // <-- uncomment this line after Q3)
  // tree game_tree2 = game_tree;  // <-- uncomment this line after Q3)
  // tree game_tree3 = game_tree;  // <-- uncomment this line after Q3)
  // tree game_tree4 = game_tree;  // <-- uncomment this line after Q3)

  // cout << game_tree << endl; // <-- uncomment this line after Q3)
  // game_tree.display_with_state(cout); // <-- uncomment this line after Q3)

  // minmax without memory
  // game_tree.apply([](tree& t) { minmax(t); }); // <-- uncomment this line after Q3)

  // minmax with memory
  // game_tree1.apply([](tree& t) { minmax_with_memory(t); }); // <-- uncomment this line after Q3)

  // Q4)
  // negamax with memory
  // game_tree2.apply([](tree& t) { negamax_with_memory(t); }); // <-- uncomment this line for Q4)
  // END Q4)

  // Q5)
  // minmax alpha beta with memory
  // game_tree3.apply([](tree& t) { minmax_alpha_beta_with_memory(t); }); // <-- uncomment this line for Q5)
  // END Q5)

  // Q6)
  // negamax alpha beta with memory
  // game_tree4.apply([](tree& t) { negamax_alpha_beta_with_memory(t); }); // <-- uncomment this line for Q6)
  // END Q6)



  // After completing Q6), comment all code from beginning of main to here

  // tree game_tree(9, 4, 3, 0.25); // <-- uncomment this line after Q6)
  // tree game_tree1 = game_tree;  // <-- uncomment this line after Q6)

  // game_tree.apply([](tree& t) { negamax_alpha_beta_with_memory(t); }); // <-- uncomment this line after Q6)


  // Compared to negamax_alpha_beta_with_memory, you should get less visited nodes with mtdbi.

  // Q7)
  // game_tree1.apply([](tree& t) { mtdbi(t); }); // <-- uncomment this line for Q7)
  // END Q7)

  return 0;
}
