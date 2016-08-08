//This is an openscad part used in a modified version of perseverance.
//This version is optimized to use a lasercut base using 3mm thick material

//render
gear_axle_idler();

//===========Geometry============
d_head = 43; //mm - diameter of the cap of the axle pin, overall
t_head = 4.25; //mm - thickness of the cap
d_collar = 8; //mm - diameter of the bearing surface of the pin
t_collar = 3.5; //mm - thickness of the bearing surface
l_pen = 4; //mm - length of the side of the square pin
t_pen = 6; //mm - the thickness of the square pin

clearance = 0.15; //mm - amount to oversize holes so that parts will assemble
fudge = 0.01; //mm - use this value to make sure surfaces aren't coincident
//===========Modules=============
module gear_axle_idler(){
    //This piece is similar to the other gear idlers.  The difference is the longer pin and the cap is actually the mount for the knob.
    difference(){
        union(){
            //create cap
            cylinder(r = (d_head-t_head)/2, h= t_head, center = true, $fn = 100);
            //add a rotate_extrude to make a rounded edge
            rotate_extrude(convexity = 2, $fn=100)
            translate([(d_head-t_head)/2-fudge, 0, 0])
            circle(r = t_head/2);
            //add collar 
            translate([0,0,(t_head+t_collar)/2-fudge])
            cylinder(r = d_collar/2, h= t_collar, center = true, $fn=40);
            //add pin
            translate([0,0,(t_head+t_pen)/2+t_collar-fudge])
            cube([l_pen,l_pen,t_pen], center = true);
        }
        translate([d_head/2-l_pen-clearance,0,0])
        cube([l_pen+clearance,l_pen+clearance,2*t_head], center = true);
        }
}