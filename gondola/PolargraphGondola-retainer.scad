// Basic gondola stabilizer and platform for a polargraph
//
// Created by Walter Anderson on June 3, 2014
// Version 1.0.3 modified on June 19, 2004
$fs=0.01;

translate([0,0,49]) rotate(a=[0,180,0]) difference() {
	union() {
		translate([0,0,42])
			cylinder(h=7, r=18);
		translate([0,0,41])
			cylinder(h=1, r=12);
	}
	// This creates a central 13mm hole that just holds the pen, no brass tube
	cylinder(h=75, r=8.6);
	// This creates two holes that can be used in the clamp piece (needed only for 
	// gondola that doesn't use the central brass tube
	rotate(a=[0,0,60])
		translate([0,-10,45.5])
			rotate(a=[90,0,0])
				cylinder(h=20, r=1.25, center = true);
	rotate(a=[0,0,-60])
		translate([0,-10,45.5])
			rotate(a=[90,0,0])
				cylinder(h=20, r=1.25, center = true);
	// This creates recesses on the inside if you wish to add a nut
	rotate(a=[0,0,-60])
		translate([0,-9.75,45.5])
			rotate(a=[90,0,0])
				cylinder(h=3, r=2.85, center = true);
	rotate(a=[0,0,60])
		translate([0,-9.75,45.5])
			rotate(a=[90,0,0])
				cylinder(h=3, r=2.85, center = true);
}

