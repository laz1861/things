//Create a mount that will clamp to my printer's aluminum extrusion
//I'll import an existing clamp, and add a flange to attach to

//Geometry
//fudge
fudge=0.01;//mm use this to prevent coincident surfaces

//clamp
w = 27;//mm
h = 10;//mm
l = 22;//mm

//flange
wf = 25;//mm
hf = 10;//mm
lf = 10;//mm
d_h = 3.5; //mm - distance from edge to center of whole

//nut dimension
r_n = 6.05/2; //mm half of the bolt radius
h_n = 2.4; //mm bolt thickness


//bolt hole
rb=3.2/2;//mm bolt hole radius

//support dimensions
ws = l-lf; //mm not as tall as the whole flange
ls = ws; //mm  distance between the end of flange and end of clamp
hs = hf;//same height of flange
rs = ws;//radius set tothe size of the cube

clamp();

//=====Modules=====

module clamp(){
    union() {
        import("clamp.stl");
        translate([-wf+50*fudge,0,0])
        color([1,0,0])
        //cube([wf,lf,hf]);
        flange();
        support();
        
        //add support
             
    }
}
module support() {
    difference() {
        //start with a cube
        color([0,0,1])
        translate([-ws+50*fudge,lf-fudge,0])
        cube([ws,ls,hs]);
        translate([-ws+50*fudge,lf-fudge+ws,hf/2])
        cylinder(r = rs, h = hf +2*fudge, center = true);
    }
}
module flange() {
    difference() {
        //start with the added material
        cube([wf,lf,hf]);
        //subtract through hole
        translate([d_h,lf/2,hf/2])
        rotate([0,0,0])
        cylinder(r=rb, h = hf+2*fudge, center = true, $fn=20);
        //subtract a captive nut
        translate([d_h,lf/2,0])
        cylinder(r=r_n, h =h_n+2*fudge, center = true, $fn = 6);
        //subtract a captive nut from the top
        translate([d_h,lf/2,hf])
        cylinder(r=r_n, h=h_n+2*fudge, center = true, $fn = 6);
        
        
        
    }
    
    
    
}