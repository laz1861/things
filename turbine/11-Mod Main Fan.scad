
main_fan();
match();

//===Modules===
module main_fan(){
    translate([-57.2,77.1,0])
    import("11_-_Main_Fan.stl");
}

module match(){
    translate([0,0,-5])
    cylinder(r=5.7,h=10,center=true,$fn=40);
}