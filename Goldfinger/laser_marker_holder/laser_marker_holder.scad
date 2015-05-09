//This is a holder for a laser maker.
//It is intended to hold laser line makers on our lasercutter.


//==========Define Geometry============
fudge = 0.1;//mm
x_len= 25;//mm - Overall length
y_len= 12;//mm - Overall width
z_len= 11;//mm - Overall height
r_end= 5.5;//mm - x-end radius
pl_thk = 3.7;//mm - Plate thickness
pl_len = 10;;//mm the depth of the cut for the plate
las_thk= 2.85;//mm - the thickness of the laser holder cutaway
r_hole = 1.55;//mm - radius of bolt hole


//==========Render====================
rotate([90,0,0])
body();


//==========Modules===================
module body()
{
   
    difference() {
        outline();
        
        //subtract clearance for plate mount
        translate([-fudge,-fudge,(z_len-pl_thk)/2])
            cube([pl_len+2*fudge,y_len+2*fudge,pl_thk]);
        
        //subtract hole for lasermount
        translate([x_len-r_end,-fudge,z_len/2])
            rotate([-90,0,0])
            cylinder( h= y_len+2*fudge, r= r_hole, $fn = 40);
        
        //subtract cutaway for lasermount body
        translate([x_len-2*r_end,(y_len-las_thk)/2,-fudge])
            cube([x_len,las_thk,z_len+2*fudge]);
        
        //subtract hole for plate mount
        translate([pl_len/2,y_len/2,0])
            cylinder( h= y_len +2*fudge, r = r_hole, $fn = 20);
        
    };
        
};

module outline() {
    //Create outline of body
    union() {
        cube([x_len-r_end,y_len,z_len]);
        translate([x_len-r_end,0,r_end])
            rotate([-90,0,0])
                cylinder(h = y_len, r = r_end, $fn = 40);
        
        
    };
};