//define geometry

board_width=25.5; //mm
board_height=23; //mm
board_thick=4.75; //mm
cable_width=18; //mm
cable_thick=1; //mm

side_cover=7.5; 

camera_hole_width=10;
camera_hole_height=5.5;

screw_hole_r=2.65;
wall_thk=2.5;
//create a fudge factor so no CSG operations have coincident faces
fudge=0.001;

mount_offset=2*wall_thk+board_width;
mount_thickness=8;

union(){

//camera holder
difference(){
    //create a box that is as thick as the board with wall thickness
    cube([board_thick+2*wall_thk, board_width+2*wall_thk, board_height+2*wall_thk]);
    //Subtract out area for the board to rest
    translate([wall_thk, wall_thk, wall_thk]) cube([board_thick, board_width, board_height+wall_thk+fudge]);
    //Subtract slot for camea lens
    translate([board_thick+wall_thk-fudge, wall_thk+side_cover, wall_thk+camera_hole_height]) cube([wall_thk+2*fudge, camera_hole_width, board_height+wall_thk-camera_hole_height+fudge]);
    //hole for cable in the bottom
    translate([wall_thk+2,wall_thk+(board_width-cable_width)/2,-fudge]) cube([cable_thick, cable_width+2*fudge, wall_thk+2*fudge]);
}

//mount
difference(){
    //body of mount is a cylinder
    union(){
        translate([0, mount_offset, board_height/2+wall_thk]) rotate([90,0,0]) cylinder(r=board_height/2+wall_thk, h=mount_thickness, $fn=100);
	//translate([-board_height/2-wall_thk,mount_offset-mount_thickness,0]) cube([board_height/2+wall_thk,mount_thickness-d,board_height/2+wall_thk]);
	}
    //remove circle sticking out front
    translate([fudge,0,0]) cube([50, board_width+2*wall_thk+fudge, board_height+2*wall_thk+fudge]);
    //add a hole for the M5 nut
    translate([-screw_hole_r-5,mount_offset+fudge, board_height/2+wall_thk]) rotate([90,0,0]) cylinder(r=screw_hole_r, h=mount_thickness+2*fudge, $fn=100);
}

}