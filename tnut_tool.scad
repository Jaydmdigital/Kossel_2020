
$fn=80;
// A file to generate a tool to hold t-nuts for 2020

%translate([0,0,1])rotate([0,90,0])tnut();
translate([-70/2+4,0,0]) tnut_tool();

//%cube([10,10,10],center=true);

module tnut(){
  difference(){
   union() {
    cylinder(h=10,r=5*1.15,center=true,$fn=3);
    translate([-1.35,0,0])cube([4.1,5.77,10],center=true);
   }
   translate([4.7,0,0])cube([8,8,11],center=true);
   rotate([0,90,0]) cylinder(h=8,r=1.5,center=true);
  }
}

module tnut_tool(){
  minkowski() {
    cube([70,2,1],center=true);
    cylinder(h=1, r=4);
  }
  translate([70/2-4,0,1.5]) cylinder(h=3.5,r=2.4/2,center=true);
  translate([70/2-4-7.7,0,1.5]) 
  minkowski() {
    cube([1,3,1.5],center=true);
    cylinder(h=1, r=2);
  }
  
}
