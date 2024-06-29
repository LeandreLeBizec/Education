#include "transposition_table.hpp"

using namespace std;

transposition_table::transposition_table(int size) : table(size)
{
}

bool transposition_table::exists(int state) const
{
  return table.count(state);
}
 
entry& transposition_table::get(int state)
{
  return table[state];
}

void transposition_table::clear()
{
  table.clear();
}
