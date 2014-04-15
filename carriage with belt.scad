include <configuration.scad>;
include <MCAD/fillets.scad>;

$fn=120;

// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 6;

horn_thickness = 13;
horn_x = 8;

belt_width = 5;
belt_x = 5.6;
belt_z = 7;
corner_radius = 3.5;

block_w = 27;
block_l = 40; 


module carriage() {
  // Timing belt (up and down).
  //translate([-belt_x, 0, belt_z + belt_width/2]) % cube([1.7, 100, belt_width], center=true);
  //translate([belt_x+1.23, 0, belt_z + belt_width/2]) %   cube([2.3, 100, belt_width], center=true);
  
  difference() {
    union() {
      // Main body.
      translate([0, 0, thickness/2]) cube([block_w, block_l, thickness], center=true);
      // Ball joint mount horns.
      translate([0,0,0])
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 0, horn_thickness/2]) cube([separation, 18, horn_thickness], center=true);
          translate([horn_x, 0, horn_thickness/2]) rotate([0, 90, 0])    cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
        }
      }

      // Avoid touching diagonal push rods (carbon tube).
      difference() {
       translate([(block_w-5.5)/2, 0, horn_thickness/2+1]) cube([5.5, block_l, horn_thickness-2], center=true);

        translate([23, -14, 12]) rotate([30, 35, 30]) cube([block_l, block_l, 20], center=true);
//        translate([10, -10, 0])  cylinder(r=m3_wide_radius+1.5, h=100, center=true);
     }
      // Belt clamps
      for (y = [[5, -1], [-5, 1]]) {
        translate([2.20, y[0], horn_thickness/2+1])
          hull() {
            translate([ corner_radius-1,  -y[1] * corner_radius + y[1], 0]) cube([2, 2, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius,  center=true);
          }
      }

     // top cube
     translate([3.20, (5 + corner_radius + 10/2 + 1.5), horn_thickness/2+1])  cube([5, 10, horn_thickness-2], center=true);
     // bottom cube
     #translate([3.20, -(5 + corner_radius + 10/2 + 1.5), horn_thickness/2+1]) cube([5, 10, horn_thickness-2], center=true);
    }
    // Screws for linear slider.
    for (x = [-10, 10]) for (y = [-15, 15]) translate([x, y, thickness]) cylinder(r=m3_radius, h=30, center=true);
    translate([10, -15, 8/2+thickness+4 ]) cylinder(r=m3_nut_radius, h=8, center=true);
    translate([10, 15, 8/2+thickness+4 ]) cylinder(r=m3_nut_radius, h=8, center=true);

    // Screws for ball joints.
    translate([0, 0, horn_thickness/2]) rotate([0, 90, 0]) 
      cylinder(r=m3_radius, h=60, center=true);
    // Lock nuts for ball joints.
    for (x = [-1, 1]) {
      scale([x, 1, 1]) intersection() {
        translate([horn_x, 0, horn_thickness/2]) rotate([90, 0, -90])
          cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8, center=true, $fn=6);
      }
    }
  }
}

difference() {
  carriage();
  cube_negative_fillet([block_w, block_l,60], radius=-1, vertical=[2,2,2,2], top=[0,0,0,0], bottom=[0,0,0,0], 
        top_angle=[90,90,90,90], top_flip=[0,0,0,0], $fn=20);
}
//translate([5,8,2])rotate([-10,0,-30])translate([block_w/2+horn_thickness/2,-214/2,horn_thickness/2])rotate([90,0,0])color([0.1,0.1,0.1,0.4])cylinder(h=214,r=3,center=true);