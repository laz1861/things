// copyright 2012 mark.dufour@gmail.com, license GPL v3

// configuration

BOARD_THICKNESS=8;
VERTICAL_GAP=45;
FOOT_HEIGHT=4;
WOOD_SCREW_R=1;
LAYER_HEIGHT=0.2;

// internal

HEIGHT=FOOT_HEIGHT+BOARD_THICKNESS+VERTICAL_GAP-4; // existing lower vertices stick out by 4mm

LENGTH=62;
WIDTH=24;
CURVE_R=4;
CURVE_R2=20;
THICKNESS=4;
HOLE_R=3;
HOLE_X=34;
HOLE_Y=10;
SUPPORT_WIDTH=20;

module base_shape() {
    difference() {
        translate([CURVE_R, CURVE_R,-1/2])
            minkowski() {
                cylinder(1,r=4, $fn=20);
                cube([LENGTH-2*CURVE_R,WIDTH-2*CURVE_R,0.001]);
            }

        translate([LENGTH-CURVE_R2,CURVE_R2,-1/2])
            difference() {
                translate([0,-100,0])
                    cube([100,100,2]);
                cylinder(2,r=CURVE_R2, $fn=50);
            }
    }
}

module screw() {
    translate([0,0,2])
        cylinder(THICKNESS-2,r=WOOD_SCREW_R);
    cylinder(2,r2=WOOD_SCREW_R,r1=WOOD_SCREW_R+2,$fn=20);
}

module base() {
    translate([0,0,-HEIGHT/2])
        cube([THICKNESS,THICKNESS,HEIGHT]);
    difference() {
        scale([1,1,HEIGHT])
            base_shape();
        translate([THICKNESS,-THICKNESS,-HEIGHT/2+THICKNESS])
            cube([LENGTH,WIDTH,HEIGHT]);
        translate([LENGTH/4,WIDTH/2,-HEIGHT/2])
            screw();
        translate([3*LENGTH/4,WIDTH/2,-HEIGHT/2])
            screw();
        translate([HOLE_X,HOLE_Y,-HEIGHT/2-1])
            cylinder(THICKNESS+2,r=HOLE_R);
    }
}

module support() {
    mirror([0,1,0])
        difference() {
            union() {
                cube([SUPPORT_WIDTH,WIDTH,THICKNESS]);
                support_45();
                translate([SUPPORT_WIDTH-THICKNESS,0,0])
                    support_45();
            }
            translate([SUPPORT_WIDTH/2,WIDTH-HOLE_Y,0])
                cylinder(2*THICKNESS,r=HOLE_R);
        }
    translate([SUPPORT_WIDTH/2-HOLE_R,-(WIDTH-HOLE_Y+HOLE_R),0])
        cube([2*HOLE_R,2*HOLE_R,LAYER_HEIGHT]);
}

module support_45() {
    mirror([0,1,0])
    translate([0,-WIDTH,-WIDTH])
        intersection() {
            translate([0,WIDTH,0])
            rotate([45,0,0])
                cube([THICKNESS,WIDTH*1.414,WIDTH*1.414]);
            cube([THICKNESS,WIDTH,WIDTH]);
        }
}

module foot() {
    base();
    translate([HOLE_X-SUPPORT_WIDTH/2,WIDTH,HEIGHT/2-THICKNESS])
        support();
}

mirror([0,0,0])
    foot();
