#ifndef __DEFINITIONS_HPP__
#define __DEFINITIONS_HPP__

#include <limits>

static const int UNKNOWN = std::numeric_limits<int>::min(); // We don't know the value of this node in the game tree.
static const int CUT = std::numeric_limits<int>::min() + 1; // We cut this node using alpha beta or the transposition table.
static const int TRANSPOSITION = std::numeric_limits<int>::min() + 2; // We found the game state of this node in the transposition table.
static const int INF = std::numeric_limits<int>::max(); // +oo
static const int WIN = 100;   // Maximum game value
static const int LOSE = -WIN; // Minimum game value 

static const int LOWER_BOUND = -1; // The value v of this node is a lower bound on the real value f of this node (f >= v).
static const int EXACT = 0;        // This is the exact value of the node.
static const int UPPER_BOUND = 1;  // The value v of this node is an upper bound on the real value f of this node (f =< v).

#endif
