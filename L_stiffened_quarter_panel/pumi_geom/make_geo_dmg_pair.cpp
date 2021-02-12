#include <iostream>

#include "gmodel.hpp"

int main()
{
  using namespace gmod;

  double inches_per_meter = 39.3701;

  // Length, width, thickness, and stiffener height in inches
  double l = 12.0/2.0; // Full length is 12.0 inches
  double w = 10.0/2.0; // Full width is 10.0 inches
  double t = 0.065; // Material thickenss, inches
  double h = 1.25;  // Length of the stiffeners from the bottom 
                    // of the plate into the craft

  // Convert to meters
  l = l/inches_per_meter;
  w = w/inches_per_meter;
  t = t/inches_per_meter;
  h = h/inches_per_meter;


  ///////// Define all points

  // All on Z=0 plane
  auto pt_0 = new_point2( gmod::Vector{0.0, 0.0, 0.0});
  auto pt_1 = new_point2( gmod::Vector{  l, 0.0, 0.0});
  auto pt_2 = new_point2( gmod::Vector{  l,   t, 0.0});
  auto pt_3 = new_point2( gmod::Vector{  l, t+t, 0.0});
  auto pt_4 = new_point2( gmod::Vector{  l,   w, 0.0});
  auto pt_5 = new_point2( gmod::Vector{  t,   w, 0.0});
  auto pt_6 = new_point2( gmod::Vector{0.0,   w, 0.0});
  auto pt_7 = new_point2( gmod::Vector{  t, t+t, 0.0});
  auto pt_8 = new_point2( gmod::Vector{  t,   t, 0.0});

  // All on Z=t plane
  auto pt_9 = new_point2( gmod::Vector{  l,   w,   t});
  auto pt_10= new_point2( gmod::Vector{  l, 0.0,   t});
  auto pt_11= new_point2( gmod::Vector{0.0,   w,   t});
  auto pt_16= new_point2( gmod::Vector{0.0, 0.0,   t});

  // All on Z=-h plane
  auto pt_12 = new_point2( gmod::Vector{  l,   t, -h});
  auto pt_13 = new_point2( gmod::Vector{  l, t+t, -h});
  auto pt_14 = new_point2( gmod::Vector{  t, t+t, -h});
  auto pt_15 = new_point2( gmod::Vector{  t,   t, -h});

  
  ///////// Define all edges

  // All on Z=0 plane
  auto line_1 = gmod::new_line2(pt_0, pt_1);
  auto line_2 = gmod::new_line2(pt_1, pt_2);
  auto line_3 = gmod::new_line2(pt_2, pt_8);
  auto line_4 = gmod::new_line2(pt_8, pt_7);
  auto line_5 = gmod::new_line2(pt_7, pt_3);
  auto line_6 = gmod::new_line2(pt_3, pt_4);
  auto line_7 = gmod::new_line2(pt_4, pt_5);
  auto line_8 = gmod::new_line2(pt_5, pt_7);
  auto line_9 = gmod::new_line2(pt_5, pt_6);
  auto line_10= gmod::new_line2(pt_6, pt_0);
  
  // All on Z=t plane
  auto line_11= gmod::new_line2(pt_16, pt_10);
  auto line_12= gmod::new_line2(pt_10, pt_9);
  auto line_13= gmod::new_line2(pt_9,  pt_11);
  auto line_14= gmod::new_line2(pt_11, pt_16);

  // All on Z=-h plane
  auto line_15= gmod::new_line2(pt_15, pt_12);
  auto line_16= gmod::new_line2(pt_12, pt_13);
  auto line_17= gmod::new_line2(pt_13, pt_14);
  auto line_18= gmod::new_line2(pt_14, pt_15);

  // Vertical from Z=-h -> 0
  auto line_19= gmod::new_line2(pt_15, pt_8);
  auto line_20= gmod::new_line2(pt_14, pt_7);
  auto line_21= gmod::new_line2(pt_13, pt_3);
  auto line_22= gmod::new_line2(pt_12, pt_2);

  //Vertical from Z=0 -> t
  auto line_23= gmod::new_line2(pt_0, pt_16);
  auto line_24= gmod::new_line2(pt_1, pt_10);
  auto line_25= gmod::new_line2(pt_4, pt_9);
  auto line_26= gmod::new_line2(pt_6, pt_11);


  ///////// Define all curve loops, add to surfaces, close to model

  // All on Z=0 plane
  auto curve_loop_1 = new_loop();
  add_use( curve_loop_1, REVERSE, line_10);
  add_use( curve_loop_1, REVERSE, line_9);
  add_use( curve_loop_1, FORWARD, line_8);
  add_use( curve_loop_1, REVERSE, line_4);
  add_use( curve_loop_1, REVERSE, line_3);
  add_use( curve_loop_1, REVERSE, line_2);
  add_use( curve_loop_1, REVERSE, line_1);

  auto surface_1 = new_plane();
  add_use( surface_1, FORWARD, curve_loop_1);
  write_closure_to_geo( surface_1, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_1, "L_quarter_plate.dmg");

  auto curve_loop_2 = new_loop();
  add_use( curve_loop_2, REVERSE, line_8);
  add_use( curve_loop_2, REVERSE, line_7);
  add_use( curve_loop_2, REVERSE, line_6);
  add_use( curve_loop_2, REVERSE, line_5);

  auto surface_2 = new_plane();
  add_use( surface_2, FORWARD, curve_loop_2);
  write_closure_to_geo( surface_2, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_2, "L_quarter_plate.dmg");

  // Z=t plane
  auto curve_loop_3 = new_loop();
  add_use( curve_loop_3, FORWARD, line_11);
  add_use( curve_loop_3, FORWARD, line_12);
  add_use( curve_loop_3, FORWARD, line_13);
  add_use( curve_loop_3, FORWARD, line_14);

  auto surface_3 = new_plane();
  add_use( surface_3, FORWARD, curve_loop_3);
  write_closure_to_geo( surface_3, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_3, "L_quarter_plate.dmg");

  // Z=-h plane
  auto curve_loop_4 = new_loop();
  add_use( curve_loop_4, REVERSE, line_18);
  add_use( curve_loop_4, REVERSE, line_17);
  add_use( curve_loop_4, REVERSE, line_16);
  add_use( curve_loop_4, REVERSE, line_15);

  auto surface_4 = new_plane();
  add_use( surface_4, FORWARD, curve_loop_4);
  write_closure_to_geo( surface_4, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_4, "L_quarter_plate.dmg");


  // X=0
  auto curve_loop_5 = new_loop();
  add_use( curve_loop_5, FORWARD, line_10);
  add_use( curve_loop_5, FORWARD, line_23);
  add_use( curve_loop_5, REVERSE, line_14);
  add_use( curve_loop_5, REVERSE, line_26);

  auto surface_5 = new_plane();
  add_use( surface_5, FORWARD, curve_loop_5);
  write_closure_to_geo( surface_5, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_5, "L_quarter_plate.dmg");
  

  // X=t
  auto curve_loop_6 = new_loop();
  add_use( curve_loop_6, FORWARD, line_4);
  add_use( curve_loop_6, REVERSE, line_20);
  add_use( curve_loop_6, FORWARD, line_18);
  add_use( curve_loop_6, FORWARD, line_19);

  auto surface_6 = new_plane();
  add_use( surface_6, FORWARD, curve_loop_6);
  write_closure_to_geo( surface_6, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_6, "L_quarter_plate.dmg");

  // X=w
  auto curve_loop_7 = new_loop();
  add_use( curve_loop_7, FORWARD, line_25);
  add_use( curve_loop_7, REVERSE, line_12);
  add_use( curve_loop_7, REVERSE, line_24);
  add_use( curve_loop_7, FORWARD, line_2);
  add_use( curve_loop_7, REVERSE, line_22);
  add_use( curve_loop_7, FORWARD, line_16);
  add_use( curve_loop_7, FORWARD, line_21);
  add_use( curve_loop_7, FORWARD, line_6);

  auto surface_7 = new_plane();
  add_use( surface_7, FORWARD, curve_loop_7);
  write_closure_to_geo( surface_7, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_7, "L_quarter_plate.dmg");

  // Y=0
  auto curve_loop_8 = new_loop();
  add_use( curve_loop_8, REVERSE, line_23);
  add_use( curve_loop_8, FORWARD, line_1);
  add_use( curve_loop_8, FORWARD, line_24);
  add_use( curve_loop_8, REVERSE, line_11);

  auto surface_8 = new_plane();
  add_use( surface_8, FORWARD, curve_loop_8);
  write_closure_to_geo( surface_8, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_8, "L_quarter_plate.dmg");

  // Y=t
  auto curve_loop_9 = new_loop();
  add_use( curve_loop_9, FORWARD, line_3);
  add_use( curve_loop_9, REVERSE, line_19);
  add_use( curve_loop_9, FORWARD, line_15);
  add_use( curve_loop_9, FORWARD, line_22);

  auto surface_9 = new_plane();
  add_use( surface_9, FORWARD, curve_loop_9);
  write_closure_to_geo( surface_9, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_9, "L_quarter_plate.dmg");

  // Y=t+h
  auto curve_loop_10 = new_loop();
  add_use( curve_loop_10, FORWARD, line_5);
  add_use( curve_loop_10, REVERSE, line_21);
  add_use( curve_loop_10, FORWARD, line_17);
  add_use( curve_loop_10, FORWARD, line_20);

  auto surface_10 = new_plane();
  add_use( surface_10, FORWARD, curve_loop_10);
  write_closure_to_geo( surface_10, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_10, "L_quarter_plate.dmg");

  // Y=w
  auto curve_loop_11 = new_loop();
  add_use( curve_loop_11, FORWARD, line_7);
  add_use( curve_loop_11, FORWARD, line_9);
  add_use( curve_loop_11, FORWARD, line_26);
  add_use( curve_loop_11, REVERSE, line_13);
  add_use( curve_loop_11, REVERSE, line_25);

  auto surface_11 = new_plane();
  add_use( surface_11, FORWARD, curve_loop_11);
  write_closure_to_geo( surface_11, "L_quarter_plate.geo");
  write_closure_to_dmg( surface_11, "L_quarter_plate.dmg");


  // Create the shell, then volume
  auto shell = new_shell();
  add_use( shell, FORWARD, surface_1);
  add_use( shell, FORWARD, surface_2);
  add_use( shell, FORWARD, surface_3);
  add_use( shell, FORWARD, surface_4);
  add_use( shell, FORWARD, surface_5);
  add_use( shell, FORWARD, surface_6);
  add_use( shell, FORWARD, surface_7);
  add_use( shell, FORWARD, surface_8);
  add_use( shell, FORWARD, surface_9);
  add_use( shell, FORWARD, surface_10);
  add_use( shell, FORWARD, surface_11);

  auto model = new_volume2( shell);

  write_closure_to_geo( model, "L_quarter_plate.geo");
  write_closure_to_dmg( model, "L_quarter_plate.dmg");

  return 0;
}
