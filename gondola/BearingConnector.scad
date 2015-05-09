$fs=0.01;

difference() {
	union() {
		cylinder(h=3,r=23,center=true);
		translate([10,-5,-1.5])
			cube(size=[15,10,3]);
		translate([28,0,0])
			cylinder(h=3,r=5,center=true);
		translate([19,7.9,0])
			rotate(a=[0,0,59])
				cube(size=[5,20,3],center=true);
		translate([19,-7.9,0])
			rotate(a=[0,0,-59])
				cube(size=[5,20,3],center=true);
	}
	cylinder(h=3,r=17.6,center=true);
	translate([18.1,-1.5,-1.5])
		cube(size=[6.4,3,3]);
	translate([15,-1.5,-1.5])
		cube(size=[4,3,3]);
}
