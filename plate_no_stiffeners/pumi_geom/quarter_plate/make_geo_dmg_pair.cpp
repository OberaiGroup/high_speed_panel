#include <iostream>

#include "gmodel.hpp"

int main()
{
  using namespace gmod;

  // Length, width, thickness in inches
  double l = 12.0/2.0;
  double w = 10.0/2.0;
  double t = 0.065;

  auto c = gmod::new_cube(
      gmod::Vector{ 0, 0, 0},
      gmod::Vector{ l, 0, 0},
      gmod::Vector{ 0, w, 0},
      gmod::Vector{ 0, 0, t});

  auto ring_corner = gmod::Vector{ t, t, 0};
  auto ring_x_end  = gmod::Vector{ l, t, 0};
  auto ring_y_end  = gmod::Vector{ t, w, 0};

  auto ring_x = gmod::new_line4(ring_x_end, ring_corner);
  auto ring_y = gmod::new_line4(ring_y_end, ring_corner);

  gmod::embed(c, ring_x);
  gmod::embed(c, ring_y);

  write_closure_to_geo( c, "quarter_plate.geo");
  write_closure_to_dmg( c, "quarter_plate.dmg");

  return 0;
}
