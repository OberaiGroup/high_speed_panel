#include <iostream>

#include "gmodel.hpp"

int main()
{
  using namespace gmod;

  // Length, width, thickness in inches
  double l = 12.0/2.0;
  double w = 10.0/2.0;
  double t = 0.065;

  // Bottom outside edging, "L" shape
  auto pt_1 = new_point2( gmod::Vector{ 0, 0, 0});
  auto pt_2 = new_point2( gmod::Vector{ l, 0, 0});
  auto pt_3 = new_point2( gmod::Vector{ l, w, 0});
  auto pt_4 = new_point2( gmod::Vector{ 0, w, 0});
  auto pt_5 = new_point2( gmod::Vector{ t, t, 0});
  auto pt_6 = new_point2( gmod::Vector{ l, t, 0});
  auto pt_7 = new_point2( gmod::Vector{ t, w, 0});

  auto line_1 = gmod::new_line2(pt_1, pt_2);
  auto line_2 = gmod::new_line2(pt_2, pt_6);
  auto line_3 = gmod::new_line2(pt_6, pt_5);
  auto line_4 = gmod::new_line2(pt_5, pt_7);
  auto line_5 = gmod::new_line2(pt_7, pt_4);
  auto line_6 = gmod::new_line2(pt_4, pt_1);

  auto curve_loop_1 = new_loop();
  add_use( curve_loop_1, FORWARD, line_1);
  add_use( curve_loop_1, FORWARD, line_2);
  add_use( curve_loop_1, FORWARD, line_3);
  add_use( curve_loop_1, FORWARD, line_4);
  add_use( curve_loop_1, FORWARD, line_5);
  add_use( curve_loop_1, FORWARD, line_6);

  auto surface_1 = new_plane();
  add_use( surface_1, FORWARD, curve_loop_1);

  write_closure_to_geo( surface_1, "quarter_plate.geo");
  write_closure_to_dmg( surface_1, "quarter_plate.dmg");

  // Bottom inside, towards center of plate
  auto line_7 = gmod::new_line2( pt_6, pt_3);
  auto line_8 = gmod::new_line2( pt_3, pt_7);

  auto curve_loop_2 = new_loop();
  add_use( curve_loop_2, FORWARD, line_7);
  add_use( curve_loop_2, FORWARD, line_8);
  add_use( curve_loop_2, REVERSE, line_4);
  add_use( curve_loop_2, REVERSE, line_3);

  auto surface_2 = new_plane();
  add_use( surface_2, FORWARD, curve_loop_2);


  // Top surface
  auto pt_8  = new_point2( gmod::Vector{ 0, 0, t});
  auto pt_9  = new_point2( gmod::Vector{ l, 0, t});
  auto pt_10 = new_point2( gmod::Vector{ l, w, t});
  auto pt_11 = new_point2( gmod::Vector{ 0, w, t});

  auto line_9  = gmod::new_line2( pt_8,  pt_9);
  auto line_10 = gmod::new_line2( pt_9,  pt_10);
  auto line_11 = gmod::new_line2( pt_10, pt_11);
  auto line_12 = gmod::new_line2( pt_11, pt_8);

  auto curve_loop_3 = new_loop();
  add_use( curve_loop_3, FORWARD, line_9);
  add_use( curve_loop_3, FORWARD, line_10);
  add_use( curve_loop_3, FORWARD, line_11);
  add_use( curve_loop_3, FORWARD, line_12);

  auto surface_3 = new_plane();
  add_use( surface_3, FORWARD, curve_loop_3);

  // Side Edges
  auto line_13 = gmod::new_line2( pt_1, pt_8);
  auto line_14 = gmod::new_line2( pt_2, pt_9);
  auto line_15 = gmod::new_line2( pt_3, pt_10);
  auto line_16 = gmod::new_line2( pt_4, pt_11);

  auto curve_loop_4 = new_loop();
  add_use( curve_loop_4, FORWARD, line_1);
  add_use( curve_loop_4, FORWARD, line_14);
  add_use( curve_loop_4, REVERSE, line_9);
  add_use( curve_loop_4, REVERSE, line_13);

  auto surface_4 = new_plane();
  add_use( surface_4, FORWARD, curve_loop_4);


  auto curve_loop_5 = new_loop();
  add_use( curve_loop_5, REVERSE, line_5);
  add_use( curve_loop_5, REVERSE, line_8);
  add_use( curve_loop_5, FORWARD, line_15);
  add_use( curve_loop_5, FORWARD, line_11);
  add_use( curve_loop_5, REVERSE, line_16);

  auto surface_5 = new_plane();
  add_use( surface_5, FORWARD, curve_loop_5);


  auto curve_loop_6 = new_loop();
  add_use( curve_loop_6, FORWARD, line_2);
  add_use( curve_loop_6, FORWARD, line_7);
  add_use( curve_loop_6, FORWARD, line_15);
  add_use( curve_loop_6, REVERSE, line_10);
  add_use( curve_loop_6, REVERSE, line_14);

  auto surface_6 = new_plane();
  add_use( surface_6, FORWARD, curve_loop_6);


  auto curve_loop_7 = new_loop();
  add_use( curve_loop_7, REVERSE, line_6);
  add_use( curve_loop_7, FORWARD, line_16);
  add_use( curve_loop_7, FORWARD, line_12);
  add_use( curve_loop_7, REVERSE, line_13);

  auto surface_7 = new_plane();
  add_use( surface_7, FORWARD, curve_loop_7);


  // Create the shell, then volume
  auto shell = new_shell();
  add_use( shell, REVERSE, surface_1);
  add_use( shell, REVERSE, surface_2);
  add_use( shell, FORWARD, surface_3);
  add_use( shell, FORWARD, surface_4);
  add_use( shell, REVERSE, surface_5);
  add_use( shell, FORWARD, surface_6);
  add_use( shell, REVERSE, surface_7);

  auto model = new_volume2( shell);

  write_closure_to_geo( model, "quarter_plate.geo");
  write_closure_to_dmg( model, "quarter_plate.dmg");

  return 0;
}
