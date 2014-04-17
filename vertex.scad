include <configuration.scad>;

$fn = 80;
roundness = 6;

body1_cylinder_offset = 22;  //22
body2_cylinder_offset = -30; //-37

module extrusion_cutout(h, extra, cut_w=2, cut_d=2, corner_r=0.5) {
 difference() {
  union(){
    cube([extrusion+extra, extrusion+extra, h], center=true);
    translate([(extrusion-corner_r)/2,(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    translate([(extrusion-corner_r)/2,-(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    translate([-(extrusion-corner_r)/2,(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    translate([-(extrusion-corner_r)/2,-(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
  }
  for (a = [0:90:359]) rotate([0, 0, a]) {
   translate([(extrusion-cut_d)/2+0.5, 0, 0]) cube([cut_d, cut_w, h+1], center=true);
  }
  
 }
}

module screw_socket() {
 cylinder(r=m3_wide_radius, h=20, center=true);
 translate([0, 0, 3.8]) cylinder(r=3.5, h=8);
}

module screw_socket_cone() {
 union() {
  screw_socket();
  scale([1, 1, -1]) rotate(45)cylinder(r1=11/2*sqrt(2), r2=extrusion/2, h=5.5, $fn=4);
 }
}

module fin(fin_l=50, fin_w=2, fin_d=2){
  //cube([fin_l,fin_w,fin_d],center=true);
  rotate([0,90,0])cylinder(h=fin_l, r=fin_d/2, center=true);
  //echo("In fin");
}

module vertex(height, idler_offset, idler_space, fin_w=5, fin_d, fins=0, fn=180) {
 translate([0,2.5,0])union() {
 // Pads to improve print bed adhesion for slim ends.
  translate([-37.5, 52.2, -height/2]) cylinder(r=8, h=0.4);
  translate([37.5, 52.2, -height/2]) cylinder(r=8, h=0.4);

  difference() {
   union() {
    //fins
    if(fins > 0){
      translate([29.5,35,(height-extrusion)/2]) rotate([0,0,60])  
        difference(){ 
          fin(54,fin_d,fin_w+1);
          translate([-22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
          translate([22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
      }
      translate([29.5,35,-(height-extrusion)/2]) rotate([0,0,60]) 
      difference(){ 
          fin(54,fin_d,fin_w+1);
          translate([-22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
          translate([22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
      }
      translate([-29.5,35,(height-extrusion)/2]) rotate([0,0,-60]) 
      difference(){ 
          fin(54,fin_d,fin_w+1);
          translate([-22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
          translate([22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
      }
      
      translate([-29.5,35,-(height-extrusion)/2]) rotate([0,0,-60]) 
      difference(){ 
          fin(54,fin_d,fin_w+1);
          translate([-22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
          translate([22,-1.6,0])rotate([90,45,0]) cylinder(r=11/2*sqrt(2), h=5.5, $fn=4);
      }
    }
    intersection() {
     translate([0, body1_cylinder_offset, 0]) cylinder(r=vertex_radius, h=height, center=true, $fn=fn*2);
     translate([0, body2_cylinder_offset, 0]) rotate([0, 0, 30]) cylinder(r=50, h=height+1, center=true, $fn=6);
    }
    translate([0, 38, 0]) intersection() {
     rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
     translate([0, 10, 0]) cube([100, 100, 2*height], center=true);
     translate([0, -10, 0]) rotate([0, 0, 30]) cylinder(r=55, h=height+1, center=true, $fn=6);
    }
   }
   difference() {   
    translate([0, 58, 0]) minkowski() {
     intersection() {
      rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
      translate([0, -31, 0])  cube([100, 15, 2*height], center=true);
     }
     cylinder(r=roundness, h=1, center=true);
    }
  
    // Idler support cones.
    translate([0, 26+idler_offset-30, 0]) rotate([-90, 0, 0]) cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
    translate([0, 26+idler_offset+30, 0]) rotate([90, 0, 0])  cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
   }
   
  translate([0, 58, 0]) minkowski() {
    intersection() {
     rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
     translate([0, 7, 0]) cube([100, 30, 2*height], center=true);
    }
    cylinder(r=roundness, h=1, center=true);
   }
   
   translate([0,-2.5,0])extrusion_cutout(height+10, 0.15, fin_w, fin_d,corner_r=1);

   for (z = [-height/2 + extrusion/2 , height/2 - extrusion/2] ) {
    translate([0, -extrusion/2-extra_radius+extrusion_fin_d-2.5, z]) rotate([90, 0, 0]) screw_socket_cone();
    for (a = [-1, 1]) {
     rotate([0, 0, 30*a]) translate([-(vertex_radius-body1_cylinder_offset)*a, 111, z]) {
      // % rotate([90, 0, 0]) extrusion_cutout(200, 0);
      // Screw sockets.
      for (y = [-88, -44]) {
       translate([a*(extrusion/2-0.6), y, 0]) rotate([0, a*90, 0]) screw_socket();
      }
     
      // Nut tunnels.
	    for (z = [-1, 1]) {
	     scale([1, 1, z]) 
        translate([0, -99, 3]) 
         minkowski() {
	        rotate([0, 0, -a*30]) cylinder(r=5, h=16); //cylinder(r=m3_nut_radius, h=16);
		      cube([0.1, 8, 0.1], center=true);
	       }
      }
     }
    }
   }
   // ease the inside coners
   rotate(-30)translate([vertex_x_offset+2,-2.5+vertex_y_offset/2+1,0])cylinder(h=height+1, r=1, center=true);
   rotate(30)translate([-vertex_x_offset-2,-2.5+vertex_y_offset/2+1,0])cylinder(h=height+1, r=1, center=true);
  }
 }
}



translate([0, 0, extrusion*2.5/2]) 
vertex(extrusion*2.5, idler_offset=0, idler_space=10, fin_w=5, fin_d=4, fins=1, fn=20 );

//translate([0, 0, 7.5]) vertex_cover(3);

//%rotate(-30)cube([45,vertex_y_offset/2,25]);
//%rotate(-30)cube([vertex_x_offset,45,35]);
/*
//%rotate(-30)cube([45,vertex_y_offset/2,25]);
color("gray")rotate(-30)translate([(extrusion-thickness)/2,vertex_y_offset/2,0])
 difference(){ 
   cube([extrusion,240,extrusion]);
  translate([(extrusion-extrusion_channel_w)/2,-1,extrusion-6]) cube([extrusion_channel_w,241,extrusion]);
 }
 */
/*
color("gray")
rotate(-30)translate([(extrusion-thickness)/2,vertex_y_offset/2,0])
translate([10,0,10+30])rotate([-90,0,0])
 difference(){
    import("./assembly/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

#translate([sin(30)*(vertex_y_offset+240),cos(30)*(vertex_y_offset+240),0])rotate(120)
 translate([0, 0, extrusion*2.5/2]) vertex(extrusion*2.5, idler_offset=0, idler_space=10, fin_w=5, fin_d=4, fn=20 );
translate([sin(30)*(vertex_y_offset/2+240),cos(30)*(vertex_y_offset/2+240),-1])%rotate(-30)cube([45,vertex_y_offset/2,25]);
*/


