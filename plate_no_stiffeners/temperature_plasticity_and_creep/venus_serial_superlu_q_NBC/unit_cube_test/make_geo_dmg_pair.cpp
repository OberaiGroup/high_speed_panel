#include <iostream>

#include "gmodel.hpp"

int main()
{
  using namespace gmod;

  // Length, width, thickness in inches
  double l = 1.0;
  double w = 1.0;
  double t = 1.0;

  // Bottom edging
  auto pt_1 = new_point2( gmod::Vector{ 0, 0, 0});
  auto pt_2 = new_point2( gmod::Vector{ l, 0, 0});
  auto pt_3 = new_point2( gmod::Vector{ l, w, 0});
  auto pt_4 = new_point2( gmod::Vector{ 0, w, 0});

  auto line_1 = gmod::new_line2(pt_1, pt_2);
  auto line_2 = gmod::new_line2(pt_2, pt_3);
  auto line_3 = gmod::new_line2(pt_3, pt_4);
  auto line_4 = gmod::new_line2(pt_4, pt_1);

  auto curve_loop_1 = new_loop();
  add_use( curve_loop_1, FORWARD, line_1);
  add_use( curve_loop_1, FORWARD, line_2);
  add_use( curve_loop_1, FORWARD, line_3);
  add_use( curve_loop_1, FORWARD, line_4);

  auto surface_1 = new_plane();
  add_use( surface_1, FORWARD, curve_loop_1);

  write_closure_to_geo( surface_1, "cube.geo");
  write_closure_to_dmg( surface_1, "cube.dmg");

  // Top surface
  auto pt_5 = new_point2( gmod::Vector{ 0, 0, t});
  auto pt_6 = new_point2( gmod::Vector{ l, 0, t});
  auto pt_7 = new_point2( gmod::Vector{ l, w, t});
  auto pt_8 = new_point2( gmod::Vector{ 0, w, t});

  auto line_5 = gmod::new_line2( pt_5, pt_6);
  auto line_6 = gmod::new_line2( pt_6, pt_7);
  auto line_7 = gmod::new_line2( pt_7, pt_8);
  auto line_8 = gmod::new_line2( pt_8, pt_5);

  auto curve_loop_2 = new_loop();
  add_use( curve_loop_2, FORWARD, line_5);
  add_use( curve_loop_2, FORWARD, line_6);
  add_use( curve_loop_2, FORWARD, line_7);
  add_use( curve_loop_2, FORWARD, line_8);

  auto surface_2 = new_plane();
  add_use( surface_2, FORWARD, curve_loop_2);

  // Side Edges
  auto line_9  = gmod::new_line2( pt_1, pt_5);
  auto line_10 = gmod::new_line2( pt_2, pt_6);
  auto line_11 = gmod::new_line2( pt_3, pt_7);
  auto line_12 = gmod::new_line2( pt_4, pt_8);

  auto curve_loop_3 = new_loop();
  add_use( curve_loop_3, FORWARD, line_1);
  add_use( curve_loop_3, FORWARD, line_10);
  add_use( curve_loop_3, REVERSE, line_5);
  add_use( curve_loop_3, REVERSE, line_9);

  auto surface_3 = new_plane();
  add_use( surface_3, FORWARD, curve_loop_3);


  auto curve_loop_4 = new_loop();
  add_use( curve_loop_4, FORWARD, line_2);
  add_use( curve_loop_4, FORWARD, line_11);
  add_use( curve_loop_4, REVERSE, line_6);
  add_use( curve_loop_4, REVERSE, line_10);

  auto surface_4 = new_plane();
  add_use( surface_4, FORWARD, curve_loop_4);


  auto curve_loop_5 = new_loop();
  add_use( curve_loop_5, FORWARD, line_3);
  add_use( curve_loop_5, FORWARD, line_12);
  add_use( curve_loop_5, REVERSE, line_7);
  add_use( curve_loop_5, REVERSE, line_11);

  auto surface_5 = new_plane();
  add_use( surface_5, FORWARD, curve_loop_5);


  auto curve_loop_6 = new_loop();
  add_use( curve_loop_6, FORWARD, line_4);
  add_use( curve_loop_6, FORWARD, line_9);
  add_use( curve_loop_6, REVERSE, line_8);
  add_use( curve_loop_6, REVERSE, line_12);

  auto surface_6 = new_plane();
  add_use( surface_6, FORWARD, curve_loop_6);


  // Create the shell, then volume
  auto shell = new_shell();
  add_use( shell, REVERSE, surface_1);
  add_use( shell, FORWARD, surface_2);
  add_use( shell, FORWARD, surface_3);
  add_use( shell, FORWARD, surface_4);
  add_use( shell, REVERSE, surface_5);
  add_use( shell, REVERSE, surface_6);

  auto model = new_volume2( shell);

  write_closure_to_geo( model, "cube.geo");
  write_closure_to_dmg( model, "cube.dmg");

  return 0;
}
