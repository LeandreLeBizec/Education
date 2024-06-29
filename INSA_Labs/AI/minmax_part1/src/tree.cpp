#include "tree.hpp"

using namespace std;

tree::tree(int depth, int branching_factor, int seed, float proba, bool absolute)
  : generator(seed), 
    proba(proba),
    absolute(absolute),
    value_distribution(LOSE, WIN)
{    
  root = init(depth, branching_factor, 0);
  if (proba != 0)
    {
      vector<pair<int, node>> nodes;
      collect_internal_nodes(root, 0, nodes);
      merge(root, 0, nodes);
    }
}

void tree::collect_internal_nodes(node& n, int depth, vector<pair<int, node>>& res)
{
  if (n.nb_children == 0) return;
  uniform_real_distribution<float> proba_distribution(0, 1);
  if (depth != 0 && proba_distribution(generator) <= 0.5)
    {
      res.emplace_back(depth, n);
      return;
    }
  for (int i = 0; i < n.nb_children; ++i)
    {
      collect_internal_nodes(n.children[i], depth + 1, res);
    }
}

void tree::merge(node& n, int depth, const vector<pair<int, node>>& nodes)
{
  if (n.nb_children == 0) return;
  uniform_real_distribution<float> proba_distribution(0, 1);
  if (proba_distribution(generator) < proba && n.state != root.state)
    {
      int N = nodes.size();
      uniform_int_distribution<int> d(0, N - 1);
      int k = d(generator);	
      for (int i = 0; i < N; ++i)
	{
	  const auto& p = nodes[k];
	  if (p.second.name == n.name && p.first >= depth)
	    {
	      n = p.second;
	      return;
	    }
	  ++k;
	  if (k == N) k = 0;
	}
    }
  for (int i = 0; i < n.nb_children; ++i) 
    {
      merge(n.children[i], depth + 1, nodes);
    }
} 

int tree::get_state()
{
  return counter++;
}

node tree::init(int depth, int branching_factor, int player)
{
  if (depth == 0) return node(player == 0 ? "MAX" : "MIN", value_distribution(generator), EXACT, 0, get_state());
  node res(player == 0 ? "MAX" : "MIN", UNKNOWN, branching_factor, EXACT, get_state());
  for (int i = 0; i < branching_factor; ++i)
    {
      res.children[i] = init(depth - 1, branching_factor, 1 - player);
    }
  return res;
}

void tree::apply(function<void(tree&)> solver)
{
  solver(*this);
}
  
void tree::display_with_state(ostream& os)
{
  root.display(os, true);
}

ostream& operator<<(ostream& os, const tree& t)
{
  t.root.display(os);
  return os;
}
