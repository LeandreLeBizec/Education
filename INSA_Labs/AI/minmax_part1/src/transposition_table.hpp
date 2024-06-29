#ifndef __TRANSPOSITION_TABLE_HPP__
#define __TRANSPOSITION_TABLE_HPP__

#include <unordered_map>
#include "definitions.hpp"

struct entry
{
  int depth;        // Depth in the game tree (bigger value at the root).
  int move;         // The best move in this game state.
  int type = EXACT; // The value is EXACT, a LOWER_BOUND or an UPPER_BOUND.
  int value;        // The value of this game state.
};

class transposition_table
{
  std::unordered_map<int, entry> table;
public:
  transposition_table(int size = 1024);

  // Is the state 'state' in the transposition table?
  bool exists(int state) const;  

  // Get the entry corresponding to game state 'state'.
  entry& get(int state);

  // Reset the transposition table.
  void clear();
};

#endif
