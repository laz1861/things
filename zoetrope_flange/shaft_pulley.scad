//This is an openscad part used as a pulley to connect to the shaft

//render
//lower_flange();
shaft_pulley();

//===========Parameters===========

num_frames = 12; //total number of frames to make cutouts for
panel_width = 1.625*25.4;  //size of each panel

//===========Geometry============
clearance = 0.1; //mm - amount to oversize holes so that parts will assemble

d_shaft = .75*25.4; //0.75" shaft diameter in mm
d_mag = 8.1; //  diamete of magnets in mm
h_mag = 2.1; //mm the heigh of the magnets
d_pin = 0.125*25.4; // diameter of pins used to hold shaft to flange
d_flange = 7*25.4; // outer diameter of the flange 
t_flange = 6; //thickness of the flang in mm
t_hub = 6; //thickness of the material around the hub
h_hub = 25; //height of the hub from the surface of the flange
edge_space = 5; //mm from the edge of the flange to the closest part of the frame
d_base = d_shaft+2*t_hub+6;
t_base = 3; //mm thickness of base web
t_panel = 3;//mm how thick each panel is
panel_cut = 3; //mm how deep of a recess to cut for each panel

h_lip = 1.45; //mm height of the lip that keeps the belt in place
h_body = 3.7; //mm height of the body area the belt rides on

t_lip = 0.75; //mm diamater of lip above body


fudge = 0.01; //mm - use this value to make sure surfaces aren't coincident
//===========Modules=============
module lower_flange(){
    difference(){
        //Make the core of the flange
        union(){
            //This makes the base of the flange
            //cylinder(r = d_flange/2, h= t_flange, $fn = 360);
            //This makes the hub
            //translate([0,0,t_flange-fudge])
            cylinder(r=d_base,h=t_base,$fn = 120);
            cylinder(r = d_shaft/2+t_hub, h = h_hub+t_flange, $fn = 120);
            //add in a block to mate the disks
            translate([-49/2,-10.1/2,0])
            cube([49,10.1,6+t_base]);
        }
        //Then subtract things from it
        
        //Subtract the hole for the shaft
        translate([0,0,-fudge])
        cylinder(r = d_shaft/2+clearance,h = t_flange+h_hub+2*fudge,$fn = 120);
        
        //cut a pin to register the flange to the shaft
               
        translate([0,0,t_flange+h_hub*.5])
        rotate([90,0,0]) 
        cylinder(r=d_pin/2,h=5*d_shaft+2*t_hub+2*fudge,$fn=20,center=true);
        //subtract the holes for the frames
        for (i=[0:num_frames-1]){
            cord_calc(i);
            mag_holes(i);
            
            
        }
        
 
    }
    
  
    
    
    
    
}
module cord_calc(i){
    theta = 2*3.1415/num_frames;
    r_panel = (d_flange/2-edge_space)*cos(theta/2)-t_panel;
 
    rotate([0,0,i*theta*180/3.1415])
    translate([r_panel,-panel_width/2,t_flange+fudge-panel_cut])
    cube([t_panel+clearance,panel_width+clearance,panel_cut]);
  
}

module mag_holes(i){
    theta = 2*3.1415/num_frames;
    
    rotate([0,0,i*theta*180/3.1415])
    translate([d_flange/2-d_mag/2-edge_space,0,-fudge])
    cylinder(r=d_mag/2+clearance, h=h_mag, $fn = 20);
    
}
module shaft_pulley(){
    difference(){
        union(){
        //create the surface of the pulley that the belt rides on
        translate([0,0,h_lip])
        cylinder(r = d_shaft/2+t_hub, h = h_body, $fn = 120);
        //lower lip
        cylinder(r = d_shaft/2+t_hub+t_lip, h = h_lip+fudge, $fn = 120);
        //upper lip
        translate([0,0,h_lip+h_body-fudge])
        cylinder(r = d_shaft/2+t_hub+t_lip, h = h_lip+fudge, $fn = 120);        
    }
        //subtract out center hole
        translate([0,0,-fudge])
        cylinder(r = d_shaft/2+clearance, h = h_body+2*h_lip+2*fudge,$fn=120);
    
    }
}