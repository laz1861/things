//This is a holder for a laser maker.
//It is intended to hold laser line makers on our lasercutter.


//==========Define Geometry============
clr = 0.1;//mm
x_len= 20;//mm - Overall length
y_len= 12;//mm - Overall width
z_len= 11;//mm - Overall height
r_end= 5.5;//mm - x-end radius
pl_thk = 3.7;//mm - Plate thickness
r_hole = 1.5;//mm - radius of bolt hole


//==========Render====================
body();




//==========Modules===================
module body()
{
   
    difference() {
        outline();
        
        //subtract clearance for plate mount
        translate([0,0,(z_len-pl_thk)/2])
            cube([x_len,y_len,pl_thk]);
        
        //subtract hole for lasermount
        translate([x_len-r_end,0,z_len/2])
            rotate([-90,0,0])
            cylinder( h= y_len, r= r_hole, $fn = 40);
        
        
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