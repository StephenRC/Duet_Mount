///////////////////////////////////////////////////////////////////////////////////////
// PanelDueMount.scad - something simple to hold dc42's PanelDue case to 2020 and my PI Touchscreen case
///////////////////////////////////////////////////////////////////////////////////////
// created 7/12/2016
// last update 11/23/20
///////////////////////////////////////////////////////////////////////////////////////
// https://creativecommons.org/licenses/by-sa/4.0/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 8/4/16	- changed bracket to take args for size of paneldue case
// 8/13/16	- width of bracket now based on depth of PanelDue case
//		 	 can now rotate the tabbed version 90 degrees
// 9/3/16	- Added param to select mounting holes in bracket()
// 9/11/16	- Can now tilt bracket if Rt is 0
// 12/17/18	- Added color to preview
// 4/21/20	- Added another tab for strength
// 6/5/20	- Added use of a brass insert
// 9/29/20	- Added DC42Spacer() for dc42's paneldue enclosure
// 10/11/20	- Added an angle spacer to tilit dc42's paneldue 7" case
// 11/23/20	- Added an anlge version to allow acces to the sd card slot, requires mount holes in dc42's paneldue lid
///////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
include <bosl2/std.scad>
include <inc/brassinserts.scad>
$fn=50;
///////////////////////////////////////////////////////////////////////////////////////
// **NOTE: You'll get low voltage lightning every so often on the pi/hdmi screen if powered from the Duet 3 6HC
///////////////////////////////////////////////////////////////////////////////////////
clearance = 2;	// amount needed to let the case slide in
thickness = 7;	// thickness of the bracket
LayerThickness=0.3;
//----------------------------------------------------------------------------------------------------------
// From: https://www.raspberrypi.org/documentation/hardware/display/  Scroll to bottom for the drawing
// Some dimensions are rounded up
TSSScreenLeftOffset=11.8;
TSScrewHOffset=126.2;
TSScrewVOffset=65.5;
TSScrewTopOffset=21.58;
TSScrewLeftOffset=20;
// https://duet3d.dozuki.com/Wiki/PanelDue#Section_3D_Models_and_Enclosures

//------------------------------------------------------------------------------------------------------------
Use3mmInsert=1;
Use5mmInsert=1;
LargeInsert=1;
///////////////////////////////////////////////////////////////////////////////////////

//bracket(31,89.5);				// for a 4.3" PanelDue
//bracket(33,124);				// for a 7" PanelDue
//tabbedbracket(0,31,89.5,20,0);	// 3rd arg is length of mounting tab, 4th arg is rotate 90 degrees
								// 5 arg is angle of bracket if 4th arg is 0 (default: 30)
//tabbedbracket(2,33,124,60,0);		// for a 7" PanelDue on a 2040
//DC42Spacer(6,2);
//AngleMountPanelDue(0);
AngleMountPanelDueSD(1);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module AngleMountPanelDue(NoExtMount=0) {
	difference() {
		color("cyan") hull() {
			cuboid([130,15,1],rounding=0,5,p1=[0,0]);
			translate([0,13,8]) cuboid([130,1,1],rounding=0.5,p1=[0,0]);
		}
		if(!NoExtMount) {
			translate([25,10,-5]) color("black")cylinder(d=screw5,h=20);
			translate([25,10,4]) color("white")cylinder(d=screw5hd,h=10);
			translate([105,10,-5]) color("white")cylinder(d=screw5,h=20);
			translate([105,10,4]) color("black")cylinder(d=screw5hd,h=10);
		}
		translate([15,13,-5]) rotate([35,0,0]) {
			translate([0,0,0]) color("red") cylinder(d=Yes5mmInsert(Use5mmInsert),h=20);
			translate([100,0,0]) color("blue") cylinder(d=Yes5mmInsert(Use5mmInsert),h=20);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module AngleMountPanelDueSD(HorizontalMount=0) {
	difference() {
		union() {
			if(HorizontalMount) color("cyan") cuboid([130,20+thickness,thickness],rounding=1,p1=[0,0]);
			color("blue") cuboid([130,thickness,33+thickness],rounding=1,p1=[0,0]);
			translate([0,-3,25]) color("pink") cuboid([130,thickness+1,8+thickness],rounding=1,p1=[0,0]);
			translate([0,-2,25]) rotate([90,0,0]) AngleMountPanelDue(1);
			translate([0,-2.81,26]) color("gray") hull() {
				translate([0,-1,0]) cuboid([130,6,1],rounding=0.5,p1=[0,0]);
				translate([0,3,-6]) cuboid([130,1.5,1],rounding=0.5,p1=[0,0]);
			}
		}
		translate([15,10,42]) rotate([125,0,0]) {
			translate([0,0,0]) color("white") cylinder(d=Yes5mmInsert(Use5mmInsert),h=20);
			translate([100,0,0]) color("pink") cylinder(d=Yes5mmInsert(Use5mmInsert),h=20);
		}
		if(HorizontalMount) {
			translate([10,10+thickness,-3]) color("red") cylinder(h=15,d=screw5); 
			translate([120,10+thickness,-3]) color("plum") cylinder(h=15,d=screw5);
			translate([10,10+thickness,-3]) color("plum") cylinder(h=5,d=screw5hd); 
			translate([120,10+thickness,-3]) color("red") cylinder(h=5,d=screw5hd);
		} else {
			echo("vertical");
			translate([10,10,10]) rotate([90,0,0]) color("red") cylinder(h=15,d=screw5); 
			translate([120,10,10])  rotate([90,0,0]) color("plum") cylinder(h=15,d=screw5);
			translate([10,2,10])  rotate([90,0,0]) color("plum") cylinder(h=5,d=screw5hd); 
			translate([120,2,10])  rotate([90,0,0]) color("red") cylinder(h=5,d=screw5hd);
		}
	}
		if(HorizontalMount) {
			translate([10,10+thickness,2])  color("black") cylinder(h=LayerThickness,d=screw5hd); // support
			translate([120,10+thickness,2])  color("gray") cylinder(h=LayerThickness,d=screw5hd); // support
		}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module DC42Spacer(Tall=0,Quanity=1) {
	for(x = [0 : Quanity-1]) {
		translate([x*12,0,0]) difference() {
			color("cyan") cubeX([10,20,Tall],2);
			translate([5,10,-2]) color("red") cylinder(h=5+Tall,d=screw5);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////

module bracket(p_depth,p_height,Mounting=1) {	// 1st arg: depth, 2nd arg: height
	difference() {
		color("cyan") cubeX([p_height+clearance+thickness*2,p_depth+clearance+thickness*2,p_depth],2);
		// suck out center
		translate([thickness,thickness,-1]) color("blue") cube([p_height+clearance,p_depth+clearance,p_depth+5]);
		// remove part in front of screen
		translate([thickness*3,p_depth+clearance,-1]) color("gray") cube([p_height+clearance-thickness*4,p_depth+clearance,45]);
		if(Mounting) mountingholes(p_depth,p_height);
		clampingscrew(p_depth,p_height);
	}

}

//////////////////////////////////////////////////////////////////////////////////////////////

module mountingholes(p_depth,p_height) { // flat mounting
	translate([(p_height+clearance)/4+6,thickness+2,p_depth/2])
		rotate([90,0,0]) color("red") cylinder(h=thickness*2,d=screw5);
	translate([p_height+clearance - p_height/4+6,thickness+2,p_depth/2])
		rotate([90,0,0]) color("black") cylinder(h=thickness*2,d=screw5);
	translate([(p_height+clearance)/4+6,thickness+11,p_depth/2])
		rotate([90,0,0]) color("white") cylinder(h=thickness*2,d=screw5hd);
	translate([p_height+clearance - p_height/4+6,thickness+11,p_depth/2])
		rotate([90,0,0]) color("gray") cylinder(h=thickness*2,d=screw5hd);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module clampingscrew(p_depth,p_height) {
	translate([-2,(p_depth+clearance)/2+thickness,p_depth/2]) rotate([0,90,0]) color("plum") cylinder(h=300,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
}

//////////////////////////////////////////////////////////////////////////////////////

module tabbedbracket(Type=0,p_depth,p_height,m_depth,Rt,Angle=30) {
	// add a tab for horizontal 2020 mount with the PanelDue above
	bracket(p_depth,p_height,0);
	if(Rt)
		translate([0,p_depth,0]) rotate([90,0,0]) thetab(p_depth,p_height,m_depth);
	if(Type==0) {
		%translate([-59,-29,-2]) rotate([0,0,Angle]) cube([20,20,40]);
		translate([5,0,0]) rotate([0,0,Angle]) thetab(p_depth,p_height,m_depth+5);
		translate([-8.5,19.5+thickness/2,0]) rotate([0,0,Angle]) thetab(p_depth,p_height,m_depth+5);
		translate([-10,18.63+thickness/2,0]) rotate([0,0,Angle]) color("pink") cubeX([20,thickness,p_depth],2);
	}
	if(Type==1) {
		rotate([0,0,Angle]) {
			%translate([-56,0+thickness,-2]) cube([20,20,40]);
			translate([5,0,0]) thetab(p_depth,p_height,m_depth+5);
			difference() {
				translate([-36,0+thickness/2,0]) color("pink") cubeX([thickness,25,p_depth],2);
				translate([-45,thickness+10,7]) rotate([0,90,0]) color("black") cylinder(h=thickness*3,d=screw5);
				translate([-45,thickness+10,25]) rotate([0,90,0]) color("white") cylinder(h=thickness*3,d=screw5);
			}
		}
	}
	if(Type==2) {
		rotate([0,0,Angle]) {
			%translate([-56,-20,-2]) cube([20,20,40]);
			translate([5,0,0]) thetab(p_depth,p_height,m_depth+5);
			translate([0,-p_depth+thickness*2,0]) difference() {
				translate([-36,thickness/2-2.5]) color("pink") cubeX([thickness,25,p_depth],2);
				translate([-45,9,7]) rotate([0,90,0]) color("black") cylinder(h=thickness*3,d=screw5);
				translate([-45,9,25]) rotate([0,90,0]) color("white") cylinder(h=thickness*3,d=screw5);
			}
		}
	}
}

module thetab(p_de,p_he,m_de,Thickness=thickness) {
	difference() {
		translate([-m_de+4,0,0]) color("blue") cubeX([m_de,Thickness,p_de],2);
		translate([-m_de+12,10,7]) rotate([90,0,0]) color("white") cylinder(h=Thickness*2,d=screw5);
		//translate([-m_de+12,thickness*2+5,7]) rotate([90,0,0]) color("gray") cylinder(h=thickness*2,d=screw5hd);
		translate([-m_de+12,10,p_de-7]) rotate([90,0,0]) color("gold") cylinder(h=Thickness*2,d=screw5);
		//translate([-m_depth+12,thickness*2+5,p_depth-7]) rotate([90,0,0]) color("black") cylinder(h=thickness*2,d=screw5hd);
	}
}

/////////////////// end of panelduemount.scad ////////////////////////////////////////
