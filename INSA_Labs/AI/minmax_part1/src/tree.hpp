#ifndef __TREE_HPP__
#define __TREE_HPP__

#include "definitions.hpp"
#include "node.hpp"
#include <random>
#include <vector>
#include <functional>

struct tree
{
  node root; // The root of the game tree.
  std::mt19937 generator; // No need to understand (stuff to create the tree)
  float proba;            // No need to understand (stuff to create the tree)
  bool absolute;          // No need to understand (stuff to create the tree)
  std::uniform_int_distribution<int> value_distribution; // No need to understand (stuff to create the tree)
  int counter = 0; // No need to understand (stuff to create the tree)

  // Create a tree with depth 'depth' and branching factor 'branching_factor'. To change
  // the values of the leaves use a different seed 'seed'.
  // 'proba' and 'absolute' are used to generate trees with transpositions.
  tree(int depth, int branching_factor, int seed = 0, float proba = 0, bool absolute = true);

  // We apply the solver (minmax, minmax alpha beta, negamax, ...) to the tree.
  // The nodes of the tree will be updated.
  void apply(std::function<void(tree&)> solver);
  
  // Print showing game state in each node.
  void display_with_state(std::ostream& os);


  // No need to understand the following

  void collect_internal_nodes(node& n, int depth, std::vector<std::pair<int, node>>& res);

  void merge(node& n, int depth, const std::vector<std::pair<int, node>>& nodes);

  int get_state();

  node init(int depth, int branching_factor, int player);
};

std::ostream& operator<<(std::ostream& os, const tree& t);

#endif
