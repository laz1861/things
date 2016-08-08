//This is an openscad part used in a modified version of perseverance.
//This version is optimized to use a lasercut base using 3mm thick material

//header
include <MCAD/involute_gears.scad>

//render
idler_gear_small();

//===========Geometry============
clearance = 0.05; //mm - amount to oversize holes so that parts will assemble

teeth = 14; //mm - diameter of the cap of the axle pin, overall
d_pitch = 0.702412; // pitch to specify teeth
t_gear = 4; //mm - thickness of the gear
t_hub = 4.25; //mm - thickness of the hub - raised slightly to stand gear off of edge
l_pen = 4+clearance; //mm - length of the side of the square pin to cut out
t_pen = 2*t_hub; //mm - the thickness of the square pin to cut out (oversized)

fudge = 0.01; //mm - use this value to make sure surfaces aren't coincident
//===========Modules=============
//Imported module gear:
//Below is a list of arguments and brief discriptions.
//Default values listed in ().
//	number_of_teeth (15) - can specify the number of teeth on the gear
//	circular_pitch (false), diametral_pitch(false) - specify one or the other numerically
//	pressure_angle (28) - can specify a different pressure angle
//	clearance (0.2) - clearance for gear design
//	gear_thickness (5) - specify thickness of gear body
//	rim_thickness (8) - specify thickness of rim and teeth,
//	rim_width(5) - ??
//	hub_thickness(10) - specify thickness of the central hub,
//	hub_diameter (15) - specify diameter of central hub
//	bore_diameter (5) - specify diameter of through-hole
//	circles (0) - can subtract material by removing specified number of holes from body
//	backlash (0) - can add specified amout of backlash to gears
//	twist (0),
//	involute_facets (0),
//	flat (false)
module idler_gear_small(){
    difference(){
        gear (number_of_teeth=teeth,
              diametral_pitch=d_pitch,
              gear_thickness = t_gear,
              rim_thickness = t_gear,
              hub_thickness = t_hub,
              bore_diameter=0,
              clearance = 0.2);
        //specified with zero bore diameter so we can cut a square notch
        
        cube([l_pen,l_pen,3*t_pen],center=true);
    }
}