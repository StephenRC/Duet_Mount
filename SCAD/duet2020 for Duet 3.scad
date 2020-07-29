//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// duet2020 Duet 3.scad - mount a duet 3 to 2020 extrusion and a case for the 7" pi touchscreen w/mounting
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 4/5/2020
// last update 7/23/20
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 4/5/20	- Duet3 platform, don't have a Duet 3 at this time, so PORTCOVER HAS NOT BEEN TESTED
// 4/7/20	- Added ability to use 3mm brass inserts, renamed variables
// 5/7/20	- Started to add a pi4 mount for the Duet3
// 5/8/20	- May need to adjust pi4 mount position
// 6/5/20	- Now have a Duet 3 6HC and a PI 4, added a built in brim for the spacers
// 6/20/20	- Added a case for the Official Raspberry PI 7" Touchscreen
// 6/21/20	- Added an access door to the back of the pi screen case and added the mounts to the access cover
// 6/25/20	- Mounting brackets on access cover can be removed
// 6/28/20	- Added a blower mount for a 4010
// 7/23/20	- Move PI4 farther from the duet 3 to be able to access the hdmi connectors
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//***********************************************************
// May need to move cooling fan mount on platform
// Need to add 3HC, 1LC and the tool distribution board 
//***********************************************************
// Demensions from:
// Duet 3 6HC: https://duet3d.dozuki.com/Wiki/Mounting_and_cooling_the_board
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tap the board screw holes with a 3mm tap, unless you're using brass inserts
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NOTES: No room to connect the pi's hdmi
//		  The mounting holes on the PI 4 can be drilled out to 3mm with no problems
//		  The mounting screws holding the pi screen access cover also hold the touchscreen, make sure they are not too long
//		  The touchscreen mounts using the same mount at the pi board does
//		  Touchscreen case uses M3x25mm to mount with the access cover mount
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// includes
include <inc/screwsizes.scad>
use <inc/cubeX.scad> // http://www.thingiverse.com/thing:112008
Use3mmInsert=1;
Use4mmInsert=0;
include <brassfunctions.scad>
use <piscreenmount.scad>
$fn=50;		// 100 takes a long, long time to render
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// vars
////////////////////////////////////////////////////////////////////////////////////////////////////////////
SpacerThickness=5; //spacer thickness
PlatformThickness = 5; // thickness of platform
MountThickness = 5; // thickness of mount
SupportThickness = 5; // thickness of supports
PCSpacerThickness = 5; // thickness of the pc board spacers
PortCoverHeight = 20;	// height of mount
FanMountOffset = 32; // 32 for 40mm fan
FanPlatformMountOffset = 32; // 32 for 40mm fan
NozzleDiameter = 0.4;	// hotend nozzle size for wifi antenna protection support
LayerThickness = 0.3;	// layer thickness of print
D3Width = 134;		// Duet 3 width
D3Length=140;		// Duet 3 length
D3HoleOffset=4.3;	// Duet 3 corner hole offset
//------------------------------------------------------------------------------------------------------------
PIWidth=20;			// PI width
PIHeight=10;		// PI heigth
pi4width=56;
pi4length=85;
pi4rail=15;
pi4s1off=3.5;
pi4s2off=pi4s1off+58;
pi4s4off=pi4s2off;
pi4VOffset=49;
// Variables for the Raspberry PI 7" Touchscreen are above PI7Touchscreen()
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//Duet3_6HC(D3Width,D3Length,D3HoleOffset,SpacerThickness,0,1,1,0,1,1); // arg 1=width, arg2=length,arg3=holeoffset of 2020,
// room to use hmdi connections									// arg4=spacer thickness, arg5=enable portcover
																// arg6=blower adapter, arg7=move 2020 holes up/down
																// arg8=makerslide alignment tab
																// arg9=PI mount : 0-none; 1-attached, 2=seperate
Duet3_6HCClosePi(D3Width,D3Length,D3HoleOffset,SpacerThickness,0,1,1,0,1,1); // arg 1=width, arg2=length,arg3=holeoffset of 2020,
// no room to use hdmi connections								// arg4=spacer thickness, arg5=enable portcover
																// arg6=blower adapter, arg7=move 2020 holes up/down
																// arg8=makerslide alignment tab
																// arg9=PI mount : 0-none; 1-attached, 2=seperate
//PI7Touchscreen(0);  // 0: full case; 1-4: test print with one of the walls
//PI7TouchscreenV2(0);  // has corner edges around screen
//PICaseAccessCover(0);
//TestFitScreenParts();
//translate([21,12,-3])	PICaseAccessCover(0); // to test fit
//translate([171,97,-3]) rotate([0,0,180]) PICaseAccessCover(0); // to test fit
//Blower4010();

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_6HCClosePi(Width,Length,HoleOffset,Thickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,MSTab,PI=0)
{
	platform3(Width,Length,HoleOffset);
	mount3(Width,Length,Offset2020,MSTab);
	difference() {
		supports3(Width,Length,HoleOffset);
		PlatformScrewMounts(Yes3mmInsert(),Width,Length,HoleOffset);
	}
	if(PI==1) {
		//%translate([138,51,-12])cube([5,89.2,5]); // measure for the 26 pin connector location
		translate([145,45.8,0]) rotate([0,0,0]) pi4_mount();
		translate([135,45.8,0]) pi4CloseAttachment();
	}
	if(Blower) translate([230,-5,0]) rotate([0,0,90]) Blower4010();  //blower_adapter(20,15,48,1);
	if(Blower2) translate([185,-5,0]) rotate([0,0,90]) Blower4010(); //blower_adapter2(20,15,48,1);
	translate([20,30,0]) spacer2(8,Thickness,screw3);//,20,30,0); // put them in one of the vent holes
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4CloseAttachment() {
	color("green") cubeX([14.5,pi4rail,MountThickness],2);
	translate([0,70,0]) color("plum") cubeX([14.5,pi4rail,MountThickness],2); // vertical
	translate([0,38,0]) color("purple") cubeX([14.5,MountThickness,MountThickness],2);
	translate([-3,4.5,0]) color("white") cubeX([14,MountThickness,13.5],2);
	translate([-3,38,0]) color("gray") cubeX([14,MountThickness,13.5],2);
	translate([-3,75,0]) color("khaki") cubeX([14,MountThickness,13.5],2);
}

//////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_6HC(Width,Length,HoleOffset,Thickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,MSTab,PI=0)
{
	platform3(Width,Length,HoleOffset);
	mount3(Width,Length,Offset2020,MSTab);
	difference() {
		supports3(Width,Length,HoleOffset);
		PlatformScrewMounts(Yes3mmInsert(),Width,Length,HoleOffset);
	}
	if(PI==1) {
		//%translate([138,51,-12])cube([5,89.2,5]); // measure for the 26 pin connector location
		translate([195,45.8,0]) rotate([0,0,0]) pi4_mount();
		translate([135,45.8,0]) pi4Attachment();
	}
	if(Blower) translate([230,-5,0]) rotate([0,0,90]) Blower4010();
	if(Blower2) translate([185,-5,0]) rotate([0,0,90]) Blower4010();
	translate([20,30,0]) spacer2(8,Thickness,screw3);//,20,30,0); // put them in one of the vent holes
}

///////////////////////////////////////////////////////////////////////////////////////////////////

module pi4Attachment() { // move out from duet
	color("green") cubeX([65,pi4rail,MountThickness],2);
	translate([0,70,0]) color("plum") cubeX([65,pi4rail,MountThickness],2); // vertical
	translate([0,33,0]) color("purple") cubeX([65,pi4rail,MountThickness],2);
	translate([-3,4.5,0]) color("white") cubeX([64,MountThickness,13.5],2);
	translate([-3,38,0]) color("gray") cubeX([64,MountThickness,13.5],2);
	translate([-3,75,0]) color("khaki") cubeX([64,MountThickness,13.5],2);
	translate([0,2,0]) color("lightgray") rotate([0,0,27]) cubeX([75,5,MountThickness],2);
	translate([0,77,0]) color("cyan") rotate([0,0,-29]) cubeX([75,5,MountThickness],2);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module TestFitScreenParts() {
	translate([21,12,-3])	PICaseAccessCover(0); // to test fit
	translate([171,97,-3]) rotate([0,0,180]) PICaseAccessCover(0); // to test fit
}

///////////////////////////////////////////////////////////////////////////////////////////////

module ms_tab(Width) {
	color("Navy") cube([Width,6,2]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanmountside(Screw=Yes3mmInsert()) { // on side of platform
	color("white") cylinder(h=GetHoleLen3mm(),d=Yes3mmInsert());
	translate([0,FanPlatformMountOffset,0]) color("red") cylinder(h=GetHoleLen3mm(),d=Yes3mmInsert());
}

////////////////////////////////////////////////////////////////////////
module fanmountplatform(Screw=Yes3mmInsert()) {
	cylinder(h=GetHoleLen3mm(),d=Screw);
	translate([FanPlatformMountOffset,0,0]) cylinder(h=GetHoleLen3mm(),d=Screw);
}

///////////////////////////////////////////////////////////////////////

module spacer2(Quanity=1,Thickness,Screw=screw3,) { // spacer to move pc board off platform, use translate() when you call it
	for(a=[0:Quanity-1]) {
		difference() {
			translate([0,a*10,0]) color("gray") cylinder(h=Thickness,d = screw3*2);
			translate([0,a*10,-1]) color("white") cylinder(h=Thickness*2,d = screw3);
		}
		difference() {
			translate([screw3-3.5,-(screw3-3.5)+a*10,0]) color("cyan") cylinder(h=LayerThickness,d=screw3*4);
			translate([0,a*10,-1]) color("white") cylinder(h=Thickness*2,d = screw3);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////

module platform3(Width,Length,HoleOffset) { // main platform
	%translate([0,0,-6]) cube([D3Width,D3Length,2]); // show duet location
	%translate([4,0,-1]) cube([D3Width-D3HoleOffset*2,5,7]); // check mount locations
	%translate([2,3.5,-1]) cube([5,D3Length-D3HoleOffset*2,7]);
	difference() {
		translate([-5,-7,0]) color("cyan") cubeX([Width+10,Length+MountThickness+7,PlatformThickness],2);
		PlatformScrewMounts(Yes3mmInsert(),Width,Length,HoleOffset);
		vents3();
		translate([0,GetHoleLen3mm(Yes3mmInsert())-4,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert());
		translate([45,GetHoleLen3mm(Yes3mmInsert())-4,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert());
		translate([100,5,PlatformThickness/2]) fanmountside(Screw=Yes3mmInsert());
		translate([60,5,PlatformThickness/2]) fanmountside(Screw=Yes3mmInsert());
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanmountside(Screw=Yes3mmInsert()) { // on side of platform
	rotate([90,0,0]) color("white") cylinder(h=GetHoleLen3mm(),d=Yes3mmInsert());
	translate([FanPlatformMountOffset,0,0]) rotate([90,0,0]) color("red") cylinder(h=GetHoleLen3mm(),d=Yes3mmInsert());
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PlatformScrewMounts(Screw=Yes3mmInsert(),Width,Length,HoleOffset) {
	translate([HoleOffset,HoleOffset-1,-1]) color("red") cylinder(h=PlatformThickness*2,d=Screw);
	translate([Width-HoleOffset,HoleOffset-1,-1]) color("black") cylinder(h=PlatformThickness*2,d=Screw);
	translate([Width-HoleOffset,Length-HoleOffset-0.5,-1]) color("blue") cylinder(h=PlatformThickness*2,d=Screw);
	translate([HoleOffset,Length-HoleOffset-0.5,-1]) color("gray") cylinder(h=PlatformThickness*2,d=Screw);
}

///////////////////////////////////////////////////////////////////////

module mount4() { // 2020 mount
	difference() {
		translate([0,DueX4length,0]) color("cyan") cubeX([DueX4Width,MountThickness,PortCoverHeight],2);
		translate([15,DueX4length+7,10]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
		translate([DueX4Width-15,DueX4length+7,10]) rotate([90,0,0]) color("black") cylinder(h=MountThickness*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////

module vents3(over) { // vent holes in platform (over not used)
	color("red") hull() {
		translate([D3Width/3-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([D3Width/3-22,D3Length-30,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
	}
	color("white") hull() {
		translate([2*(D3Width/3)-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([2*(D3Width/3)-22,D3Length-30,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
	}
	color("blue") hull() {
		translate([3*(D3Width/3)-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([3*(D3Width/3)-22,D3Length-30,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
}
}

///////////////////////////////////////////////////////////////////////


module mount3(Width,Length,HoleOffset,MSTab=0) { // 2020 mount
	difference() {
		translate([-5,Length,0]) color("gray") cubeX([Width+10,MountThickness,PortCoverHeight+8],2);
		Holes4MS(Width,Length,HoleOffset);
	}
	if(MSTab) {
		difference() {
			rotate([-90,0,0]) translate([5,-PortCoverHeight/2-3-HoleOffset,Length+MountThickness]) ms_tab(Width-10);
			translate([0,1,0]) Holes4MS(Width,Length,HoleOffset);
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

module Holes4MS(Width,Length,HoleOffset=0) {
	translate([Width/2,Length+7,10+HoleOffset]) rotate([90,0,0]) color("red") cylinder(h=MountThickness*2,r=screw5/2);
	translate([12,Length+7,10+HoleOffset]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
	translate([Width-12,Length+7,10+HoleOffset]) rotate([90,0,0]) color("blue") cylinder(h=MountThickness*2,r=screw5/2);
}

///////////////////////////////////////////////////////////////////////

module mountw(center = 1) { // 2020 mount
	difference() {
		translate([0,D3Length,0]) color("gray") cubeX([D3Width,MountThickness,PortCoverHeight+PlatformThickness],2);
		if(center) translate([D3Width/2,D3Length+7,10+PlatformThickness]) rotate([90,0,0])
			color("red") cylinder(h=MountThickness*2,r=screw5/2);
		translate([12,D3Length+7,10+PlatformThickness]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
		translate([D3Width-12,D3Length+7,10+PlatformThickness]) rotate([90,0,0]) color("blue")
			cylinder(h=MountThickness*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////

module supports3(Width,Length,HoleOffset) { // connects & support main platform
	difference() {
		translate([0.5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("pink") cubeX([SupportThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([0,GetHoleLen3mm(Yes3mmInsert())+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert());
		translate([-2,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D3Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width-SupportThickness+1.5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("red") cubeX([MountThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([Width-SupportThickness-2,3,-SupportThickness-19]) color("black")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/3-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("blue") cubeX([MountThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([0,GetHoleLen3mm(Yes3mmInsert())+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert());
		translate([Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("white")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("red") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/3+Width/3-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("purple") cubeX([MountThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([Width/3+Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("cyan")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanonsupport(NotchIt=0) {
	if(NotchIt != 2) {
		translate([3,D3Length-(D3Length/2),-5]) color("red") cylinder(h=GetHoleLen3mm(Yes3mmInsert())+5,d=Yes3mmInsert());
		translate([3,FanMountOffset+D3Length-(D3Length/2),-5])
			color("white") cylinder(h=GetHoleLen3mm(Yes3mmInsert())+5,d=Yes3mmInsert());
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanonsupportleveler(NotchIt=0) {
	if(NotchIt==0) {
		difference() {
			translate([3,D3Length-(D3Length/2),0]) color("red") cylinder(h=GetHoleLen3mm(Yes3mmInsert())-5,d=YesInsert3mm);
			translate([3,D3Length-(D3Length/2),-5]) color("blue") cylinder(h=GetHoleLen3mm(Yes3mmInsert())+5,d=YesInsert3mm);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanonsupportnotch(NotchIt=0) {
	if(NotchIt==1) {
		translate([0,D3Length-(D3Length/2)-6,10]) color("red") cube([45,45,20]);
		translate([21,D3Length-(D3Length/2)+16,0.5]) color("blue") cylinder(h=10,d1=10,d2=40);
	}
}

//////////////////////////////////////////////////////////////////////

module Cover(Width,Length) { // cover for main platform - mounts on 2020
	color("cyan") cubeX([Width+10,Length+MountThickness+35,PlatformThickness],2);
	difference() {
		color("navy") cubeX([Width+10,PlatformThickness,20+PlatformThickness],2);
		translate([20,PlatformThickness+1,10+PlatformThickness]) rotate([90,0,0]) // left
			color("skyblue") cylinder(h=MountThickness*2,r=screw5/2);
		//translate([Width/2+5,PlatformThickness+1,10+PlatformThickness]) rotate([90,0,0]) // center
		//	color("red") cylinder(h=MountThickness*2,r=screw5/2);
		translate([Width-10,PlatformThickness+1,10+PlatformThickness]) rotate([90,0,0]) // right
			color("white") cylinder(h=MountThickness*2,r=screw5/2);
	}
	
}

/////////////////////////////////////////////////////////////////////

module FlatCover(Width,Length) { // DueX4 cover
	difference() {
		color("cyan") cubeX([Width+10,Length+MountThickness+35,PlatformThickness],2);
		translate([12,Length+25,-1]) color("black") cylinder(h=MountThickness*2,r=screw5/2);
		translate([Width-5,Length+25,-1]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module mounting_base(Width,Length,HoleOffset) {
	rotate([-90,0,0]) difference() {	// mounting base, it replaces the two spacers on the i/o port end
		translate([1,-3,0]) color("purple") cubeX([Width+8,11,PCSpacerThickness]);
		translate([3.5,HoleOffset,0]) portcovermountholes(Width,HoleOffset);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////

module printchar(String,Size=3.5) { // print something
	color("darkgray") linear_extrude(height = 1) text(String, font = "Liberation Sans",size=Size);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module blower_adapter(blower_h,blower_w,blower_m_dist,Shift=0) { // to use a 50mm 10x15 blower instead of a 40mm axial
	difference() {
		color("cyan") cubeX([FanMountOffset+10,blower_w+10.5+Shift,PlatformThickness+1]);
		translate([blower_h/2,PlatformThickness+Shift,-2]) color("white") cube([blower_h,blower_w,10]);
		BlowerAdapterScrew();
	}
	difference() {
		translate([21,Shift-1.5,0]) color("black") cubeX([screw4+4,screw4+1,blower_m_dist+screw4+1],2);
		translate([screw4/2+23,screw4+blower_w+6+Shift,blower_m_dist]) rotate([90,0,0]) {
			if(Use4mmInsert) {
				color("white") cylinder(h=30,d=Yes4mmInsert());
			} else {
				color("white") cylinder(h=30,d=screw4);
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module blower_adapter2(blower_h,blower_w,blower_m_dist,Shift=0) { // to use a 50mm 10x15 blower instead of a 40mm axial
	difference() {
		color("cyan") cubeX([FanMountOffset+10,blower_w+10.5+Shift,PlatformThickness+1]);
		translate([blower_h/2,PlatformThickness+Shift,-2]) color("white") cube([blower_h,blower_w,10]);
		translate([0,20,0]) BlowerAdapterScrew();
	}
	difference() {
		translate([10,Shift+20,0]) color("black") cubeX([screw4+4,screw4+1,blower_m_dist+screw4+1],2);
		translate([screw4/2+12,screw4+blower_w+10+Shift,blower_m_dist]) rotate([90,0,0]) {
			if(Use4mmInsert) {
				color("white") cylinder(h=30,d=Yes4mmInsert());
			} else {
				color("white") cylinder(h=30,d=screw4);
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module BlowerAdapterScrew() {
	translate([5,2.5,-2]) color("black") cylinder(h=PlatformThickness*2,d=screw3);
	translate([FanPlatformMountOffset+5,2.5,-2]) color("red") cylinder(h=PlatformThickness*2,d=screw3);
	translate([5,2.5,3]) color("blue") cylinder(h=PlatformThickness*2,r=screw3hd/2);
	translate([FanPlatformMountOffset+5,2.5,3]) color("gray") cylinder(h=PlatformThickness*2,d=screw3hd);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4_mount() {
	difference() {
		pi4_base();
		translate([3,0,0]) Pi4MountHoles(Screw=Yes3mmInsert());
	}
	difference() {
		pi4_support();
		translate([3,0,0]) Pi4MountHoles(Screw=Yes3mmInsert());
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4MountHoles(Screw=Yes3mmInsert()) {
	translate([pi4s1off,pi4s1off,-1]) color("white") cylinder(h=GetHoleLen3mm(Yes3mmInsert()),d=Yes3mmInsert());
	translate([pi4s1off,pi4s2off,-1]) color("black") cylinder(h=GetHoleLen3mm(Yes3mmInsert()),d=Yes3mmInsert());
	translate([pi4s1off+pi4VOffset,pi4s1off,-1]) color("gray") cylinder(h=GetHoleLen3mm(Yes3mmInsert()),d=Yes3mmInsert());
	translate([pi4s1off+pi4VOffset,pi4s4off,-1]) color("red") cylinder(h=GetHoleLen3mm(Yes3mmInsert()),d=Yes3mmInsert());
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4_base() {
	%translate([3,0,-6]) cube([pi4width,pi4length,2]); // show pi location
	color("cyan") cubeX([pi4width+4,pi4rail,MountThickness],2);
	translate([0,pi4length-pi4rail,0]) color("blue") cubeX([pi4width,pi4rail,MountThickness],2);
	color("yellow") cubeX([pi4rail,pi4length,MountThickness],2);
	translate([pi4width+4-pi4rail,0,0]) color("purple") cubeX([pi4rail,pi4length,MountThickness],2);
	// crossmembers
	translate([pi4rail-6,0,0]) color("pink") rotate([0,0,60]) cubeX([pi4width+33,pi4rail/3,MountThickness],2);
	translate([6,pi4length-pi4rail+7,0]) color("lightgray") rotate([0,0,-60]) cubeX([pi4width+33,pi4rail/3,MountThickness],2);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4_support() {
	translate([-9,4.5,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("pink") cubeX([pi4width+3,MountThickness,20],2);
		translate([0,-2.5,-18]) color("salmon") cube([pi4width+10,MountThickness+5,20]);
	}
	translate([-9,75,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("pink") cubeX([pi4width+3,MountThickness,20],2);
		translate([0,-2.5,-18]) color("salmon") cube([pi4width+10,MountThickness+5,20]);
	}
	translate([-9,38,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("red") cubeX([pi4width+3,MountThickness,20],2);
		translate([0,-2.5,-18]) color("salmon") cube([pi4width+10,MountThickness+5,20]);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------------------
// From: https://www.raspberrypi.org/documentation/hardware/display/  Scroll to bottom for the drawing
//-----------------------------------------------------------------------------------------------------------------
TSScreenNutBump=2.5;
TSScreenThicknessFull=5.96+TSScreenNutBump;
TSScreenThickness=1.5;
TSScreenStiffner=1.4;
TSSScreenLeftOffset=11.8;
TSSScreenRigthOffset=15.1;
TSWidth=194;
TSLength=112;
TSCornerRadius=7.86;
TSPIScrewLeftOffset=48.45+12.54;
TSScrewHOffset=126.2;
TSScrewVOffset=65.65;
TSScrew1=0;
TSScrew2=TSScrew1+TSScrewVOffset;
TSScrew3=0;
TSScrew4=TSScrew3+TSScrewHOffset;
AdjustY=1; // fine tune the screen mounting
AdjustX=2; // fine tune the screen mounting
TSScrewTopOffset=21.58+AdjustY; // 100.6-TSScrewVOffset-21.58;
TSScrewLeftOffset=20+12.54+AdjustX; // 166.2-TSScrewHOffset-(20+6.663);
//-------------------------------------------------------------------------------------------------------------------
TSDepth=28;
ScreenBaseThickness=3;

module PI7Touchscreen(Test=0) {
	PIScreenBase(Test);
	Frame(TSDepth,Test);
	translate([TSScrewLeftOffset,TSScrewTopOffset,0])
		ScreenSpacer(TSDepth-TSScreenThicknessFull-ScreenBaseThickness);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PI7TouchscreenV2(Test=0) {
	PIScreenBaseV2(Test,TSDepth-TSScreenThickness+TSScreenThickness);
	difference() {
		Frame(TSDepth+TSScreenThickness,Test);
		translate([-2,-2,TSDepth-TSScreenThickness]) Screen(TSScreenThickness);
	}
	translate([TSScrewLeftOffset,TSScrewTopOffset,0])
		ScreenSpacer(TSDepth-TSScreenThicknessFull-ScreenBaseThickness+TSScreenThickness);
	//echo(TSDepth-TSScreenThicknessFull-ScreenBaseThickness+TSScreenThickness);
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

	//	translate([-2,-2,TSDepth-TSScreenThickness]) Screen(TSScreenThickness);
	//}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PIScreenBase(Test=0) {
	difference() {
		translate([-2,-2,0]) color("cyan") cubeX([TSWidth,TSLength,ScreenBaseThickness],1);
		if(Test) { // shorten print time for testing
			translate([45,TSLength/2-60,-5]) color("khaki") cubeX([100,200,15],2);
		} else {
			translate([40,TSLength/2-25,-5]) color("khaki") cubeX([110,50,15],2);
		}
		translate([TSScrewLeftOffset,TSScrewTopOffset,0]) TSMountScrews();
	}
	if(Test) {
		translate([15,75,3]) printchar("Top Left",5);
		translate([150,75,3]) printchar("Top Right",5);
	} else {
		translate([152,55,3]) printchar("Screen to PI",5);
		translate([120,20,3]) printchar("Power",5);
	}
	ScreenDepthStop();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PIScreenBaseV2(Test=0,Depth=TSDepth-TSScreenThickness) {
	difference() {
		translate([-2,-2,0]) color("cyan") cubeX([TSWidth,TSLength,ScreenBaseThickness],1);
		if(Test) { // shorten print time for testing
			translate([45,TSLength/2-60,-5]) color("khaki") cubeX([100,200,15],2);
		} else {
			translate([40,TSLength/2-25,-5]) color("khaki") cubeX([110,50,15],2);
		}
		translate([TSScrewLeftOffset,TSScrewTopOffset,0]) TSMountScrews();
	}
	if(Test) {
		translate([15,75,3]) printchar("Top Left",5);
		translate([150,75,3]) printchar("Top Right",5);
	} else {
		translate([152,55,3]) printchar("Screen to PI",5);
		translate([120,20,3]) printchar("Power",5);
	}
	ScreenDepthStop(Depth);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScreenDepthStop(Depth=TSDepth-TSScreenThickness) {
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module TSMountScrews(Screw=Yes3mmInsert()) {
	translate([TSScrew1,TSScrew1,-5]) color("blue") cylinder(h=15,d=Screw);
	translate([TSScrew1,TSScrew2,-5]) color("purple") cylinder(h=15,d=Screw);
	translate([TSScrew1+TSScrewHOffset,TSScrew2,-5]) color("red") cylinder(h=15,d=Screw);
	translate([TSScrew1+TSScrewHOffset,TSScrew1,-5]) color("plum")	cylinder(h=15,d=Screw);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScreenSpacer(Thickness=TSDepth,Screw=screw3) {
	//echo(Thickness);
	translate([TSScrew1,TSScrew1,0]) color("blue") Spacer(1,Thickness,Screw);
	translate([TSScrew1,TSScrew2,0]) color("purple") Spacer(1,Thickness,Screw);
	translate([TSScrew1+TSScrewHOffset,TSScrew2,0]) color("red") Spacer(1,Thickness,Screw);
	translate([TSScrew1+TSScrewHOffset,TSScrew1,0]) color("plum")	Spacer(1,Thickness,Screw);
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

module PICaseAccessCover(Mounting=0) {
	difference() {
		union() {
			color("cyan") cubeX([146,85,3],1);
			if(Mounting==0) {
				translate([20,-15,5]) rotate([270,0,90]) PITabbedBracket(0,30,80,60,0);
				translate([145.9,-15,5]) rotate([270,0,90]) PITabbedBracket(0,30,80,60,0);
			}
		}
		translate([TSScrewLeftOffset-20.5,TSScrewTopOffset-12,0]) {
		translate([-2.5,0,0]) TSMountScrews(screw3);
		translate([-2.5,0,8]) TSCoverMountHolesCS();
		translate([100,18,-5]) color("black") cubeX([10,30,10],2);
		}
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////

module Blower4010() {
	difference() {
		color("cyan") cubeX([46,40,3],1);
		translate([6,0,0]) 4010MountHoles();
		translate([0,4,0]) 4010MountToDuet();
	}
	difference() {
		translate([0,0,0]) color("pink") cubeX([6,40,15],1);
		translate([-1,5.5,3]) color("gray") cubeX([10,30,10],1);
		translate([0,4,0]) 4010MountToDuet();
	}
	//translate([20,20,3]) ShowBlower4010();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
4040MountOffset=34.9;

module 4010MountHoles() {
	translate([2.5,2.5,-2]) color("red") cylinder(h=10,d=screw2t);
	translate([2.5+4040MountOffset,2.5,-2]) color("blue") cylinder(h=10,d=screw2t);
	translate([2.5,2.5+4040MountOffset,-2]) color("plum") cylinder(h=10,d=screw2t);
	translate([2.5+4040MountOffset,2.5+4040MountOffset,-2]) color("black") cylinder(h=10,d=screw2t);
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module 4010MountToDuet() {
	translate([-1,0,3]) color("white") rotate([0,90,0]) cylinder(h=15,d=screw3);
	translate([-1,FanMountOffset,3]) color("lightgray") rotate([0,90,0]) cylinder(h=15,d=screw3);
	translate([3,0,3]) color("blue") rotate([0,90,0]) cylinder(h=15,d=screw3hd);
	translate([3,FanMountOffset,3]) color("purple") rotate([0,90,0]) cylinder(h=15,d=screw3hd);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ShowBlower4010() {
	%import("4010_Blower_Fan_v2.stl"); // http://www.thingiverse.com/thing:1576438
}

//////////////////// end of duet2020.scad ////////////////////////////////////////////////////////////
