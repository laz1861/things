// Laz's MendelMax1.5  
// X-carriage
// Used for sliding on X axis
// Modified for E3Dv6 Hot End and KM Extruder
// All dimensions are in mm


//include <configuration.scad>

/**
 * Slides on the x-axis with extruder.
 * @name X carriage
 * @category Printed
 * @using 4 m3x10
 * @using 4 m3washer
 * @using 4 m3nut
 * @using 4 LM8UU Bearings
 */ 

//Define Physical Parameters
m8_diameter=9;
//m8_nut=16.4;
m4_diameter=5;
//m4_nut=9;
m3_diameter=4.4;
m3_nut_diameter=7;

//Define geometric parameters

//Bearing Holder Dimensions
clearance=0.7;
lm8uu_diameter=15+clearance;
lm8uu_length=24+clearance;
lm8uu_support_thickness=2.29; 
lm8uu_end_diameter=m8_diameter+1.5;

lm8uu_holder_width=lm8uu_diameter+2*lm8uu_support_thickness;
lm8uu_holder_length=lm8uu_length+2*lm8uu_support_thickness;
lm8uu_holder_height=lm8uu_diameter*0.75+lm8uu_support_thickness;

lm8uu_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2;

echo ("lm8uu_holder_width",50-lm8uu_holder_width);

//carriage
carriage_thickness = 3;
xdim = 35; //one half the x dimension
ydim = 40; //one half the y dimension
holder_separation = 2*(ydim-lm8uu_holder_length);


//belt
belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;

//teflon tube
tef_dia = 8; 

//hot end 
HE_dia = 16.05;
HE_recess = 3;


//holder_separation=18;

/*for (i=[-1,1])
translate([0,i*(belt_clamp_width+1),0])
belt_clamp();

belt_clamp_channel();
*/


 
gregs_x_carriage();

//y_axis_holder ();

module gregs_x_carriage(with_fanmount=false) 
{
	difference()
	{
		union ()
		{       //This section establishes body shape
			linear_extrude(height=carriage_thickness)
			{color([0,0,1])
			polygon(points=[[-xdim,-ydim],[xdim,-ydim],[xdim,ydim],[-xdim,ydim]],paths=[[0,1,2,3]]);
			}

                        //Add bearing holder blocks
                        difference ()
                        {       
                            union ()
                            {               
                                for(i=[-1,1])
                                {    //This is the rear holder set
                                    translate([50/2-lm8uu_holder_width/2,
					i*(lm8uu_holder_length+holder_separation)/2-
					lm8uu_holder_length/2,0])
                                    lm8uu_bearing_holder();
                                    
                                    translate([-50/2-lm8uu_holder_width/2,i*(lm8uu_holder_length+holder_separation)/2-
					lm8uu_holder_length/2,0])
                                    lm8uu_bearing_holder();
                                }       
                            
                            }
                            //remove cable tie holes
                            cable_tie_holes();
                        }
                        
                       /* //This section makes the raised ring for the extruder mount holes
			difference()
			{
				cylinder(r=25+m4_diameter,h=6);
				translate([25-lm8uu_holder_width/2+lm8uu_support_thickness,-lm8uu_holder_length,-1])
				cube([lm8uu_holder_width,2*lm8uu_holder_length,8]);
				translate([-25-lm8uu_holder_width/2,-lm8uu_holder_length/2,-1])
				cube([lm8uu_holder_width,lm8uu_holder_length,8]);
			}
*/
//			belt_support_offset=25+17.5;
                        //this adds the belt clamps to the front of the carriage
			for (i=[-1,1])
			translate([-25-13.5-1,i*(ydim-belt_clamp_width/2)])
			rotate(90*(i+1)+180) 
			belt_clamp_socket ();
		}
	
		//begin making removals
                //extruder mount holes
                for (i=[0:1])
		rotate(180*i)
		translate([0,25,-1])
		cylinder(r=m4_diameter/2,h=lm8uu_support_thickness*2+2,$fs=1);
	        
                //central extruder clearance hole
		translate([0,0,-1])
		cylinder(r=tef_dia/2,h=lm8uu_support_thickness*2+2);
                
                //recess for hot end
                translate([0,0,carriage_thickness-HE_recess])
                cylinder(r=HE_dia/2,carriage_thickness);

                //belt holder bolt hole cleanout
		for (i=[-1,1])
		translate([-25-13.5-1,i*(ydim-belt_clamp_width/2)])
		rotate(90*(i+1)+180) 
		belt_clamp_holes();

		// Cable tie holes for rear bearings
		for (i=[-1,1])
		translate([25-lm8uu_holder_width/2,(holder_separation/2+lm8uu_holder_length*0.7)*i,5])
		rotate([0,-30,0])
		cube([2,4,20],center=true);
                
                // for front bearing
		cable_tie_holes();
	}

	
}

module cable_tie_holes ()
{
	// Cable tie holes.
	for (i=[-1,1])
	translate([25-lm8uu_holder_width/2,(holder_separation/2+lm8uu_holder_length*0.7)*i,5])
	rotate([0,-30,0])
	cube([2,4,20],center=true);

#	for (i=[-1,1])
	{
		translate([-25+lm8uu_holder_width/2,6.5*i,5])
		rotate([0,30,0])
		translate([2,0,0])
		cube([6,4,20],center=true);

//		translate([-25-lm8uu_holder_width/2-1,6.5*i-2,-1.9])
//		cube([lm8uu_holder_width+2,4,1.9]);
	}
}



//translate([25,-m4_nut_diameter/2,0])
//cylinder(r=m4_nut_diameter/2,h=10,$fn=6);

screw_hole_r=4/2;

module y_axis_holder()
{
	difference()
	{
		render()
		lm8uu_bearing_holder();
		for (hole=[-1,1])
		{
			translate([lm8uu_holder_width/2,lm8uu_holder_length/2+hole*(lm8uu_support_thickness+lm8uu_holder_gap/2),0])
			{
				cylinder(r1=screw_hole_r,r2=screw_hole_r+(lm8uu_support_thickness+1)/2,h=lm8uu_support_thickness+1);
				translate([0,0,-1])
				cylinder(r=screw_hole_r,h=2);
			}
		}
	}
}

module lm8uu_bearing_holder()
{
	difference()
	{
		cube([lm8uu_holder_width,lm8uu_holder_length,lm8uu_holder_height]);
		translate([lm8uu_holder_width/2,0,lm8uu_holder_width/2])
		rotate([-90,0,0])
		translate([0,0,lm8uu_support_thickness])
		cylinder(r=lm8uu_diameter/2,h=lm8uu_length,$fn=40);

		translate([lm8uu_holder_width/2,0,lm8uu_holder_width/2])
		rotate([-90,0,0])
		translate([0,0,-1])
		{
			cylinder(r=lm8uu_end_diameter/2,h=lm8uu_holder_length+2,$fn=40);
			translate([-lm8uu_end_diameter/2,-lm8uu_end_diameter,0])
			cube([lm8uu_end_diameter,lm8uu_end_diameter,lm8uu_holder_length+2]);
		}

		translate([-1,2*lm8uu_support_thickness,lm8uu_support_thickness])
		cube([lm8uu_holder_width+2,lm8uu_holder_gap,
			lm8uu_holder_height-lm8uu_support_thickness+1]);

		translate([-1,4*lm8uu_support_thickness+lm8uu_holder_gap,
			lm8uu_support_thickness])
		cube([lm8uu_holder_width+2,lm8uu_holder_gap,
			lm8uu_holder_height-lm8uu_support_thickness+1]);
	}
}

belt_clamp_hole_separation=10;

belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

module belt_clamp_socket()
{
	difference()
	{
		translate([0,0,belt_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_height,center=true);
		}
		belt_clamp_holes();
	}
}

belt_width=6.5; //g2 belt width
belt_thickness=1.5; 
tooth_height=1.5;
tooth_spacing=2; //g2 belt spacing

belt_clamp_channel_height=belt_thickness+tooth_height+belt_clamp_thickness*2;

module belt_clamp_channel()
{
	difference()
	{
		translate([0,0,belt_clamp_channel_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_channel_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_channel_height,center=true);
		}

		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		cylinder(r=m3_diameter/2,h=belt_clamp_channel_height+2,$fn=8);

		translate([-belt_width/2,-belt_clamp_width/2-1,belt_clamp_channel_height-belt_thickness-tooth_height])
		cube([belt_width,belt_clamp_width+2,belt_thickness+tooth_height+1]);
	}
}

module belt_clamp_holes()
{
	translate([0,0,belt_clamp_height/2])
	{
		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,0])
		cylinder(r=m3_diameter/2,h=belt_clamp_height+2,center=true,$fn=8);
	
		rotate([90,0,0])
		rotate(360/16)
		cylinder(r=m3_diameter/2-0.3 /*tight*/ ,h=belt_clamp_width+2,center=true,$fn=8);

		rotate([90,0,0]) 
		translate([0,0,belt_clamp_width/2])
		cylinder(r=m3_nut_diameter/2-0.3 /*tight*/ ,h=3.4,center=true,$fn=6);
	}
}

belt_clamp_clamp_height=tooth_height+belt_clamp_thickness*2;


module belt_clamp()
{
	difference()
	{
		translate([0,0,belt_clamp_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_clamp_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height,center=true);
		}

		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		cylinder(r=m3_diameter/2,h=belt_clamp_clamp_height+2,$fn=8);

		for(i=[-3:3])  //more grooves for finer pitch g2 belt
		translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,belt_clamp_clamp_height-tooth_height])
		cube([belt_width,tooth_spacing/2,tooth_height+1]);
	}
}

module barbell (x1,x2,r1,r2,r3,r4) 
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}
/*
fan_hole_separation=32; // check
fan_support_block=11;
fan_trap_width=3;
fan_support_thickness=11;
fan_diameter=36;
fan_hole_height=5.5;

module fan_mount() 
{
	difference()
	{
		union ()
		{
			translate([0,0,fan_support_block/4])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness,fan_support_block/2],center=true);
			
			for (i=[-1,1])
			translate([i*fan_hole_separation/2,0,fan_support_block/2])
			rotate([90,0,0])
			cylinder(r=fan_support_block/2,h=fan_support_block,center=true,$fn=20);
			
			translate([0,0,fan_support_block/2])
			cube([fan_hole_separation,fan_support_thickness,fan_support_block],center=true);
			translate([0,6,lm8uu_support_thickness/2])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness+12,lm8uu_support_thickness],center=true);
		}
		for(i=[-1,1])
		{
			translate([i*fan_hole_separation/2,0,fan_hole_height])
			{
				rotate([90,0,0])
				rotate(180/8)
				cylinder(r=m3_diameter/2,h=fan_support_thickness+2,center=true,$fn=8);
				translate([0,0,0])
				rotate([90,0,0])
				rotate([0,0,180/6])
				cylinder(r=(m3_nut_diameter-0.5)/2,h=fan_trap_width,center=true,$fn=6);
				color([1,0,0])
				translate([0,0,-(fan_hole_height+1)/2])
				cube([(m3_nut_diameter-0.5)*cos(30),fan_trap_width,fan_hole_height+1],center=true);
			}
		}
		translate([0,0,fan_hole_separation/2+fan_hole_height])
		rotate([-90,0,0])
		cylinder(r=fan_diameter/2,h=fan_support_thickness+2,center=true);
	}
}

module fan_mount1() 
{
	difference()
	{
		union ()
		{
			translate([0,0,fan_support_block/4])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness,fan_support_block/2],center=true);
			
			for (i=[-1,1])
			translate([i*fan_hole_separation/2,0,fan_support_block/2])
			rotate([90,0,0])
			cylinder(r=fan_support_block/2,h=fan_support_block,center=true,$fn=20);
			
			translate([0,0,fan_support_block/2])
			cube([fan_hole_separation,fan_support_thickness,fan_support_block],center=true);
			translate([0,-6,lm8uu_support_thickness/2])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness+12,lm8uu_support_thickness],center=true);
		}
		for(i=[-1,1])
		{
			translate([i*fan_hole_separation/2,0,fan_hole_height])
			{
				rotate([90,0,0])
				rotate(180/8)
				cylinder(r=m3_diameter/2,h=fan_support_thickness+2,center=true,$fn=8);
				translate([0,0,0])
				rotate([90,0,0])
				rotate([0,0,180/6])
				cylinder(r=(m3_nut_diameter-0.5)/2,h=fan_trap_width,center=true,$fn=6);
				color([1,0,0])
				translate([0,0,-(fan_hole_height+1)/2])
				cube([(m3_nut_diameter-0.5)*cos(30),fan_trap_width,fan_hole_height+1],center=true);
			}
		}
		translate([0,0,fan_hole_separation/2+fan_hole_height])
		rotate([-90,0,0])
		cylinder(r=fan_diameter/2,h=fan_support_thickness+2,center=true);
	}
}
*/
function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];
