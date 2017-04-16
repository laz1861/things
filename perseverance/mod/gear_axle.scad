//This is an openscad part used in a modified version of perseverance.
//This version is optimized to use a lasercut base using 3mm thick material

//render
gear_axle();

//===========Geometry============
clearance = 0.05;//mm - clearance to undersize the parts

d_head = 12-clearance; //mm - diameter of the cap of the axle pin
t_head = 2.2; //mm - thickness of the cap
d_collar = 8-clearance; //mm - diameter of the bearing surface of the pin
t_collar = 3.5; //mm - thickness of the bearing surface
l_pen = 4-clearance; //mm - length of the side of the square pin
t_pen = 4.25; //mm - the thickness of the square pin

fudge = 0.001; //mm - use this value to make sure surfaces aren't coincident
//===========Modules=============
module gear_axle(){
    //build the axle pin with the head on the bottom
    union(){
        //add cap
        cylinder(r = d_head/2, h= t_head, center = true, $fn = 40);
        //add collar
        translate([0,0,(t_head+t_collar)/2-fudge])
        cylinder(r = d_collar/2, h= t_collar, center = true, $fn=40);
        //add pin
        translate([0,0,(t_head+t_pen)/2+t_collar-fudge])
        cube([l_pen,l_pen,t_pen], center = true);
    }
    
}