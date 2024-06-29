#ifndef __NODE_HPP__
#define __NODE_HPP__

#include <string>
#include <vector>
#include <iostream>
#include "definitions.hpp"

struct node
{
  std::string name; // "MAX" or "MIN".
  int value; // value of this node. Could be a real value or: UNKNOWN, CUT, TRANSPOSITION, LOSE, WIN.
  int nb_children; // number of possible actions from this node.
  int bound; // EXACT, LOWER_BOUND or UPPER_BOUND.
  int state; // game state.
  std::vector<node> children;

  node(const std::string& name = "", int value = UNKNOWN, int nb_children = 0, int bound = EXACT, int state = -1);

  // to display the tree rooted at this node (no need to understand).
  void display(std::ostream& os, bool show_state = false) const;
  void display(std::ostream& os, std::string prefix, bool show_state = false) const;
  void display_children(std::ostream& os, std::string prefix, bool show_state) const;
};

#endif
