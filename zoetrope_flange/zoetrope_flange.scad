//This is an openscad part used as a flange to connect a zoetrope to a shaft


//render
lower_flange();

//===========Geometry============
clearance = 0.05; //mm - amount to oversize holes so that parts will assemble

d_shaft = .75*25.4; //0.75" shaft diameter in mm
d_mag = 0.0625*25.4; //  diamete of magnets in mm
d_pin = 0.0625*25.4; // diameter of pins used to hold shaft to flange
d_flange = 7*25.4; // outer diameter of the flange 
t_flange = 4; //thickness of the flang in mm
t_hub = 4; //thickness of the material around the hub
h_hub = 25; //height of the hub from the surface of the flange

teeth = 28; //mm - diameter of the cap of the axle pin, overall
d_pitch = 0.702412; // pitch to specify teeth
t_gear = 4; //mm - thickness of the gear
t_hub = 4.25; //mm - thickness of the hub - raised slightly to stand gear off of edge
l_pen = 4+clearance; //mm - length of the side of the square pin to cut out
t_pen = 2*t_hub; //mm - the thickness of the square pin to cut out (oversized)

fudge = 0.01; //mm - use this value to make sure surfaces aren't coincident
//===========Modules=============
module lower_flange(){
    union(){
        cylinder(r = d_flange/2, h= t_flange, $fn = 40)
        
        
        
    }
    
    
    
    
    
}