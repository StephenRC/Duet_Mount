///////////////////////////////////////////////////////////////////////////////////////
// PIScreenMount.scad - something simple to hold dc42's PanelDue case to 2020 and my PI Touchscreen case
///////////////////////////////////////////////////////////////////////////////////////
// created 7/12/2016
// last update 6/20/20
///////////////////////////////////////////////////////////////////////////////////////
// 8/4/16	- changed bracket to take args for size of paneldue case
// 8/13/16	- width of bracket now based on depth of PanelDue case
//		 	 can now rotate the tabbed version 90 degrees
// 9/3/16	- Added param to select mounting holes in bracket()
// 9/11/16	- Can now tilt bracket if Rt is 0
// 12/17/18	- Added color to preview
// 4/21/20	- Added another tab for strength
// 6/5/20	- Added use of a brass insert
// 6/20/20	- Added mount for the PI Touchscreed case I made nad put this in a seperate file
///////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
use <inc/cubeX.scad>
Use3mmInsert=1;
include <brassfunctions.scad>
$fn=50;
///////////////////////////////////////////////////////////////////////////////////////
clearance = 2;	// amount needed to let the case slide in
thickness = 7;	// thickness of the bracket
//----------------------------------------------------------------------------------------------------------
// From: https://www.raspberrypi.org/documentation/hardware/display/  Scroll to bottom for the drawing
// Some dimensions are rounded up
TSSScreenLeftOffset=11.8;
TSScrewHOffset=126.2;
TSScrewVOffset=65.65;
TSScrew1=0;
TSScrew2=TSScrew1+TSScrewVOffset;
TSScrew3=0;
TSScrew4=TSScrew3+TSScrewHOffset;
TSScrewTopOffset=21.58;
TSScrewLeftOffset=20+12.54;
///////////////////////////////////////////////////////////////////////////////////////

PITabbedBracket(30,113,60,0);		// for a 7" PI Touchscreen on a 2040

//////////////////////////////////////////////////////////////////////////////////////

module PITabbedBracket(p_depth,p_height,m_depth,Rt,Angle=30) {
	translate([-1,0,0]) BracketPI(p_height);
	translate([-5,-3,0]) rotate([0,0,Angle]) {
		translate([-56,-20,-2]) Sample2020();
		translate([5,0,0]) PITab(p_depth,p_height,m_depth+3,5);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module BracketPI(p_height) {	// 1st arg: depth, 2nd arg: height
	difference() {
		color("lightgray") cubeX([p_height+clearance+thickness*2+5,5,20],2);
		translate([25,3,10]) rotate([90,90,0]) MountHoles();
		translate([3.5,0,54.5]) rotate([90,90,0]) MountCSHoles();
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

module Sample2020() {
	//%cube([20,20,40]);
	%import("100mm_Beam.stl");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module thetab(p_de,p_he,m_de,Thickness=thickness) {
	difference() {
		translate([-m_de+4,0,0]) color("blue") cubeX([m_de,Thickness,p_de],2);
		translate([-m_de+12,10,7]) rotate([90,0,0]) color("white") cylinder(h=Thickness*2,d=screw5);
		translate([-m_de+12,10,p_de-7]) rotate([90,0,0]) color("gold") cylinder(h=Thickness*2,d=screw5);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module PITab(p_de,p_he,m_de,Thickness=thickness) {
	difference() {
		translate([-m_de+4,0,0]) color("blue") cubeX([m_de,Thickness,20],2);
		translate([-m_de+12,10,10]) rotate([90,0,0]) color("white") cylinder(h=Thickness*2,d=screw5);
		translate([-m_de+12,9,10]) rotate([90,0,0]) color("gold") cylinder(h=5,d=screw5hd);
	}
	difference() {
		translate([-41,-20.5]) color("pink") cubeX([thickness,25,20],2);
		translate([-45,-10,10]) rotate([0,90,0]) color("black") cylinder(h=thickness*3,d=screw5);
		translate([-35,-10,10]) rotate([0,90,0]) color("white") cylinder(h=5,d=screw5hd);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module MountHoles() {
	TSMountScrews(screw3);
//	translate([TSScrewLeftOffset+TSSScreenLeftOffset,TSScrewTopOffset,-3]) color("cyan") cylinder(h=10,d=screw3);
//	translate([TSScrewLeftOffset+TSSScreenLeftOffset,TSScrewTopOffset+TSScrewVOffset,-3]) color("red") cylinder(h=10,d=screw3);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module TSMountScrews(Screw=Yes3mmInsert()) {
	translate([TSScrew1,TSScrew1,-5]) color("blue") cylinder(h=15,d=Screw);
	translate([TSScrew1,TSScrew2,-5]) color("purple") cylinder(h=15,d=Screw);
	translate([TSScrew1+TSScrewHOffset,TSScrew2,-5]) color("red") cylinder(h=15,d=Screw);
	translate([TSScrew1+TSScrewHOffset,TSScrew1,-5]) color("plum")	cylinder(h=15,d=Screw);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module MountCSHoles(Screw=screw3hd) {
	translate([TSScrewLeftOffset+TSSScreenLeftOffset,TSScrewTopOffset,-1]) color("cyan") cylinder(h=5,d=Screw+0.5);
	translate([TSScrewLeftOffset+TSSScreenLeftOffset,TSScrewTopOffset+TSScrewVOffset,-1]) color("red") cylinder(h=5,d=Screw+0.5);
}

/////////////////// end of panelduemount.scad ////////////////////////////////////////
