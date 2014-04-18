include <configuration.scad>;

$fn=200;

sticky_width = 25.4;
sticky_length = 25.4;
sticky_offset = 8;  // Distance from screw center to glass edge.

// Make the round edge line up with the outside of OpenBeam.
screw_offset = sticky_width/2 - 7.5;
cube_length = sticky_length + sticky_offset - screw_offset;

module glass_tab() {
  difference() {
    translate([0, screw_offset, 0]) union() {
      cylinder(r=sticky_width/2, h=thickness, center=true);
      translate([0, cube_length/2, 0])
        cube([sticky_width, cube_length, thickness], center=true);
    }
    cylinder(r=m3_wide_radius, h=20, center=true);
  }
  // Scotch restickable tab for mounting.
  translate([0, sticky_length/2+sticky_offset, thickness/2]) %
    cube([sticky_width, sticky_length, 0.7], center=true);
  // Horizontal OpenBeam.
  //translate([0, 0, (extrusion+thickness)/-2]) %cube([100, extrusion, extrusion], center=true);
  
}

module glass_tab2(tab_thickness=3, tab_d=extrusion*1.5){
  // lets do a body that is a rounded triagle
  difference(){ 
    union(){
     translate([0,(extrusion+tab_d)/2-extrusion,0])rotate(-30){
      minkowski(){
       cylinder(h=tab_thickness/2, r=tab_d/2, center=true, $fn=3);
       cylinder(h=tab_thickness/2, r=extrusion/2, center=true);    
      }
     }
     difference(){
      translate([0,0,-5/2])rotate([0,90,0])cylinder(h=tab_d+extrusion/2, r=6/2 ,center=true);//cube([tab_d+extrusion/2,5,5],center=true);
      translate([extrusion,0,-3]) {
        rotate([0,180,45]) cylinder(r1=11/2*sqrt(2), r2=extrusion/2, h=5.5, $fn=4);
      }
      translate([-extrusion,0,-3]){
        rotate([0,180,45])cylinder(r1=11/2*sqrt(2), r2=extrusion/2, h=5.5, $fn=4);
      }
     }
    }  
    translate([extrusion,0,-3]) cylinder(h=extrusion*2, r=m3_radius, center=true);
    translate([-extrusion,0,-3]) cylinder(h=extrusion*2, r=m3_radius, center=true);
  }
}


//translate([0, 0, thickness/2]) glass_tab();
rotate([0,180,0])
translate([0, 0, 3/2])glass_tab2(thickness,extrusion*2.5);

/*%translate([240/2,0,-extrusion/2])rotate([-90,0,90])
 difference(){
    import("./assembly/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }
*/
//translate([0, 170/2+6.8, thickness]) %cylinder(h=3, r=170/2);
difference(){
rotate([0,180,-90]) translate([-14.65, -12.76, -11])glass_clip();
//translate([0,0,12]) cylinder(h=10, r=3, center=true);
}

module glass_clip(){
// works in conjunction with tab
//import("Spiral+Bed+Clamp.STL", convexity=10);
//cylinder(r=sticky_width/2, h=thickness, center=true);

}