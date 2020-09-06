/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PIScreen.scad - something simple to hold dc42's PanelDue case to 2020 and my PI Touchscreen case
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 7/12/2016
// last update 8/17/20
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 8/4/16	- changed bracket to take args for size of paneldue case
// 8/13/16	- width of bracket now based on depth of PanelDue case
//		 	 can now rotate the tabbed version 90 degrees
// 9/3/16	- Added param to select mounting holes in bracket()
// 9/11/16	- Can now tilt bracket if Rt is 0
// 12/17/18	- Added color to preview
// 4/21/20	- Added another tab for strength
// 6/5/20	- Added use of a brass insert
// 6/20/20	- Added mount for the PI Touchscreed case I made nad put this in a seperate file
// 8/17/20	- Added the Pi touchscreen modules that were in the "Duet2020 for Duet 3.scad"
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
use <inc/cubeX.scad>
Use3mmInsert=1;
include <brassfunctions.scad>
$fn=50;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ** NOTE: Cannot be powered by the Duet 3 6HC, the pi4 gives a low voltage warning
// The mounting screws holding the pi screen brackets also hold the touchscreen, make sure they are not too long
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Clearance = 2;	// amount needed to let the case slide in
BracketThickness = 7;	// thickness of the bracket
//----------------------------------------------------------------------------------------------------------
// From: https://www.raspberrypi.org/documentation/hardware/display/  Scroll to bottom for the drawing
// Some dimensions are rounded up
TSScrewTopOffset=21.58;
TSSScreenLeftOffset=11.8;
TSScrewHOffset=126.2;
TSScrewVOffset=65.65;
TSScrewLeftOffset=20+12.54;
TSScreenNutBump=2.5;
TSScreenThicknessFull=5.96+TSScreenNutBump;
TSScreenThickness=1.5;
TSScreenStiffner=1.4;
TSWidth=194;
TSLength=112;
TSCornerRadius=7.86;
TSPIScrewLeftOffset=48.45+12.54;
AdjustY=1; // fine tune the screen mounting
AdjustX=2; // fine tune the screen mounting
TSSpacerDepth=16;
TSDepth=TSSpacerDepth+TSScreenThickness;
ScreenBaseThickness=3;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//PI7Touchscreen(0);  // 0: full case; 1-4: test print with one of the walls
PiTouchscreenBracket(2,1,30,90,60,30,0);		// for the 7" PI Touchscreen on a 2040
//					Qty=1,MountHoles=1,p_depth,p_height,m_depth,Angle=30,Show=0
//TestPrintHoles();

///////////////////////////////////////////////////////////////////////////////////////////

module TestPrintHoles() {
	difference() {
		color("cyan") cubeX([TSScrewHOffset+10,TSScrewVOffset+10,2],1);
		translate([10,10,-2]) color("gray") cubeX([TSScrewHOffset-10,TSScrewVOffset-10,6],1);
		translate([5,5,0]) TSMountScrews(screw3);
	}
	translate([5,5,0]) ScreenSpacer(TSSpacerDepth);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module TSMountScrews(Screw=Yes3mmInsert()) {
	translate([0,0,-5]) color("blue") cylinder(h=15,d=Screw);
	translate([0,TSScrewVOffset,-5]) color("green") cylinder(h=15,d=Screw);
	translate([TSScrewHOffset,0,-5]) color("purple") cylinder(h=15,d=Screw);
	translate([TSScrewHOffset,TSScrewVOffset,-5]) color("red") cylinder(h=15,d=Screw);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScreenSpacer(Thickness=TSDepth,Screw=screw3) {
	//echo(Thickness);
	translate([0,0,0]) color("blue") Spacer(1,Thickness,Screw);
	translate([0,TSScrewVOffset,0]) color("purple") Spacer(1,Thickness,Screw);
	translate([TSScrewHOffset,TSScrewVOffset,0]) color("red") Spacer(1,Thickness,Screw);
	translate([TSScrewHOffset,0,0]) color("plum")	Spacer(1,Thickness,Screw);
}

//////////////////////////////////////////////////////////////////////////////////////

module PiTouchscreenBracket(Qty=1,MountHoles=1,p_depth,p_height,m_depth,Angle=30,Show=0) {
	for(x = [0 : Qty-1]) {
		translate([0,x*35,0]) {
			translate([-1,0,0]) BracketPI(p_height,MountHoles);
			translate([-5,-3,0]) rotate([0,0,Angle]) {
				translate([-56,-20,-2]) Sample2020(Show);
				translate([5,0,0]) PITab(p_depth,p_height,m_depth+3,5);
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module BracketPI(p_height,MntHoles=1) {	// 1st arg: depth, 2nd arg: height
	difference() {
		color("lightgray") cubeX([p_height+Clearance+BracketThickness*2+5,5,20],2);
		if(MntHoles) {
			translate([25,3,10]) rotate([90,90,0]) TSMountScrews(screw3);
			translate([3.5,0,54.5]) rotate([90,90,0]) MountCSHoles();
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

module Sample2020(Show=0) {
	if(Show) %import("100mm_Beam.stl");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module thetab(p_de,p_he,m_de,Thickness=BracketThickness) {
	difference() {
		translate([-m_de+4,0,0]) color("blue") cubeX([m_de,Thickness,p_de],2);
		translate([-m_de+12,10,7]) rotate([90,0,0]) color("white") cylinder(h=Thickness*2,d=screw5);
		translate([-m_de+12,10,p_de-7]) rotate([90,0,0]) color("gold") cylinder(h=Thickness*2,d=screw5);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module PITab(p_de,p_he,m_de,Thickness=BracketThickness) {
	difference() {
		translate([-m_de+4,0,0]) color("blue") cubeX([m_de,Thickness,20],2);
		translate([-m_de+12,10,10]) rotate([90,0,0]) color("white") cylinder(h=Thickness*2,d=screw5);
		translate([-m_de+12,9,10]) rotate([90,0,0]) color("gold") cylinder(h=5,d=screw5hd);
	}
	difference() {
		translate([-41,-20.5]) color("pink") cubeX([Thickness,25,20],2);
		translate([-45,-10,10]) rotate([0,90,0]) color("black") cylinder(h=Thickness*3,d=screw5);
		translate([-36,-10,10]) rotate([0,90,0]) color("white") cylinder(h=5,d=screw5hd);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module MountCSHoles(Screw=screw3hd) {
	translate([TSScrewLeftOffset+TSSScreenLeftOffset,TSScrewTopOffset,-1]) color("cyan") cylinder(h=5,d=Screw+0.5);
	translate([TSScrewLeftOffset+TSSScreenLeftOffset,TSScrewTopOffset+TSScrewVOffset,-1]) color("red") cylinder(h=5,d=Screw+0.5);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PI7Touchscreen(Test=0) {
	PIScreenBase(Test,TSDepth-TSScreenThickness+TSScreenThickness);
	difference() {
		Frame(TSDepth+TSScreenThickness,Test);
		translate([-2,-2,TSDepth-TSScreenThickness]) Screen(TSScreenThickness);
	}
	translate([TSScrewLeftOffset,TSScrewTopOffset,0]) ScreenSpacer(TSSpacerDepth-TSScreenThickness);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Screen(Thickness=TSScreenThickness,Test=0) {
	if(!Test) {
		difference() {
			color("pink") cube([TSWidth,TSLength,Thickness]);
			translate([0,0,-4]) ScreenCorner(Thickness);
			translate([0,TSLength,-4]) rotate([0,0,-90]) ScreenCorner(Thickness);
			translate([TSWidth,0,-4]) rotate([0,0,90]) ScreenCorner(Thickness);
			translate([TSWidth,TSLength,-4]) rotate([0,0,180]) ScreenCorner(Thickness);
		}
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PIScreenBase(Test=0,Depth=TSSpacerDepth-TSScreenThickness) {
	difference() {
		translate([-2,-2,0]) color("cyan") cubeX([TSWidth,TSLength,ScreenBaseThickness],1);
		if(Test) { // shorten print time for testing
			translate([45,TSLength/2-60,-5]) color("khaki") cubeX([100,200,15],2);
		} else {
			translate([120,TSLength/4,-5]) color("khaki") cubeX([TSLength/4,50,15],2);
		}
		translate([TSScrewLeftOffset,TSScrewTopOffset,0]) TSMountScrews();
	}
	if(Test) {
		translate([15,75,3]) printchar("Top Left",5);
		translate([150,75,3]) printchar("Top Right",5);
	} else {
		translate([152,55,3]) printchar("To PI",5);
		translate([120,20,3]) printchar("Power",5);
	}
	ScreenDepthStop(Depth);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScreenDepthStop(Depth=TSSpacerDepth-TSScreenThickness) {
	//echo(TSDepth-TSScreenThickness);
	difference() {
		union() {
			translate([-3,-2,0]) color("red") cubeX([6,8,Depth],1); // bottom left
			translate([TSWidth-7,-1.9,0]) color("plum") cubeX([6,8,Depth],1); // bottom right
			translate([TSWidth-7,TSLength-10,0])  color("blue") cubeX([6,8,Depth],1); // top right
			translate([-3,TSLength-10,0])color("black") cubeX([6,8,Depth],1); // top left
		}
		translate([-2,-2,TSDepth-TSScreenThickness]) Screen(TSScreenThickness);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Spacer(Qty=1,Thickness=TSDepth,Screw=screw3) {
	for(x = [0:Qty-1]) {
		translate([0,x*15,0]) difference() {
			color("cyan") hull() {
				cylinder(h=1,d=screw3*3);
				translate([0,0,Thickness]) cylinder(h=1,d=Screw*2);
			}
			translate([0,0,-2]) color("plum") cylinder(h=Thickness+5,d=Screw);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScreenCorner(Thickness=10) {
	difference() {
		translate([-1,-1,0]) color("blue") cube([TSCornerRadius+2,TSCornerRadius+2,Thickness+10]);
		translate([TSCornerRadius/2,TSCornerRadius/2,-2]) color("red") cylinder(h=Thickness+15,d=TSCornerRadius);
		translate([-TSCornerRadius/2,TSCornerRadius/2,-2]) color("black") cube([TSCornerRadius*2,TSCornerRadius,Thickness+15]);
		translate([TSCornerRadius/2,-TSCornerRadius/2,-2]) color("black") cube([TSCornerRadius*2,TSCornerRadius,Thickness+15]);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module Frame(Depth=TSDepth,Test=0) {
	if(!Test) {
		translate([-3,-2,0]) color("blue") cubeX([TSWidth+2,3,Depth-TSScreenThickness],1);
		translate([-3,TSLength-5,0]) color("red") cubeX([TSWidth+2,3,Depth-TSScreenThickness],1);
		translate([-3,-2,0])color("black") cubeX([3,TSLength,Depth-TSScreenThickness],1);
		translate([TSWidth-3,-2,0]) color("gray") cubeX([3,TSLength,Depth-TSScreenThickness],1);
	}
	if(Test==1) {
		translate([-2,0,0]) color("black") cubeX([3,TSLength-3,Depth-TSScreenThickness],1);
	}
	if(Test==2) {
		translate([-3,-2,0]) color("blue") cubeX([TSWidth+2,3,Depth-TSScreenThickness],1);
	}
	if(Test==3) {
		translate([-3,TSLength-5,0]) color("red") cubeX([TSWidth+2,3,Depth-TSScreenThickness],1);
	}
	if(Test==4) {
		translate([TSWidth-3,-2,0]) color("gray") cubeX([3,TSLength,Depth-TSScreenThickness],1);
	}

}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module TSCoverMountHolesCS() {
	TSMountScrews(screw3hd);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

module printchar(String,Size=3.5) { // print something
	color("darkgray") linear_extrude(height = 1) text(String, font = "Liberation Sans",size=Size);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

