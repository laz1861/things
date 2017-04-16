//This is an openscad part used as a flange to connect a zoetrope to a shaft


//render
upper_flange();

//===========Parameters===========

num_frames = 12; //total number of frames to make cutouts for
panel_width = 1.625*25.4;  //size of each panel

//===========Geometry============
clearance = 0.05; //mm - amount to oversize holes so that parts will assemble

d_shaft = .75*25.4; //0.75" shaft diameter in mm
d_mag = 0.0625*25.4; //  diamete of magnets in mm
d_pin = 0.125*25.4; // diameter of pins used to hold shaft to flange
d_flange = 7*25.4; // outer diameter of the flange 
t_flange = 6; //thickness of the flang in mm
t_hub = 6; //thickness of the material around the hub
h_hub = 12; //height of the hub from the surface of the flange
edge_space = 5; //mm from the edge of the flange to the closest part of the frame

t_panel = 3;//mm how thick each panel is
panel_cut = 3; //mm how deep of a recess to cut for each panel


fudge = 0.01; //mm - use this value to make sure surfaces aren't coincident
//===========Modules=============
module upper_flange(){
    difference(){
        //Make the core of the flange
        union(){
            //This makes the base of the flange
            cylinder(r = d_flange/2, h= t_flange, $fn = 120);
            //This makes the hub
            translate([0,0,t_flange-fudge])
            cylinder(r = d_shaft/2+t_hub, h = h_hub, $fn = 120);
        }
        //Then subtract things from it
        
        //Subtract the hole for the shaft
        translate([0,0,-fudge])
        cylinder(r = d_shaft/2+clearance,h = t_flange+h_hub+2*fudge,$fn = 120);
        
        //cut a pin to register the flange to the shaft
               
        translate([0,0,t_flange+h_hub/2])
        rotate([90,0,0]) 
        cylinder(r=d_pin/2,h=5*d_shaft+2*t_hub+2*fudge,$fn=20,center=true);
        //subtract the holes for the frames
        for (i=[0:1]){
            cord_calc(i);
            
            
        }
        
 
            
    }
    
  
    
    
    
    
}
module cord_calc(i){
    theta = 2*3.1415/num_frames;
    r_panel = (d_flange/2-edge_space)*cos(theta/2)-t_panel;
    for ( i = [0:num_frames-1] ) {
        rotate([0,0,i*theta*180/3.1415])
        translate([r_panel,-panel_width/2,-fudge])
        cube([t_panel+clearance,panel_width+clearance,panel_cut]);
    }
        
    
}