difference(){
    import("Ultimaker Robot Knoxmaker Logo.stl");
    translate([-5.75,-10,11.5]) cube([11.5,4,10]);
}
    translate([-5.5,-6.5,10.5]) rotate ([90,0,0]) scale([.25,.25,.01]) 
        surface(file = "KnoxMaker Logo Small.png", invert=true,convexity = 5);
