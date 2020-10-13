//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Duet 3.scad - mount a duet 3 to 2020 extrusion and a case for the 7" pi touchscreen w/mounting
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 4/5/2020
// last update 9/13/20
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
// 8/15/20	- Added the Tool Board 1LC
// 8/18/20	- Added covers for the Due3 6HC and Pi4 boards, changed spacers to cone shape
//			  Touchscreen parts moved to PIScreen.scad
// 9/8/20	- Added tool distrubution board
// 9/13/20	- Can set mount of Pi4 and Tool Distrubution Board to be on the long or short side
// 9/19/20	- Thinned down crossmembers for Pi mount
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//***********************************************************
// May need to move cooling fan mount on platform
// Need to add 3HC and the tool distribution board 
//***********************************************************
// Demensions from:
// Duet 3 6HC: https://duet3d.dozuki.com/Wiki/Mounting_and_cooling_the_board
// Duet 3 1LC: https://duet3d.dozuki.com/Wiki/Duet_3_Tool_Board
// Tool Dristribution Board: https://duet3d.dozuki.com/Wiki/Tool_Distribution_Board
// Rasberry PI: https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/README.md
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tap the Duet 3 section screw holes with a 3mm tap, unless you're using brass inserts
// Tap Pi4 for 2.5mm, unless you're using brass inserts
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NOTES: No room to connect the pi's hdmi
//		  The mounting holes on the PI 4 can be drilled out to 3mm with no problems
//******************************
// Ribbon cable must between the duet 3 6hc and the pi. No overlap with the pi or duet, it will cause wierd problems
// over the duet, partially conver the duet: starts print, then stops
//*********************************
// PI Touchscreen has to be supplied it's own 5vdc power. Powering via the dotstar connector gives low pi voltage warning.
// Duet uses M3 screws and the Pi uses M2.5 screws
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// includes
include <inc/screwsizes.scad>
use <inc/cubeX.scad> // http://www.thingiverse.com/thing:112008
include <brassinserts.scad>
$fn=50;		// 100 takes a long, long time to render
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// vars
////////////////////////////////////////////////////////////////////////////////////////////////////////////
Use2p5mmInsert=1;
Use3mmInsert=1;
Use4mmInsert=0;
LargeBrassInsert=1;
PlatformThickness=5;	// thickness of platform
MountThickness=5;		// thickness of mount
CoverThickness=3;		// thickness of the covers
SupportThickness=5;		// thickness of supports
PCSpacerThickness=PlatformThickness; // thickness of the pc board spacers
PortCoverHeight=20;		// height of mount
FanMountOffset=32;		// 32 for 40mm fan
FanPlatformMountOffset=32; // 32 for 40mm fan
Spacing=17; 			// ir sensor bracket mount hole spacing
NozzleDiameter=0.4;		// hotend nozzle size for wifi antenna protection support
LayerThickness=0.3;		// layer thickness of print
//----------------------------------------------------------------------------------------------------------
D3Width = 134;		// width
D3Length=140;		// length
D3HoleOffset=4.3;	// corner hole offset
//------------------------------------------------------------------------------------------------------------
Pi4Width=56;		// width
Pi4Length=85;		// length
Pi4BracketWidth=15; // width of the bracket sides
pi4Offset=3.5;		// offset of the holes from the side of the pc board
pi4VOffset=49;		// vertical hole offset
pi4HOffset=58;		// horizontal hole offset
//-----------------------------------------------------------------------------------------------------------
1LCWidth=47;			// width
1LCLength=54;			// length
1LCHoleVOffset=34;		// vertical hole offset
1LCHoleHOffset=34;	// horizontal hole offset
1LCBracketWidth=Pi4BracketWidth; // width of the bracket sides
// tool distribution board
TDBHoleVOffset=38;		// hole vertical offset
TDBHoleHOffset=63;		// hole horizontal offset
TDBHoleBOffset=3.2;		// hole offset from board edge
TDBWidth=45;			// board width
TDBLength=70;			// board length
TDBBracketWidth=Pi4BracketWidth;
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//Duet3_6HCPi4(D3Width,D3Length,D3HoleOffset,PCSpacerThickness,0,0,0,0,0,1);  // don't use ExtTab if using post contruction nuts
//		args: Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab=0,PI=0
//Duet3_6HCCover(D3Width,D3Length);
Pi4Cover(0);
//translate([145,0,0])		// move over if you set the above to not have the pi mount builtin
//	Pi4StandAlone(0);		// a separate mount for just the pi4; args: ShortEnd=0,Screw=Yes2p5mmInsert(),DoSpacers=0,ShowPi=0
//Blower4010();
//ToolBoard1LC();
//ToolDistibutionBoard(0);	// ShortEnd=0,Spacers=1

///////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoard(ShortEnd=0,Spacers=1) { // this mounts to the Single-Titan-E3DV6.scad extruder
	difference() {
		ToolDistibutionBoard_base();
		translate([TDBHoleBOffset,TDBHoleBOffset+MountThickness,0])
			ToolDistibutionBoardMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
	}
	ToolDistibutionBoardMount(ShortEnd);
	ToolDistibutionBoardSupport(ShortEnd);
	if(Spacers) translate([-8,8,0]) Spacer(4,MountThickness,screw3);;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoard_base() {
	union() {
		color("cyan") cubeX([TDBWidth,TDBBracketWidth,MountThickness],1);
		translate([0,TDBLength-TDBBracketWidth+MountThickness,0]) color("blue")
			cubeX([TDBWidth,TDBBracketWidth,MountThickness],1);
		color("yellow") cubeX([TDBBracketWidth+MountThickness/2,TDBLength+MountThickness,MountThickness],1);
		translate([TDBWidth-TDBBracketWidth-MountThickness/2,0,0]) color("purple")
			cubeX([TDBBracketWidth+MountThickness/2,TDBLength+MountThickness,MountThickness],1);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoardMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) {
	translate([0,0,-1]) color("white") cylinder(h=20,d=Screw);
	translate([0,TDBHoleHOffset,-1]) color("black") cylinder(h=20,d=Screw);
	translate([TDBHoleVOffset,0,-1]) color("gray") cylinder(h=20,d=Screw);
	translate([TDBHoleVOffset,TDBHoleHOffset,-1]) color("red") cylinder(h=20,d=Screw);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoardMount(ShortEnd=0,Screw=Yes2p5mmInsert(Use2p5mmInsert),ShowPi=0) {
	if(ShortEnd) {
		difference() {
			color("red") cubeX([TDBWidth,MountThickness,20],1);
			translate([8,8,MountThickness+6]) color("red") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([8,MountThickness+4,MountThickness+6]) color("khaki") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
			translate([38,8,MountThickness+6]) color("white") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([38,MountThickness+4,MountThickness+6]) color("green") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
		}
	} else {
		translate([0,0,0]) difference() {
			color("red") cubeX([MountThickness,TDBLength+MountThickness,20],1);
			translate([-1,18,MountThickness+6]) {
				color("blue") rotate([0,90,0])  cylinder(h=10,d=screw5);
				translate([5,0,0]) color("khaki") rotate([0,90,0])  cylinder(h=5,d=screw5hd);
			}
			translate([-1,58,MountThickness+6]) {
				color("white") rotate([0,90,0])  cylinder(h=10,d=screw5);
				translate([5,0,0]) color("green") rotate([0,90,0])  cylinder(h=5,d=screw5hd);
			}
			translate([TDBHoleBOffset,TDBHoleBOffset+MountThickness,0])
				ToolDistibutionBoardMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		}
	}

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoardSupport(ShortEnd=0) {
	if(ShortEnd) {
		difference() {
			translate([12,0,-6]) rotate([-6,0,0]) color("white") cubeX([MountThickness,TDBLength-3,20],2);
			translate([11,-2.5,-18]) color("salmon") cube([MountThickness+5,TDBLength+5,20]);
			translate([8,MountThickness+14,MountThickness+6]) color("khaki") rotate([90,0,0])  cylinder(h=15,d=screw5hd);
		}
		difference() {
			translate([29,0,-6]) rotate([-6,0,0]) color("gray") cubeX([MountThickness,TDBLength-3,20],2);
			translate([28,0,-18]) color("gray") cube([MountThickness+3,TDBLength+5,20]);
			translate([38,MountThickness+14,MountThickness+6]) color("green") rotate([90,0,0])  cylinder(h=15,d=screw5hd);
		}
	} else {
		difference() {
			translate([-4,2,0]) rotate([0,20,0]) color("white") cubeX([TDBWidth-3,MountThickness,20],2);
			translate([-6,0,-18]) color("salmon") cube([TDBWidth+10,MountThickness+5,20]);
			translate([-6,0,0]) color("gray") cube([MountThickness+5,MountThickness+5,20]);
		}
		translate([0,62,0]) difference() {
			translate([-4,2,0]) rotate([0,20,0]) color("white") cubeX([TDBWidth-3,MountThickness,20],2);
			translate([-6,0,-18]) color("salmon") cube([TDBWidth+10,MountThickness+5,20]);
			translate([-6,0,0]) color("gray") cube([MountThickness+5,MountThickness+5,20]);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////

module ToolBoard1LC() { // this mounts to the Single-Titan-E3DV6.scad extruder
	difference() {
		1LC_base();
		translate([10,13,0]) 1LCMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([30,4,-MountThickness]) IRMountHoles(screw3);
	}
	difference() { // built in spacers
		translate([10,13,0]) Spacers1LC(2);
		translate([30,4,-MountThickness]) IRMountHoles(screw3); // make clearance for the extruder mount holes
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Spacers1LC(Extra=2,Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) { // Extra is more height
	translate([0,0,0]) Spacer(1,MountThickness+Extra,Screw); // put them in one of the vent holes
	translate([0,1LCHoleHOffset,0]) Spacer(1,MountThickness+Extra,Screw); // put them in one of the vent holes
	translate([1LCHoleVOffset,0,0]) Spacer(1,MountThickness+Extra,Screw); // put them in one of the vent holes
	translate([1LCHoleVOffset,1LCHoleHOffset,0]) Spacer(1,MountThickness+Extra,Screw); // put them in one of the vent holes
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module 1LC_base() {
	color("cyan") cubeX([1LCWidth+4,1LCBracketWidth,MountThickness],2);
	translate([0,1LCLength-Pi4BracketWidth,0]) color("blue") cubeX([1LCWidth,Pi4BracketWidth,MountThickness],2);
	color("yellow") cubeX([1LCBracketWidth,1LCLength,MountThickness],2);
	translate([1LCWidth+4-1LCBracketWidth,0,0]) color("purple") cubeX([1LCBracketWidth,1LCLength,MountThickness],2);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

module 1LCMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) {
	translate([0,0,-1]) color("white") cylinder(h=20,d=Screw);
	translate([0,1LCHoleHOffset,-1]) color("black") cylinder(h=20,d=Screw);
	translate([1LCHoleVOffset,0,-1]) color("gray") cylinder(h=20,d=Screw);
	translate([1LCHoleVOffset,1LCHoleHOffset,-1]) color("red") cylinder(h=20,d=Screw);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

module IRMountHoles(Screw=screw3) // ir screw holes for mounting to extruder plate
{
	color("red") cylinder(h=20,d=Screw);
	if(Screw==screw3) translate([0,0,MountThickness*2-2]) color("blue") cylinder(h=5,d=screw3hd);
	translate([Spacing,0,0]) color("blue") cylinder(h=20,d=Screw);
	if(Screw==screw3) translate([Spacing,0,MountThickness*2-2]) color("red") cylinder(h=5,d=screw3hd);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_6HCPi4(Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab,PI=0)
{
	Platform(Width,Length,HoleOffset);
	PlatformMount(Width,Length,Offset2020,ExtTab);
	difference() {
		Duet3Supports(Width,Length,HoleOffset);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset);
	}
	if(PI==1) {
		//%translate([138,51,-12])cube([5,89.2,5]); // measure for the 26 pin connector location
		translate([150,45.8,0]) rotate([0,0,0]) Pi4Mount();
		difference() {
			translate([135,45.8,0]) pi4CloseAttachment(0);
			translate([125,47,MountThickness-1]) color("black") cube([10,10,15]);
			translate([125,117,MountThickness-1]) color("gray") cube([10,10,15]);
		}
	}	
	if(Blower) translate([230,-5,0]) rotate([0,0,90]) Blower4010();
	if(Blower2) translate([185,-5,0]) rotate([0,0,90]) Blower4010();
	if(PI) {
		translate([20,30,0]) Spacer(4,SpacerThickness,screw3); // put them in one of the vent holes
		translate([70,30,0]) Spacer(4,SpacerThickness,screw2p5); // put them in one of the vent holes
	}
	if(!PI) translate([20,30,0]) Spacer(4,SpacerThickness,screw3); // put them in one of the vent holes
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Spacer(Qty=1,Thickness=PCSpacerThickness,Screw=screw3) {
	for(x = [0:Qty-1]) {
		translate([0,x*15,0]) difference() {
			color("cyan") hull() {
				cylinder(h=0.5,d=Screw*3);
				translate([0,0,Thickness]) cylinder(h=1,d=Screw*2);
			}
			translate([0,0,-2]) color("plum") cylinder(h=Thickness+5,d=Screw);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_6HCCover(Width,Length) {
	difference() {
		color("cyan") cubeX([Width+8,Length+8,CoverThickness],2);
		translate([4,4,-1]) PlatformScrewMounts(screw3,Width,Length);
	}
	translate([4,4,0]) Spacer(1,50,screw3);
	translate([Width+4,4,0]) Spacer(1,50,screw3);
	translate([Width+4,Length+4,0]) Spacer(1,50,screw3);
	translate([4,Length+4,0]) Spacer(1,50,screw3);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4CloseAttachment(DoMiddle=1,Show=0) {
	color("green") cubeX([19,Pi4BracketWidth-2,MountThickness],2);
	translate([0,72,0]) color("plum") cubeX([19,Pi4BracketWidth-2,MountThickness],2); // vertical
	if(DoMiddle) {
		translate([0,38,0]) color("purple") cubeX([19,MountThickness,MountThickness],2);
		translate([-3,38,0]) color("gray") cubeX([19,MountThickness,13.5],2);
	}
	translate([-3,4.5,0]) color("white") cubeX([19,MountThickness,13.5],2);
	translate([-3,75,0]) color("khaki") cubeX([19,MountThickness,13.5],2);
	if(Show) %translate([8,15.5,2]) cube([6,56,6]);  // make sure the 40pin connector will fit
}

///////////////////////////////////////////////////////////////////////////////////////////////////

module pi4Attachment() { // move out from duet
	color("green") cubeX([65,Pi4BracketWidth,MountThickness],2);
	translate([0,70,0]) color("plum") cubeX([65,Pi4BracketWidth,MountThickness],2); // vertical
	translate([0,33,0]) color("purple") cubeX([65,Pi4BracketWidth,MountThickness],2);
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

module ExtTab(Width) {
	color("Navy") cube([Width,6,2]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) { // on side of platform
	color("white") cylinder(h=20,d=Screw);
	translate([0,FanPlatformMountOffset,0]) color("red") cylinder(h=20,d=Screw);
}

////////////////////////////////////////////////////////////////////////
module fanmountplatform(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) {
	cylinder(h=20(),d=Screw);
	translate([FanPlatformMountOffset,0,0]) cylinder(h=20(),d=Screw);
}

///////////////////////////////////////////////////////////////////////////////////////

module Platform(Width,Length,HoleOffset,ShowBoards=0) { // main platform
	if(ShowBoards) {
		%translate([0,0,-6]) cube([D3Width,D3Length,2]); // show duet location
		%translate([4,0,-1]) cube([D3Width-D3HoleOffset*2,5,7]); // check mount locations
		%translate([2,3.5,-1]) cube([5,D3Length-D3HoleOffset*2,7]);
	}
	difference() {
		translate([-5,-7,0]) color("cyan") cubeX([Width+10,Length+MountThickness+7,PlatformThickness],2);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset);
		PlatformVents();
		translate([0,5,PlatformThickness/2]) fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
		translate([43,5,PlatformThickness/2]) fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
		//translate([90,5,PlatformThickness/2]) fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for cpu cooling
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) { // on side of platform
	rotate([90,0,0]) color("white") cylinder(h=20,d=Screw);
	translate([FanPlatformMountOffset,0,0]) rotate([90,0,0]) color("red") cylinder(h=20,d=Screw);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PlatformScrewMounts(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset=0) {
	translate([HoleOffset,HoleOffset,-1]) color("red") cylinder(h=PlatformThickness*4,d=Screw);
	translate([Width-HoleOffset,HoleOffset,-1]) color("black") cylinder(h=PlatformThickness*4,d=Screw);
	translate([Width-HoleOffset,Length-HoleOffset,-1]) color("blue") cylinder(h=PlatformThickness*4,d=Screw);
	translate([HoleOffset,Length-HoleOffset,-1]) color("gray") cylinder(h=PlatformThickness*4,d=Screw);
}

//////////////////////////////////////////////////////////////////////

module PlatformVents(over) { // vent holes in platform (over not used)
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


module PlatformMount(Width,Length,HoleOffset,MSTab=0) { // 2020 mount
	difference() {
		translate([-5,Length,0]) color("gray") cubeX([Width+10,MountThickness,PortCoverHeight+8],2);
		Holes4MS(Width,Length,HoleOffset);
		translate([4.25,Width+5,0]) color("red") cylinder(h=20,d=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)+1);
		translate([Width-4.25,Width+5,0]) color("blue") cylinder(h=20,d=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)+1);	
	}
	if(MSTab) {
		difference() {
			rotate([-90,0,0]) translate([5,-PortCoverHeight/2-3-HoleOffset,Length+MountThickness]) ExtTab(Width-10);
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

//////////////////////////////////////////////////////////////////////

module Duet3Supports(Width,Length,HoleOffset) { // connects & support main platform
	difference() {
		translate([-5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("pink") cubeX([SupportThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([0,20()+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([-7,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D3Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width-SupportThickness+4,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("red") cubeX([MountThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([Width-SupportThickness,3,-SupportThickness-19]) color("black")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/3-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("blue") cubeX([MountThickness,Length-10,PortCoverHeight+PlatformThickness],2);
		translate([0,20()+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
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

///////////////////////////////////////////////////////////////////////////////////////////////////

module printchar(String,Size=3.5) { // print something
	color("darkgray") linear_extrude(height = 1) text(String, font = "Liberation Sans",size=Size);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module BlowerAdapterScrew() {
	translate([5,2.5,-2]) color("black") cylinder(h=PlatformThickness*2,d=screw3);
	translate([FanPlatformMountOffset+5,2.5,-2]) color("red") cylinder(h=PlatformThickness*2,d=screw3);
	translate([5,2.5,3]) color("blue") cylinder(h=PlatformThickness*2,r=screw3hd/2);
	translate([FanPlatformMountOffset+5,2.5,3]) color("gray") cylinder(h=PlatformThickness*2,d=screw3hd);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4Mount(Screw=Yes2p5mmInsert(Use2p5mmInsert),DoMiddle=0) {
	difference() {
		Pi4Base();
		translate([3,0,0]) Pi4MountHoles(Screw);
	}
	difference() {
		pi4_support(DoMiddle);
		translate([3,0,0]) Pi4MountHoles(Screw);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4StandAlone(ShortEnd=0,Screw=Yes2p5mmInsert(Use2p5mmInsert),DoSpacers=0,ShowPi=0) {
	if(ShortEnd) echo("short end"); else echo("long end");
	difference() {
		Pi4Base(ShowPi);
		translate([2.5,3,0]) Pi4MountHoles(Screw);
	}
	difference() {
		Pi4StandAloneSupport(ShortEnd);
		translate([2.5,3,0]) Pi4MountHoles(Screw+0.6);
	}
	difference() {
		Pi4StandAloneMount(ShortEnd);
		translate([2.5,3,0]) Pi4MountHoles(Screw+0.6);
	}
	if(DoSpacers) {
		if(ShortEnd) translate([70,5,0]) Spacer(4,PCSpacerThickness,screw2p5);
		else translate([67,20,0]) Spacer(4,PCSpacerThickness,screw2p5);
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4StandAloneMount(ShortEnd=0) {
	if(ShortEnd) {
		difference() {
			color("blue") cubeX([Pi4Width+4,MountThickness,20],2);
			translate([15,8,MountThickness+8]) color("red") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([15,MountThickness*2-1,MountThickness+8]) color("khaki") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
			translate([45,8,MountThickness+8]) color("white") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([45,MountThickness*2-1,MountThickness+8]) color("green") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
		}
	} else {
		difference() {
			color("blue") cubeX([MountThickness,Pi4Length,20],2);
			translate([-2,14,MountThickness+8]) color("red") rotate([0,90,0])  cylinder(h=10,d=screw5);
			translate([3,14,MountThickness+8]) color("khaki") rotate([0,90,0])  cylinder(h=5,d=screw5hd);
			translate([-2,74,MountThickness+8]) color("white") rotate([0,90,0])  cylinder(h=10,d=screw5);
			translate([3,74,MountThickness+8]) color("green") rotate([0,90,0])  cylinder(h=5,d=screw5hd);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4StandAloneSupport(ShortEnd=0) {
	if(ShortEnd) {
		translate([-3,0,0]) difference() {
			translate([3,0,-6]) rotate([-6,0,0]) color("white") cubeX([MountThickness,Pi4Length-3,20],2);
			translate([0,-2.5,-18]) color("salmon") cube([MountThickness+5,Pi4Length+5,20]);
		}
		translate([52,0,0]) difference() {
			translate([3,0,-6]) rotate([-6,0,0]) color("gray") cubeX([MountThickness,Pi4Length-3,20],2);
			translate([2,0,-18]) color("gray") cube([MountThickness+3,Pi4Length+5,20]);
		}
	} else {
		difference() {
			translate([-1,0,-3]) rotate([0,12,0]) color("white") cubeX([Pi4Width-3,MountThickness,20],2);
			translate([-5,-2.5,-18]) color("salmon") cube([Pi4Length+5,MountThickness+5,20]);
		}
		difference() {
			translate([-1,Pi4Length-MountThickness,-3]) rotate([0,12,0]) color("gray") cubeX([Pi4Width-3,MountThickness,20],2);
			translate([-1,Pi4Length-MountThickness-2,-18]) color("gray") cube([Pi4Width+5,MountThickness+3,20]);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4Cover(DoFan=0) {
	difference() {
		color("cyan") cubeX([Pi4Width+8,Pi4Length+8,CoverThickness],2);
		translate([4,4,-2]) Pi4MountHoles(screw2p5);
		if(DoFan) Pi4CoverFan();
	}
	translate([8,8,0]) color("blue") Spacer(1,50,screw3);
	translate([pi4VOffset+8,8,0]) color("red") Spacer(1,50,screw3);
	translate([8,pi4HOffset+8,0]) color("green") Spacer(1,50,screw3);
	translate([pi4VOffset+8,pi4HOffset+8,0]) color("khaki") Spacer(1,50,screw3);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4CoverFan() { // add fan holes here
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4MountHoles(Screw=Yes2p5mmInsert(Use2p5mmInsert)) {
	translate([pi4Offset,pi4Offset,-1]) color("white") cylinder(h=30,d=Screw);
	translate([pi4Offset,pi4HOffset,-1]) color("black") cylinder(h=30,d=Screw);
	translate([pi4Offset+pi4VOffset,pi4Offset,-1]) color("gray") cylinder(h=30,d=Screw);
	translate([pi4Offset+pi4VOffset,pi4HOffset,-1]) color("red") cylinder(h=30,d=Screw);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4Base(ShowPi=0) {
	if(ShowPi) %translate([3,0,-6]) cube([Pi4Width,Pi4Length,2]); // show pi location
	color("cyan") cubeX([Pi4Width+4,Pi4BracketWidth,MountThickness],2);
	translate([0,Pi4Length-Pi4BracketWidth,0]) color("blue") cubeX([Pi4Width,Pi4BracketWidth,MountThickness],2);
	color("yellow") cubeX([Pi4BracketWidth,Pi4Length,MountThickness],2);
	translate([Pi4Width+4-Pi4BracketWidth,0,0]) color("purple") cubeX([Pi4BracketWidth,Pi4Length,MountThickness],2);
	// crossmembers
	translate([Pi4BracketWidth-6,0,0]) color("pink") rotate([0,0,60]) cubeX([Pi4Width+33,Pi4BracketWidth/3,MountThickness/2],1);
	translate([6,Pi4Length-Pi4BracketWidth+7,0]) color("lightgray") rotate([0,0,-60])
		cubeX([Pi4Width+33,Pi4BracketWidth/3,MountThickness/2],1);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4_support(DoMiddle=1) {
	translate([-9,4.5,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("pink") cubeX([Pi4Width+3,MountThickness,20],2);
		translate([0,-2.5,-18]) color("salmon") cube([Pi4Width+10,MountThickness+5,20]);
	}
	translate([-9,75,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("pink") cubeX([Pi4Width+3,MountThickness,20],2);
		translate([0,-2.5,-18]) color("salmon") cube([Pi4Width+10,MountThickness+5,20]);
	}
	if(DoMiddle) translate([-9,38,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("red") cubeX([Pi4Width+3,MountThickness,20],2);
		translate([0,-2.5,-18]) color("salmon") cube([Pi4Width+10,MountThickness+5,20]);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module Blower5150(blower_h,blower_w,blower_m_dist,Shift=0) { // to use a 50mm 10x15 blower instead of a 40mm axial
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////

module Blower4010(Show=0) {
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
	if(Show) translate([20,20,3]) ShowBlower4010();
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
