

front_shaft();
match();
//Front Shaft Dimensions
//Read Outer Radius = 8mm
//Rear Inner Radius = 3.9mm
//Rear Section Length = 32.2mm
//Front Section radius = 5.6mm



//====Modules=====
module front_shaft(){
    //center the shaft on the x-y origin
    translate([-51.3,76.9,-32.2])
    import("3_-_Front_Shaft.stl");
    
}

module match(){
    translate([0,0,5])
    cylinder(r=5.65,h=10,center=true,$fn=40);
}