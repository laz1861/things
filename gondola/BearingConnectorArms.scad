// Lower connector piece
// Main beam
translate([-20,0,0])
	cube(size=[40,3.5,3]);

// Spacer for lip that connect to ring
translate([14,-6.5,0])
	cube(size=[6,10,3]);

// Lower lip that connects to ring
translate([4,-7,0])
	cube(size=[16,3.5,3]);

// Connector piece for ball chain
translate([-20,0,0])
	difference() {
		// 8mm x 10mm block
		translate([0,-7,0])
			cube(size=[8,10,3]);
		union() {
			// Cut two conic holes to retain ball cord
			translate([4,-3,1.5])
				cylinder(h=3,r1=1.5,r2=0.5,center=true,$fs=0.01);
			translate([4,-3,1.5])
				cylinder(h=3,r1=0.5,r2=1.5,center=true,$fs=0.01);

			// Basic slot for cord
			translate([4,-3.5,0])
				cube(size=[4,1,3]);

			// Diagonal cut to allow cord to pass through
			union() {
				translate([4,-3,1.5])
					rotate(a=[45,0,0])
						cube(4,2.12,2.12);
				translate([4,-3,-4.5])
					rotate(a=[45,0,0])
						cube(4,2.12,2.12);
			}
		}
	}


// Upper connector piece
translate([0,20,3]) rotate(a=[0,180,180]) {
	// Main beam
	translate([-20,0,0])
		cube(size=[40,3.5,3]);
	
	// Spacer for lip that connect to ring
	translate([14,-6.5,0])
		cube(size=[6,10,3]);
	
	// Lower lip that connects to ring
	translate([4,-7,0])
		cube(size=[16,3.5,3]);
	
	// Connector piece for ball chain
	translate([-20,0,0])
		difference() {
			// 8mm x 16mm block
			cube(size=[8,13,3]);
			union() {
				// Cut two conic holes to retain ball cord
				translate([4,8,1.5])
					cylinder(h=3,r1=1.5,r2=0.5,center=true,$fs=0.01);
				translate([4,8,1.5])
					cylinder(h=3,r1=0.5,r2=1.5,center=true,$fs=0.01);
	
				// Basic slot for cord
				translate([4,7.5,0])
					cube(size=[4,1,3]);
	
				// Diagonal cut to allow cord to pass through
				union() {
					translate([4,8,1.5])
						rotate(a=[45,0,0])
							cube(4,2.12,2.12);
					translate([4,8,-4.5])
						rotate(a=[45,0,0])
							cube(4,2.12,2.12);
				}
			}
		}
}