// Basic gondola stabilizer and platform for a polargraph
//
// Created by Walter Anderson on June 3, 2014
// Version 1.0.3 modified on June 19, 2004
$fs=0.01;

module hole(size, depth, x, y, z) {
	translate([x, y, z]) {
		cylinder(r = size, h = depth, center = false);
	}
}

// This module is designed to fit a parallax Toddler mini
module mini_servo_plate() {
	union() {
		translate([8.5, 1.5, 8.5]) {
			rotate(a=90, v=[1,0,0]) {
				difference() {
					cube(size = [51, 17, 3], center = true);
					union() {
						cube(size = [36, 17, 3], center = true);
						hole(1.75, 6, -21.5, -4.25, -3);
						hole(1.75, 6, -21.5, 3.5, -3);
						hole(1.75, 6, 21.5, -4.25, -3);
						hole(1.75, 6, 21.5, 3.5, -3);
					}
				}
			}
		}
		translate([-18.5, -2, 8.5]) {
			cube(size = [3, 10, 17], center = true);
		}
		translate([35.5, -2, 8.5]) {
			cube(size = [3, 10, 17], center = true);
		}
	}
}

module bearing()
{
	difference() {
		cylinder(h=10, r=18);
		cylinder(h=10, r=8.5);
	}
}

module micro_servo_plate()
{
	union() {
		translate([6, -1.5, 6]) {
			rotate(a=[90,0,0]) {
				difference() {
					cube(size=[33,12,3], center=true);
					union() {
						cube(size=[23,12,3], center=true);
						hole(1.2, 6, -13.5, 0, -3);
						hole(1.2, 6, 13.5, 0, -3);
					}
				}
			}
		}
		translate([-11.5, -5, 6]) 
			cube(size = [2, 10, 12], center = true);
		translate([23.5, -5, 6]) 
			cube(size = [2, 10, 12], center = true);
	}
}

difference() {
	union() {
		// These two differences and the cube translate
		// creates the basic stabalizer base ring

		// Creates the portion of the stabalizer base that will
		// where the servo and its mounting bracket are located.
		difference() {
			cylinder(h=3,r=60);
         translate([0,25,1.5])
				cube(size = [120,120,3], center=true);
		}

		// This creates the outer ring for the stabalizer base
		difference() {
	  		cylinder(h=3,r=60);
	  		cylinder(h=3,r=45);
		}

		// This creates a vertical cross beam for the stabalizer base
		translate([0,30.5,1.5])
			cube(size = [10,41,3],center=true);

		// This creates the cross beam for the stabalizer base
	   translate([0,0,1.5])
			cube(size = [92,10,3],center=true);

		// Add a servo mounting bracket
//		translate([0,-38,3])		// This fits an old Parallax Toddler mini servo
//			mini_servo_plate();
		translate([0,-38,3])		// This fits a standard micro servo
			micro_servo_plate();

		// Add a stepped spacer to hold the central brass tube,
		// and provide elevation from the surface for the two
		// bearings that mount the chain supports.
		union() {
			cylinder(h=10,r=18);
			translate([0,0,10])
				cylinder(h=0.6,r=12);
		}
		
		// If not using a central brass tube, this will create a printed plastic
		// equivalent
		cylinder(h=40, r=8.5);
	}
	
	// This creates the central 17mm hole that the brass tube
	// will get inserted into.
	//cylinder(h=25,r=8.5);

	// This creates a central 13mm hole that just holds the pen, no brass tube
	cylinder(h=75, r=6.65);

	// This creates two holes that can be used in the clamp piece (needed only for 
	// gondola that doesn't use the central brass tube
	rotate(a=[0,0,60])
		translate([0,-5,36])
			rotate(a=[90,0,0])
				cylinder(h=10, r=2.25, center = true);
	rotate(a=[0,0,-60])
		translate([0,-5,36])
			rotate(a=[90,0,0])
				cylinder(h=10, r=2.25, center = true);
}

// This is the bearing spacer
translate([-22.5,22.5,0]) difference() {
	cylinder(h=1,r=11.5);
	cylinder(h=1,r=8.7);
}


// The following code was just used to verify the placement and fit of the additional parts
//difference() {
//	union() {
//		translate([0,0,33])
//			cylinder(h=7, r=18);
//		translate([0,0,32])
//			cylinder(h=1, r=12);
//	}
//	// This creates a central 13mm hole that just holds the pen, no brass tube
//	cylinder(h=75, r=8.6);
//	// This creates two holes that can be used in the clamp piece (needed only for 
//	// gondola that doesn't use the central brass tube
//	rotate(a=[0,0,60])
//		translate([0,-10,36.5])
//			rotate(a=[90,0,0])
//				cylinder(h=20, r=1.25, center = true);
//	rotate(a=[0,0,-60])
//		translate([0,-10,36.5])
//			rotate(a=[90,0,0])
//				cylinder(h=20, r=1.25, center = true);
//	// This creates recesses on the inside if you wish to add a nut
//	rotate(a=[0,0,-60])
//		translate([0,-9.75,36.5])
//			rotate(a=[90,0,0])
//				cylinder(h=3, r=2.85, center = true, $fs=6);
//	rotate(a=[0,0,60])
//		translate([0,-9.75,36.5])
//			rotate(a=[90,0,0])
//				cylinder(h=3, r=2.85, center = true, $fs=6);
//}
//
//
//// Show bearings, to ensure everything will fit properly
//translate([0,0,10.7]) bearing();
//// This is the bearing spacer
//translate([0,0,20.8]) difference() {
//	cylinder(h=1,r=11.5);
//	cylinder(h=1,r=8.7);
//}
//translate([0,0,21.9]) bearing();
