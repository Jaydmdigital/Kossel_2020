// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1; //6.1 for 1515
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;


// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 20;
extrusion_channel_w = 5; //use 3 for 1515
extrusion_channel_d = 3; //use 3 for 1515
extrusion_fin_d = 1;

vertex_offset=27;
vertex_radius = 40.5; //set to 36 for 1515


// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;
