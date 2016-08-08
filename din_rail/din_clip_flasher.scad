CLIP_H = 20;
HOLE_DEPTH = 40;
HOLE_DIAMETER = 2.9;
clearance = 0.1;//mm
head_size = 6;//mm
y_offset = 12; //mm
zip_width = 5;//mm
zip_depth = 5;//mm
zip_offset = 25;//mm


module din_clip() {
	
	difference() {

		linear_extrude(height=CLIP_H, center=true, convexity=5) {
			import(file="din_clip_01.dxf", layer="0", $fn=64);
		}
        
        translate([0,y_offset,0])
        rotate([0,90,0])
        cylinder(r = HOLE_DIAMETER/2+clearance, h=HOLE_DEPTH, $fn=24);
        
        translate([5,y_offset,0])
        rotate([0,90,0])
        cylinder(r = head_size/2+clearance, h=HOLE_DEPTH, $fn=24);
        
        translate([11,zip_offset,-CLIP_H])
        cube([zip_depth,zip_width,CLIP_H*2]);
        
    }
		/*union() {

			translate([0, 40, 0]) {
				rotate([0, 90, 0]) {
					cylinder(h= HOLE_DEPTH, r = HOLE_DIAMETER / 2, $fn = 16);
				}
			}

			translate([0, 10, 0]) {
				rotate([0, 90, 0]) {
					cylinder(h= HOLE_DEPTH, r = HOLE_DIAMETER / 2, $fn = 16);
				}
			}
            
		}*/


}

din_clip();

