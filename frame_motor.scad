include <configuration.scad>;

use <vertex.scad>;
use <nema17.scad>;

$fn = 280;

fin_w=5;
fin_d=4;
fins=1;

motor_frame_height = 2.5*extrusion;

module frame_motor() {
  difference() {
    // No idler cones.
   vertex(motor_frame_height, idler_offset=0, idler_space=100, fin_w=fin_w, fin_d=fin_d, fins=fins, fn=200);

    // KOSSEL logotype.
    translate([23, -11, 0]) rotate([90, -90, 30])
      scale([0.11, 0.11, 1]) import("logotype.stl");
    // Motor cable paths.
    for (mirror = [-1, 1]) scale([mirror, 1, 1]) {
      translate([-35, 45, 0]) rotate([0, 0, -30])
         cube([4, 15, 15], center=true);
      translate([-6-3, 0, 0]) cylinder(r=3.5, h=40);
      translate([-11, 0, 0])  cube([15, 5.2, 15], center=true);
    }
    translate([0, motor_offset, 0]) {
      // Motor shaft/pulley cutout.
      rotate([90, 0, 0]) cylinder(r=12, h=20, center=true);
      // NEMA 17 stepper motor mounting screws.
      for (x = [-1, 1]) for (z = [-1, 1]) {
        scale([x, 1, z]) translate([15.5, -5, (motor_frame_height)/3]) {
          rotate([90, 0, 0]) cylinder(r=1.65, h=20, center=true);
          // Easier ball driver access.
          rotate([70, -25, 0])  cylinder(r=2.5, h=motor_frame_height);
        }
      }
    }
    translate([0, motor_offset, 0]) rotate([90, 0, 0]) % nema17();
  }
}


translate([0, 0, extrusion*2.5/2]) frame_motor();
//translate([0, 0, extrusion*2.5/2]) import("../kossel-master/BOM_tight/frame_motor.stl");
//add fins to the sides

//translate([(extrusion+thickness)/2+fin_d,vertex_offset/2,fin_w/2]) rotate([0,0,-30])  cube([1,50,fin_w]);


color("gray")rotate(-30)translate([vertex_x_offset+0.25,vertex_y_offset/2,0])
translate([10,0,10+30])rotate([-90,0,0])
 difference(){
    import("./assembly/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

color("gray")rotate(-30)translate([vertex_x_offset+0.25,vertex_y_offset/2,0])
translate([10,0,10])rotate([-90,0,0])
 difference(){
    import("./assembly/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

color("gray")rotate(30)translate([-vertex_x_offset-0.25,vertex_y_offset/2,0])
translate([-10,0,10+30])rotate([-90,0,0])
 difference(){
    import("./assembly/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

color("gray")rotate(30)translate([-vertex_x_offset-0.25,vertex_y_offset/2,0])
translate([-10,0,10])rotate([-90,0,0])
 difference(){
    import("./assembly/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

/*
%rotate(-30)cube([45,vertex_offset/2,25]);
color("gray")rotate(-30)translate([(extrusion-thickness)/2,vertex_offset/2,0])
 difference(){ 
   cube([extrusion,240,extrusion]);
  translate([(extrusion-extrusion_channel_w)/2,-1,extrusion-6]) cube([extrusion_channel_w,241,extrusion]);
 }
*/
/*color("gray")rotate(-30)translate([(extrusion-thickness)/2,vertex_offset/2,extrusion*1.5])
 difference(){ 
   cube([extrusion,240,extrusion]);
  translate([(extrusion-extrusion_channel_w)/2,-1,extrusion-6]) cube([extrusion_channel_w,241,extrusion]);
 }


color("gray")rotate(30) translate([-extrusion*1.5+thickness/2,vertex_offset/2,0])
translate([0,0,0])
 difference(){ 
   cube([extrusion,240,extrusion]);
  translate([(extrusion-extrusion_channel_w)/2,-1,extrusion-6]) cube([extrusion_channel_w,241,extrusion]);
 }

#translate([sin(30)*(vertex_offset+240),cos(30)*(vertex_offset+240),0])rotate(120)
 translate([0, 0, extrusion*2.5/2]) vertex(extrusion*2.5, idler_offset=0, idler_space=10, fin_w=5.5);
//translate([sin(30)*(vertex_offset/2+240),cos(30)*(vertex_offset/2+240),-1])%rotate(-30)cube([45,vertex_offset/2,25]);
*/