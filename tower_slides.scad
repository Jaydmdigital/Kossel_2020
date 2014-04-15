include <configuration.scad>;
include <MCAD/fillets.scad>;


m3_nut_od = 6.2;
m3_nut_radius = m3_nut_od/2;
m3_major = 2.8;
m3_radius = m3_major/2 ;
m3_wide_radius = m3_major/2;

num40_drill = 2.4/2;    // for tapping

slide_h = 40;
slide_l = extrusion+13+5;//29; //15+13+5
slide_w = 27;

psaver_w = 9;
psaver_l = 13;
psaver_o = 1;

front_h = 13; // want to match the height of a linear rail MGN12C

extrusion_w = extrusion + 0.0;
extrusion_slot_w = 5;
extrusion_offset = front_h -((slide_l-extrusion_w)/2);
echo (extrusion_offset);
echo (extrusion_offset+slide_l/2);

screw_offset = 15;
fin_w=5;
fin_d=5;


$fn=60;

//translate([-31,-24,0])import("Tower slides for screws.stl");

//color([0.1,0.1,0.1,0.8])translate([0,-extrusion_offset,-50])import("../assembly/1515_240mm.stl");
//translate([0,16.5,16])rotate([90,0,180])import("../carriage.stl");

//translate([16/2+7.5-4.1,-4,0]) rotate([0,90,0]) #cylinder(h=16,r=3/2,center=true);

//main block
translate([0,extrusion_offset,slide_h/2])
 difference(){

   difference(){
     cube([slide_w, slide_l,slide_h],center=true);
     cube_negative_fillet([slide_w, slide_l,slide_h], radius=-1, vertical=[0,0,2,2], top=[0,2,2,2], bottom=[0,2,2,2], 
        top_angle=[90,90,90,90], top_flip=[0,0,0,0], $fn=20);
   }
   //cube([slide_w, slide_l,slide_h],center=true);
     
   translate([0,-extrusion_offset,0]) 
    union(){
     extrusion_cutout(slide_h+10, 0.1, fin_w, fin_d,corner_r=1);
    
     translate([slide_w/2,0,screw_offset]) rotate([0,90,0]) cylinder(h=slide_w, r=num40_drill, center=true);
     translate([slide_w/2,0,-screw_offset]) rotate([0,90,0]) cylinder(h=slide_w, r=num40_drill, center=true);
     translate([-slide_w/2,0,screw_offset]) rotate([0,90,0]) cylinder(h=slide_w, r=num40_drill, center=true);
     translate([-slide_w/2,0,-screw_offset]) rotate([0,90,0]) cylinder(h=slide_w, r=num40_drill, center=true);
     translate([0,-slide_l/2,screw_offset]) rotate([90,0,0]) cylinder(h=slide_w, r=num40_drill, center=true);
     translate([0,-slide_l/2,-screw_offset]) rotate([90,0,0]) cylinder(h=slide_w, r=num40_drill, center=true);
    }

   // Screws 
   #translate([0,3,0]) rotate([-90,0,0])
    for (a = [0: 1]) {
     rotate([0,0,a*180])
		union(){
          translate([10, 15, (slide_h-16)/2])  cylinder(r=m3_wide_radius, h=16, center=true);
          translate([10, -15, (slide_h-16)/2])  cylinder(r=m3_wide_radius, h=16, center=true);
        }
    }

  // save some plastic
  translate([0,extrusion_w/2+3,0]) 
  //cube([12,8,slide_h+2],center=true);
  difference(){
     cube([psaver_l,psaver_w,slide_h+2],center=true);
     cube_negative_fillet([psaver_l,psaver_w,slide_h+2], radius=-1, vertical=[2,2,2,2], top=[0,0,0,0], bottom=[0,0,0,0], 
        top_angle=[90,90,90,90], top_flip=[0,0,0,0], $fn=20);
   }
  //cylinder(h=slide_h+2, r=4, center=true);
}

//cube([13+7.5,13+7.5,13+7.5]);


module extrusion_cutout(h, extra, cut_w=2, cut_d=2, corner_r=0.5) {
 difference() {
  union(){
    cube([extrusion+extra, extrusion+extra, h], center=true);
    translate([(extrusion-corner_r)/2,(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    translate([(extrusion-corner_r)/2,-(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    translate([-(extrusion-corner_r)/2,(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    translate([-(extrusion-corner_r)/2,-(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
  }
  // Leave one slot open for wires
  for (a = [0:-90:-180]) rotate([0, 0, a]) { 
   translate([(extrusion-cut_d)/2+0.5, 0, 0]) cube([cut_d, cut_w, h+1], center=true);
  }
  
 }
}