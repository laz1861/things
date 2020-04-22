//Constants
h_led = .134*25.4; //mm
h_total = 1.75*h_led; //mm
d_screw = 3;//mm
d_head = 5;//mm
edge=1.5;//mm
center=10;//mm
w_led = .4*25.4; //mm need to measure
w_total = center+2*(w_led+edge+d_head+edge); //mm
l_total = d_head +2*edge; //mm
fudge=.001;//mm to offset coincident faces



//make a cube, and take differences
difference () {
    //root cube
    cube([w_total,l_total,h_total]);
    //remove screwholes
    translate([d_head/2+edge,l_total/2,-fudge])
    cylinder(h=h_total+2*fudge,d=d_screw,$fn=24); 
    translate([w_total-d_head/2-edge,l_total/2,-fudge])
    cylinder(h=h_total+2*fudge,d=d_screw,$fn=24);
    //remove LED relief
    translate([w_total/2-center/2-w_led/2,-fudge,0])
    rotate([-90,0,0])
    scale([w_led/h_led/2,1,1])
    cylinder(h=l_total+2*fudge,d=h_led*2,$fn=40);
    //remove LED relief
    translate([w_total/2+center/2+w_led/2,-fudge,0])
    rotate([-90,0,0])
    scale([w_led/h_led/2,1,1])
    cylinder(h=l_total+2*fudge,d=h_led*2,$fn=40);
    //countersink screw holes
    
    
    
    
}