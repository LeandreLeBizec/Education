#include "node.hpp"

using namespace std;

node::node(const string& name, int value, int nb_children, int bound, int state)
    : name(name), value(value), nb_children(nb_children), 
      bound(bound), state(state), children(nb_children) 
{
}

void node::display(ostream& os, bool show_state) const
{
  display(os, "", show_state);
  os << endl;
}

void node::display(ostream& os, string prefix, bool show_state) const
{
  string value_with_padding = (value == CUT ? "X" :
			       value == TRANSPOSITION ? "#" :
			       value == UNKNOWN ? "?" : 
			       value == LOSE ? "-oo" :
			       value == WIN  ? "+oo" : to_string(value));
  value_with_padding = (bound == UPPER_BOUND ? "=<" : 
			bound == LOWER_BOUND ? ">=" : "") + value_with_padding;
  int l = 5 - value_with_padding.size();
  if (l >= 0) value_with_padding.insert(value_with_padding.begin(), l, '_');
  string state_with_padding = "s" + to_string(state);
  l = 5 - state_with_padding.size();
  if (l >= 0) state_with_padding.insert(state_with_padding.begin(), l, ' ');
  string s = name + (show_state ? state_with_padding : "") + ":" + value_with_padding;
  os << s;
  unsigned int w = s.size();
  string new_prefix = prefix + string(w + 1, ' ');
  if (nb_children == 0) return;
  if (nb_children == 1)
    {
      os << "---";
      children[0].display(os, new_prefix + "  ", show_state);
      return;
    }
  os << "-";
  display_children(os, new_prefix, show_state);
}

void node::display_children(ostream& os, string prefix, bool show_state) const
{
  os << "+-";
  children[0].display(os, prefix + "| ", show_state);
  os << endl;
  os << prefix;
  for (int i = 1; i < nb_children - 1; ++i) 
    {
      os << "|-";
      children[1].display(os, prefix + "| ", show_state);
      os << endl;
      os << prefix;
    }
  os << "`-";
  children[nb_children - 1].display(os, prefix + "  ", show_state);
}
