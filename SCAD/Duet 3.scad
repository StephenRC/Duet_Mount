//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Duet 3.scad - mount a duet 3 to 2020 extrusion and a case for the 7" pi touchscreen w/mounting
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 4/5/2020
// last update 1/13/22
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// https://creativecommons.org/licenses/by-sa/4.0/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
// 11/8/20	- Added 3HC and Duet 3 Mini 5+
// 11/12/20	- Added a due 3 with pi, seperated enough to be able to use a usb power cable to power the pi
//			  Fixed Pi4 mounting holes
// 11/14/20	- Added an antenna mount
// 11/15/20	- Added another set of mount holes for ToolBoard1LC() so that it can be mounted on either side of Aero extruder
// 11/25/20	- Added 18mm spacers to mount to mount tool board 1LC on rigth side of SingleAero
// 1/23/21	- Adjusted 1LC mount holes to extruder to clear toolboard
// 1/31/21	- Added a circuit breaker mount
// 2/13/21	- Added Duet 3 Mini5+ mounts with a PI
// 2/14/21	- Fixed Blower5150() and added a mirrored version, Duet 3 Mini: fixed driver cooling fan location
// 2/15/21	- Added ToolBoard1LCEXOSlide() to mount the 1LC on EXOSlide under the hotend mount
// 2/29/21	- Added ability to switch the side the Pi mounts on the Duet 3 Mini mount
// 2/23/21	- Added EXIslide mount for 1LC
// 5/6/21	- Added MountSpacerThickness1LC for the distance needed between LC and mount, 1LC v1.1 needs at least 1.5mm
// 12/9/21	- Made antenna mount stronger, began conversion to BOSL2
// 1/13/22	- Tweaked Blower4010()
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//***********************************************************
// May need to move cooling fan mount on platform
//***********************************************************
// Demensions from:
// Duet 3 6HC: https://duet3d.dozuki.com/Wiki/Mounting_and_cooling_the_board
// Duet 3 1LC: https://duet3d.dozuki.com/Wiki/Duet_3_Tool_Board
// Tool Dristribution Board: https://duet3d.dozuki.com/Wiki/Tool_Distribution_Board
// Deut 3 3HC: https://duet3d.dozuki.com/Wiki/Duet_3_Expansion_Hardware_Overview#Section_Dimensions
// Rasberry PI: https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/README.md
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tap the Duet 3 section screw holes with a 3mm tap, unless you're using brass inserts
// Tap Pi4 for 2.5mm, unless you're using brass inserts
//----------------------------------------------
// https://forum.duet3d.com/topic/17409/duet-3-mini-5-initial-announcement/115?_=1604500956382  - dc42 11/4/20
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NOTES: No room to connect the pi's hdmi
//		  The mounting holes on the PI 4 can be drilled out to 3mm with no problems
//******************************
// Ribbon cable must between the duet 3 6hc and the pi. No overlap with the pi or duet, it will cause wierd problems
// over the duet, partially conver the duet: starts print, then stops
//*********************************
// Duet 3M and 3HC may need adjustment to fan cooling postions
//-------------------------------------------------------------------------------------
// PI Touchscreen has to be supplied it's own 5vdc power. Powering via the dotstar connector gives low pi voltage warning.
// Duet uses M3 screws and the Pi uses M2.5 screws
//--------------------------------------------------------------------------------------------
// **** Test the placement of the PI, make sure the WIFI works where you want to put the PI
// For example, the PI WIFI doesn't in certain locations on my corexy
//--------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// includes
include <inc/screwsizes.scad>
include <bosl2/std.scad>
include <inc/brassinserts.scad>
$fn=50;		// 100 takes a long, long time to render
////////////////////////////////////////////////////////////////////////////////////////////////////////////
Use2mmInsert=1;
Use2p5mmInsert=1;
Use3mmInsert=1;
Use4mmInsert=1;
LargeBrassInsert=1;
//------------------------------------------------------------------------------------------------------------
PlatformThickness=5;	// thickness of platform
MountThickness=5;		// thickness of mount
MountSpacerThickness1LC=2; // distance needed between board and mount
CoverThickness=3;		// thickness of the covers
SupportThickness=5;		// thickness of supports
PCSpacerThickness=PlatformThickness; // thickness of the pc board spacers
PortCoverHeight=20;		// height of mount
FanMountOffset=32;		// 32 for 40mm fan
FanPlatformMountOffset=32; // 32 for 40mm fan
Spacing=17; 			// ir sensor bracket mount hole spacing
NozzleDiameter=0.4;		// hotend nozzle size for wifi antenna protection support
LayerThickness=0.3;		// layer thickness of print
4040MountOffset=35.4;	// bolt hole offest on 4010 blower
//----------------------------------------------------------------------------------------------------------
D3Width = 134;		// width - Duet 3 6HC
D3Length=140;		// length
D3HoleOffset=4.3;	// corner hole offset
//------------------------------------------------------------------------------------------------------------
Pi4Width=56;		// width - Raspberry Pi 3 and Pi 4
Pi4Length=85;		// length
Pi4BracketWidth=10; // width of the bracket sides
pi4Offset=3.5;		// offset of the holes from the side of the pc board
pi4VOffset=49;		// vertical hole offset
pi4HOffset=58;		// horizontal hole offset
//-----------------------------------------------------------------------------------------------------------
1LCWidth=47;			// width - Tool Board 1LC
1LCLength=54;			// length
1LCHoleVOffset=34;		// vertical hole offset
1LCHoleHOffset=34;	// horizontal hole offset
1LCBracketWidth=Pi4BracketWidth; // width of the bracket sides
// tool distribution board -----------------------------------------------
TDBHoleVOffset=38;		// hole vertical offset - Tool Distribution Baord
TDBHoleHOffset=63;		// hole horizontal offset
TDBHoleBOffset=3.2;		// hole offset from board edge
TDBWidth=45;			// board width
TDBLength=70;			// board length
TDBBracketWidth=Pi4BracketWidth;
// Duet 3 Mini is the same size the Duet 2 (dc42) ------------------------
D3MWidth = 100;		// width - Duet 3 Mini
D3MLength = 123;	// length
D3MHoleOffset = 4;	//hole offset
// Duet 3 3HC -----------------------------------------------------------------
3HCWidth=100;			// width
3HCLength=100;			// length
3HCHoleOffset=91;		// hole offset
33HCBracketWidth=Pi4BracketWidth; // width of the bracket sides
//---------------------------------------------------------------------------
CircuitBreakerDiameter=11;
CircuitBreakerWidth=15;
CircuitBreakerLength=45; // includes connector clearance
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//Duet3Mini5(0,D3MWidth,D3MLength,D3MHoleOffset,2);// Arg1:Blower 0 ? 1; Arg2:Width; Arg3:Length; Arg4: HoleOffset;
//											  Arg5: 0; Arg5:AddPi: 0-No, 1-close pi, 2-pi far enoungh away for usbc
//Duet3_3HCPi4(3HCWidth,3HCLength,3HCHoleOffset,PCSpacerThickness,0,0,0,0,0,1);
//		args: Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab=0,PI=0
//Duet3_6HCPi4(D3Width,D3Length,D3HoleOffset,PCSpacerThickness,0,0,0,0,0,1);
//		args: Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab=0,PI=0
// this lets you to use a usb c power cable
//Duet3_6HCPi4C(D3Width,D3Length,D3HoleOffset,PCSpacerThickness,0,0,0,0,0,1);
//		args: Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab=0,PI=0
//Duet3_6HCCover(D3Width,D3Length,1);
//Pi4Cover(1);
//translate([145,0,0])		// move over if you set the above to not have the pi mount builtin
//	Pi4StandAlone(0,Yes2p5mmInsert(Use2p5mmInsert),0,0);		// a separate mount for just the pi4
//				ShortEnd=0,Screw=Yes2p5mmInsert(Use2p5mmInsert),DoSpacers=0,ShowPi=0
//Blower5150(); //blower_h=20,blower_w=15,blower_m_dist=43,ShiftUD=0,BlowerOffset=5
//translate([100,0,0]) mirror([1,0,0]) Blower5150();
Blower4010();
//ToolBoard1LC();
//ToolBoard1LCEXOSlide();
//translate([70,0,0])
//	ToolDistibutionBoard(1,0);	// arg one: ShortEnd,arg two: Spacers
//AntennaMount(7,1); // 1st arg is mount diameter
//Spacer(4,7,screw3+0.1,3);// bltouch fan mount spacer
//		Qty=1,Thickness=PCSpacerThickness,Screw=screw3,BottomSize=3
//Spacer(2,7,screw3+0.1,3);// 1LC mount spacer
//Spacer(4,6,screw2+0.1,3);// PI mount spacer
//CircuitBreaker();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module CircuitBreaker(Diameter=CircuitBreakerDiameter) {  // 5A circuit braker KUOYUH 88 Series
	difference() {
		union() {
			color("cyan") cuboid([CircuitBreakerWidth+5,Diameter*5,4],rounding=2,p1=[0,0]);
			color("blue") cuboid([4,CircuitBreakerDiameter*5,CircuitBreakerLength],rounding=2,p1=[0,0]);
		}
		translate([(CircuitBreakerWidth+5)/2+1.5,(Diameter*5)/2,-3]) cylinder(h=10,d=Diameter);
		translate([-3,10,CircuitBreakerLength-8]) rotate([0,90,0]) color("plum") cylinder(h=10,d=screw5);
		translate([2,10,CircuitBreakerLength-8]) rotate([0,90,0]) color("gray") cylinder(h=5,d=screw5hd);
		translate([-3,40,CircuitBreakerLength-8]) rotate([0,90,0]) color("gray") cylinder(h=10,d=screw5);
		translate([2,40,CircuitBreakerLength-8]) rotate([0,90,0]) color("plum") cylinder(h=5,d=screw5hd);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

module AntennaMount(HoleSize=6.5,2HoleMount=0) {
	if(2HoleMount) {
		difference() {
			union() {
				color("cyan") hull() {
					cuboid([40,25,PlatformThickness-1],rounding=2);
					translate([0,11.5,12]) cuboid([10,2,2],rounding=0.5);
				}
			}
			translate([0,15,7.5]) rotate([90,0,0]) color("gray") cylinder(h=30,d=HoleSize); // antenna hole
			translate([0,11,7.5]) rotate([90,0,0]) color("red") cylinder(h=20,d=HoleSize+3.4,$fn=6); // antenna hole
			translate([10,-2.5,-4]) color("blue") cylinder(h=20,d=screw5);
			translate([10,-2.5,PlatformThickness/2-1]) color("gold") cylinder(h=10,d=screw5hd);
			translate([-10,-2.5,-4]) color("gold") cylinder(h=20,d=screw5);
			translate([-10,-2.5,PlatformThickness/2-1]) color("blue") cylinder(h=10,d=screw5hd);
		}
	} else {
		difference() {
			union() {
				color("cyan") hull() {
					cuboid([20,25,PlatformThickness-1],rounding=2);
					translate([0,11.5,12]) cuboid([10,2,2],rounding=0.5);
				}
			}
			translate([0,15,7.5]) rotate([90,0,0]) color("gray") cylinder(h=30,d=HoleSize); // antenna hole
			translate([0,11,7.5]) rotate([90,0,0]) color("red") cylinder(h=20,d=HoleSize+3.4,$fn=6); // antenna hole
			translate([0,-2.5,-4]) color("blue") cylinder(h=20,d=screw5);
			translate([0,-2.5,PlatformThickness/2-1]) color("gold") cylinder(h=10,d=screw5hd);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3Mini5(Blower=0,Width,Length,HoleOffset,AddPI=0,PiSide=1) {
	union() {
		Platform3M(Width,Length,HoleOffset,0); // 0 - don't add side fan mount holes; 1 - add side fan mount holes;
		PlatformMount3M(Width,Length,HoleOffset);
		Duet3MSupports(Width,Length,HoleOffset);
	}
	translate([20,25,0]) Spacer(4,MountThickness,screw3); // put them in one of the vent holes
	if(AddPI==1) { // close mount
		if(PiSide==0) {
			translate([115,2.8,0]) {
				Pi4Mount(Yes2p5mmInsert(Use2p5mmInsert),0,17);
				translate([-15,0,0]) pi4CloseAttachment(0);
			}
		} else {
		}
	}	
	if(AddPI==2) { // far mount for USBC cable
		if(PiSide==0) {
			translate([147,2.8,0]) Pi4Mount(Yes2p5mmInsert(Use2p5mmInsert),0,6);
			translate([101.5,2.8,0]) pi4CloseAttachmentC(0);
		} else {
			translate([-45,88,0]) rotate([0,0,180]) Pi4Mount(Yes2p5mmInsert(Use2p5mmInsert),0,6);
			translate([-49,3,0]) pi4CloseAttachmentC(0);
			translate([-7,8,MountThickness]) color("red") hull() {
				cuboid([10,MountThickness,1],rounding=0.5,p1=[0,0]);
				translate([0,0,4.5]) cuboid([5,MountThickness,1],rounding=0.5,p1=[0,0]);
			}
		}
	}	

}

///////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoard(ShortEnd=0,Spacers=1) { // this mounts to the Single-Titan-E3DV6.scad extruder
	difference() {
		ToolDistibutionBoard_base();
		translate([TDBHoleBOffset,TDBHoleBOffset+MountThickness,0])
			ToolDistibutionBoardMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
	}
		ToolDistibutionBoardMount(ShortEnd);
	difference() {
		ToolDistibutionBoardSupport(ShortEnd);
		translate([TDBHoleBOffset,TDBHoleBOffset+MountThickness,0])
			ToolDistibutionBoardMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
	}if(Spacers) translate([-8,8,0]) Spacer(4,MountThickness,screw3);;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module ToolDistibutionBoard_base() {
	union() {
		color("cyan") cuboid([TDBWidth,TDBBracketWidth,MountThickness],rounding=1,p1=[0,0]);
		translate([0,TDBLength-TDBBracketWidth+MountThickness,0]) color("blue")
			cuboid([TDBWidth,TDBBracketWidth,MountThickness],rounding=1,p1=[0,0]);
		color("yellow")
			cuboid([TDBBracketWidth+MountThickness/2,TDBLength+MountThickness,MountThickness],rounding=1,p1=[0,0]);
		translate([TDBWidth-TDBBracketWidth-MountThickness/2,0,0]) color("purple")
			cuboid([TDBBracketWidth+MountThickness/2,TDBLength+MountThickness,MountThickness],rounding=1,p1=[0,0]);
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
			color("red") cuboid([TDBWidth,MountThickness,20],rounding=1,p1=[0,0]);
			translate([8,8,MountThickness+6]) color("red") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([8,MountThickness+4,MountThickness+6]) color("khaki") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
			translate([38,8,MountThickness+6]) color("white") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([38,MountThickness+4,MountThickness+6]) color("green") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
		}
	} else {
		translate([0,0,0]) difference() {
			color("red") cuboid([MountThickness,TDBLength+MountThickness,20],rounding=1,p1=[0,0]);
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
			translate([11,0,0]) color("green") hull() {
				color("white") cuboid([5,5,20],rounding=2,p1=[0,0]);
				translate([0,TDBLength,0]) color("white") cuboid([5,5,5],rounding=2,p1=[0,0]);
			}
			translate([8,MountThickness+9,MountThickness+6]) color("pink") rotate([90,0,0])  cylinder(h=10,d=screw5hd);
		}
		difference() {
			translate([29,0,0]) color("gray") hull() {
				translate([0,0,0]) color("white") cuboid([5,5,20],rounding=2,p1=[0,0]);
				translate([0,TDBLength,0]) color("white") cuboid([5,5,5],rounding=2,p1=[0,0]);
			}
			translate([38,MountThickness+9,MountThickness+6]) color("plum") rotate([90,0,0])  cylinder(h=10,d=screw5hd);
		}
	} else {
		translate([0,8,0]) color("green") hull() {
			color("white") cuboid([5,5,20],rounding=2,p1=[0,0]);
			translate([TDBWidth-5,0,0]) color("white") cuboid([5,5,5],rounding=2,p1=[0,0]);
		}
		translate([0,TDBLength/2,0]) color("white") hull() {
			color("white") cuboid([5,5,20],rounding=2,p1=[0,0]);
			translate([TDBWidth-5,0,0]) color("white") cuboid([5,5,5],rounding=2,p1=[0,0]);
		}
		translate([0,TDBLength-7,0]) color("gray") hull() {
			translate([0,0,0]) color("white") cuboid([5,5,20],rounding=2,p1=[0,0]);
			translate([TDBWidth-5,0,0]) color("white") cuboid([5,5,5],rounding=2,p1=[0,0]);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////

module ToolBoard1LC() { // this mounts to the Single-Titan-E3DV6.scad extruder
	difference() {
		union() {
			1LC_base();
			translate([8,13,0]) Spacers1LC(0);
		}
		translate([8,13,0]) 1LCMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([30,-1.5,-MountThickness]) IRMountHoles(screw3);
		translate([5,-1.5,-MountThickness]) IRMountHoles(screw3);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////

module ToolBoard1LCEXOSlide() {
	difference() {
		union() {
			1LC_base();
			translate([8,13,0]) Spacers1LC(0); // built in spacers
		}
		translate([8,13,0]) 1LCMountHoles(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([35,2,0]) rotate([0,0,90]) {
			translate([0,0,-3]) color("red") cylinder(h=10,d=screw4);
			translate([0,20,-3]) color("blue") cylinder(h=10,d=screw4);
			translate([0,0,MountThickness/2]) color("blue") cylinder(h=5,d=screw4hd);
			translate([0,20,MountThickness/2]) color("red") cylinder(h=5,d=screw4hd);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Spacers1LC(Extra=MountSpacerThickness1LC,Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)) { // Extra is more height
	translate([0,0,0]) Spacer(1,MountThickness+MountSpacerThickness1LC,Screw,2.5);
	translate([0,1LCHoleHOffset,0]) Spacer(1,MountThickness+MountSpacerThickness1LC,Screw,2.5);
	translate([1LCHoleVOffset,0,0]) Spacer(1,MountThickness+MountSpacerThickness1LC,Screw,2.5);
	translate([1LCHoleVOffset,1LCHoleHOffset,0]) Spacer(1,MountThickness+MountSpacerThickness1LC,Screw,2.5);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module 1LC_base() {
	translate([0,-6,0]) color("cyan") cuboid([1LCWidth+4,1LCBracketWidth+5,MountThickness],rounding=2,p1=[0,0]);
	translate([0,1LCLength-Pi4BracketWidth,0]) color("blue")
		cuboid([1LCWidth,Pi4BracketWidth,MountThickness],rounding=2,p1=[0,0]);
	color("yellow") cuboid([1LCBracketWidth,1LCLength,MountThickness],rounding=2,p1=[0,0]);
	translate([1LCWidth+4-1LCBracketWidth,0,0]) color("purple")
		cuboid([1LCBracketWidth,1LCLength,MountThickness],rounding=2,p1=[0,0]);
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
	if(PI>=1) {
		if(PI==2) %translate([138,51,-12])cube([5,89.2,5]); // measure for the 26 pin connector location
		translate([150,45.8,0]) rotate([0,0,0]) Pi4Mount(Yes2p5mmInsert(Use2p5mmInsert),0,6);
		difference() {
			translate([135,45.8,0]) pi4CloseAttachment(0);
			translate([125,47,MountThickness-1]) color("black") cube([10,10,15]);
			translate([125,117,MountThickness-1]) color("gray") cube([10,10,15]);
		}
	}	
	if(Blower) translate([230,-5,0]) rotate([0,0,90]) Blower4010();
	if(Blower==2 || Blower2) translate([185,-5,0]) rotate([0,0,90]) Blower4010();
	if(PI) {
		translate([20,30,0]) Spacer(4,SpacerThickness,screw3); // put them in one of the vent holes
		translate([70,30,0]) Spacer(4,SpacerThickness,screw2p5); // put them in one of the vent holes
	}
	if(!PI) translate([20,30,0]) Spacer(4,SpacerThickness,screw3); // put them in one of the vent holes
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_6HCPi4C(Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab,PI=0)
{
	Platform(Width,Length,HoleOffset);
	PlatformMount(Width,Length,Offset2020,ExtTab);
	difference() {
		Duet3Supports(Width,Length,HoleOffset);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset);
	}
	if(PI==1) {
		translate([180,45.8,0]) rotate([0,0,0]) Pi4Mount(Yes2p5mmInsert(Use2p5mmInsert),0,6);
		difference() {
			translate([135,45.8,0]) pi4CloseAttachmentC(0);
			translate([125,47,MountThickness-1]) color("black") cube([10,10,15]);
			translate([125,117,MountThickness-1]) color("gray") cube([10,10,15]);
			translate([pi4Offset+2,pi4Offset+17,0]) Pi4MountHoles();
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_3HCPi4(Width,Length,HoleOffset,SpacerThickness=PCSpacerThickness,Cover=0,Blower=0,Blower2=0,Offset2020=0,ExtTab,PI=0) {
	Platform3HC(Width,Length,HoleOffset);
	PlatformMount3HC(Width,Length,Offset2020,ExtTab);
		Duet3HCSupports(Width,Length,HoleOffset);
	if(Blower) translate([230,-5,0]) rotate([0,0,90]) Blower4010();
	if(Blower2) translate([185,-5,0]) rotate([0,0,90]) Blower4010();
	translate([20,30,0]) Spacer(4,SpacerThickness,screw3); // put them in one of the vent holes
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Spacer(Qty=1,Thickness=PCSpacerThickness,Screw=screw3,BottomSize=3) {
	for(x = [0:Qty-1]) {
		translate([0,x*15,0]) difference() {
			color("cyan") hull() {
				cylinder(h=0.5,d=Screw*BottomSize);
				translate([0,0,Thickness]) cylinder(h=1,d=Screw*2);
			}
			translate([0,0,-2]) color("plum") cylinder(h=Thickness+5,d=Screw);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet3_6HCCover(Width,Length,Fan=0) {
	difference() {
		color("cyan") cuboid([Width+8,Length+8,CoverThickness],rounding=1,p1=[0,0]);
		translate([4,4,-1]) PlatformScrewMounts(screw3,Width,Length);
		if(Fan) translate([Width/2-15,Length/2-15,0]) CoverFan();
	}
	translate([4,4,0]) Spacer(1,50,screw3);
	translate([Width+4,4,0]) Spacer(1,50,screw3);
	translate([Width+4,Length+4,0]) Spacer(1,50,screw3);
	translate([4,Length+4,0]) Spacer(1,50,screw3);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4CloseAttachment(DoMiddle=1,Show=0) {
	color("green") cuboid([19,Pi4BracketWidth-2,MountThickness],rounding=2,p1=[0,0]);
	translate([0,72,0]) color("plum") cuboid([19,Pi4BracketWidth-2,MountThickness],rounding=2,p1=[0,0]); // vertical
	if(DoMiddle) {
		translate([0,38,0]) color("purple") cuboid([19,MountThickness,MountThickness],rounding=2,p1=[0,0]);
		translate([-3,38,0]) color("gray") cuboid([19,MountThickness,13.5],rounding=2,p1=[0,0]);
	}
	translate([-3,4.5,0]) color("white") cuboid([19,MountThickness,13.5],rounding=2,p1=[0,0]);
	translate([-3,75,0]) color("khaki") cuboid([19,MountThickness,13.5],rounding=2,p1=[0,0]);
	if(Show) %translate([8,15.5,2]) cube([6,56,6]);  // make sure the 40pin connector will fit
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4CloseAttachmentC(DoMiddle=1,Show=0) { // to usea usb c cable
	color("green") cuboid([49,Pi4BracketWidth-2,MountThickness],rounding=2,p1=[0,0]);
	translate([0,72,0]) color("plum") cuboid([49,Pi4BracketWidth-2,MountThickness],rounding=2,p1=[0,0]); // vertical
	if(DoMiddle) {
		translate([0,38,0]) color("purple") cuboid([49,MountThickness,MountThickness],rounding=2,p1=[0,0]);
		translate([-3,38,0]) color("gray") cuboid([49,MountThickness,13.5],rounding=2,p1=[0,0]);
	}
	translate([3.7,5,0]) color("white") cuboid([45,MountThickness,13.615],rounding=2,p1=[0,0]);
	translate([3.7,75.5,0]) color("khaki") cuboid([45,MountThickness,13.615],rounding=2,p1=[0,0]);
	if(Show) %translate([8,15.5,2]) cube([6,56,6]);  // make sure the 40pin connector will fit
}

///////////////////////////////////////////////////////////////////////////////////////////////////

module pi4Attachment() { // move out from duet
	color("green") cuboid([65,Pi4BracketWidth,MountThickness],rounding=2,p1=[0,0]);
	translate([0,70,0]) color("plum") cuboid([65,Pi4BracketWidth,MountThickness],rounding=2,p1=[0,0]); // vertical
	translate([0,33,0]) color("purple") cuboid([65,Pi4BracketWidth,MountThickness],rounding=2,p1=[0,0]);
	translate([-3,4.5,0]) color("white") cuboid([64,MountThickness,13.5],rounding=2,p1=[0,0]);
	translate([-3,38,0]) color("gray") cuboid([64,MountThickness,13.5],rounding=2,p1=[0,0]);
	translate([-3,75,0]) color("khaki") cuboid([64,MountThickness,13.5],rounding=2,p1=[0,0]);
	translate([0,2,0]) color("lightgray") rotate([0,0,27]) cuboid([75,5,MountThickness],rounding=2,p1=[0,0]);
	translate([0,77,0]) color("cyan") rotate([0,0,-29]) cuboif([75,5,MountThickness],rounding=2,p1=[0,0]);
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
	cylinder(h=20,d=Screw);
	translate([FanPlatformMountOffset,0,0]) cylinder(h=20,d=Screw);
}

///////////////////////////////////////////////////////////////////////////////////////

module Platform(Width,Length,HoleOffset,ShowBoards=0) { // main platform
	if(ShowBoards) {
		%translate([0,0,-6]) cube([D3Width,D3Length,2]); // show duet location
		%translate([4,0,-1]) cube([D3Width-D3HoleOffset*2,5,7]); // check mount locations
		%translate([2,3.5,-1]) cube([5,D3Length-D3HoleOffset*2,7]);
	}
	difference() {
		translate([-5,-7,0]) color("cyan") cuboid([Width+10,Length+MountThickness+7,PlatformThickness],rounding=2,p1=[0,0]);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset);
		PlatformVents();
		translate([0,5,PlatformThickness/2]) 
			fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
		translate([43,5,PlatformThickness/2])
			fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
	}
}

///////////////////////////////////////////////////////////////////////////////////////

module Platform3M(Width,Length,HoleOffset,ShowBoards=0) { // main platform
	if(ShowBoards) {
		%translate([0,0,-6]) cube([D3Width,D3Length,2]); // show duet location
		%translate([4,0,-1]) cube([D3Width-D3HoleOffset*2,5,7]); // check mount locations
		%translate([2,3.5,-1]) cube([5,D3Length-D3HoleOffset*2,7]);
	}
	difference() {
		translate([-5,-7,0]) color("cyan") cuboid([Width+10,Length+MountThickness+7,PlatformThickness],rounding=2,p1=[0,0]);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset);
		PlatformVents3M();
		translate([69,5,PlatformThickness/2])
			fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
	}
}

///////////////////////////////////////////////////////////////////////////////////////

module Platform3HC(Width,Length,HoleOffset,ShowBoards=0) { // main platform
	if(ShowBoards) {
		%translate([0,0,-6]) cube([D3Width,D3Length,2]); // show duet location
		%translate([4,0,-1]) cube([D3Width-D3HoleOffset*2,5,7]); // check mount locations
		%translate([2,3.5,-1]) cube([5,D3Length-D3HoleOffset*2,7]);
	}
	difference() {
		translate([-5,-7,0]) color("cyan") cuboid([Width+10,Length+MountThickness+7,PlatformThickness],rounding=2,p1=[0,0]);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeBrassInsert),Width,Length,HoleOffset);
		PlatformVents3HC();
		translate([0,5,PlatformThickness/2])
			fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
		translate([43,5,PlatformThickness/2])
			fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeBrassInsert)); // mount for driver cooling
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////

module PlatformVents3HC(over) { // vent holes in platform (over not used)
	translate([2,0,0]) color("red") hull() {
		translate([D3Width/3-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([D3Width/3-22,D3Length-70,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
	}
	translate([8,0,0]) color("white") hull() {
		translate([2*(D3Width/3)-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([2*(D3Width/3)-22,D3Length-70,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
	}
}

//////////////////////////////////////////////////////////////////////

module PlatformVents3M(over) { // vent holes in platform (over not used)
	translate([2,0,0]) color("red") hull() {
		translate([D3Width/3-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([D3Width/3-22,D3Length-45,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
	}
	translate([8,0,0]) color("white") hull() {
		translate([2*(D3Width/3)-22,25,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
		translate([2*(D3Width/3)-22,D3Length-45,-1]) cylinder(h=MountThickness*2,r=D3Width/9);
	}
}

///////////////////////////////////////////////////////////////////////


module PlatformMount(Width,Length,HoleOffset,MSTab=0) { // 2020 mount
	difference() {
		translate([-5,Length,0]) color("gray") cuboid([Width+10,MountThickness,PortCoverHeight+8],rounding=2,p1=[0,0]);
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

///////////////////////////////////////////////////////////////////////

module PlatformMount3HC(Width,Length,HoleOffset,MSTab=0) { // 2020 mount
	difference() {
		translate([-5,Length,0]) color("gray") cuboid([Width+10,MountThickness,PortCoverHeight+8],rounding=2,p1=[0,0]);
		Holes4MS3HC(Width,Length,HoleOffset);
	}
	if(MSTab) {
		difference() {
			rotate([-90,0,0]) translate([5,-PortCoverHeight/2-3-HoleOffset,Length+MountThickness]) ExtTab(Width-10);
			translate([0,1,0]) Holes4MS(Width,Length,HoleOffset);
		}
	}
}

///////////////////////////////////////////////////////////////////////

module PlatformMount3M(Width,Length,HoleOffset,MSTab=0) { // 2020 mount
	difference() {
		translate([-5,Length,0]) color("gray") cuboid([Width+10,MountThickness,PortCoverHeight+8],rounding=2,p1=[0,0]);
		Holes4MS3HC(Width,Length,HoleOffset);
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

//////////////////////////////////////////////////////////////////////////////////////////

module Holes4MS3HC(Width,Length,HoleOffset=0) {
	translate([12,Length+7,10+HoleOffset]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
	translate([Width-12,Length+7,10+HoleOffset]) rotate([90,0,0]) color("blue") cylinder(h=MountThickness*2,r=screw5/2);
}

//////////////////////////////////////////////////////////////////////

module Duet3Supports(Width,Length,HoleOffset) { // connects & support main platform
	difference() {
		translate([-5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("pink") cuboid([SupportThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,40,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([-7,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D3Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width-SupportThickness+4,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("red") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([Width-SupportThickness,3,-SupportThickness-19]) color("black")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/3-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("blue") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,40,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("white")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("red") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/3+Width/3-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("purple") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([Width/3+Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("cyan")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
}

//////////////////////////////////////////////////////////////////////

module Duet3HCSupports(Width,Length,HoleOffset) { // connects & support main platform
	difference() {
		translate([-5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("pink") cuboid([SupportThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,40,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([-7,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D3Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width-SupportThickness+4,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("red") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([Width-SupportThickness,3,-SupportThickness-19]) color("black")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/2-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("blue") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,40,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([Width/3-SupportThickness/2+15,3,-SupportThickness-19]) color("white")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("red") cube([Width+10,10,PortCoverHeight+10]);
	}
}

//////////////////////////////////////////////////////////////////////

module Duet3MSupports(Width,Length,HoleOffset) { // connects & support main platform
	difference() {
		translate([-5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("pink") cuboid([SupportThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,40,PlatformThickness/2])
			rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([-7,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D3Length+5,PortCoverHeight+5]);
		translate([-5,Length+2,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width-SupportThickness+4,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("red") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([Width-SupportThickness,3,-SupportThickness-19]) color("black")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+2,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/2-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("blue") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,40,PlatformThickness/2]) rotate([90,0,0])
			fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
		translate([Width/3-SupportThickness/2+15,3,-SupportThickness-19]) color("white")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+2,0]) color("red") cube([Width+10,10,PortCoverHeight+10]);
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

module Pi4Mount(Screw=Yes2p5mmInsert(Use2p5mmInsert),DoMiddle=0,MountOffset=6) {
	difference() {
		Pi4Base();
		translate([pi4Offset+2,pi4Offset+MountOffset,0]) Pi4MountHoles(Screw);
	}
	difference() {
		pi4_support(DoMiddle);
		translate([pi4Offset+2,pi4Offset+MountOffset,0]) Pi4MountHoles(Screw);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4StandAlone(ShortEnd=0,Screw=Yes2p5mmInsert(Use2p5mmInsert),DoSpacers=0,Show) {
	if(ShortEnd) echo("short end"); else echo("long end");
	if(Show) %translate([pi4Offset,pi4Offset+4,15]) cube([pi4VOffset,pi4HOffset,5]);
	difference() {
		union() {
			Pi4Base(Show);
			Pi4StandAloneSupport(ShortEnd);
			Pi4StandAloneMount(ShortEnd);
		}
		translate([pi4Offset+2,pi4Offset+17,0]) Pi4MountHoles(Screw);
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
			color("blue") cuboid([Pi4Width+4,MountThickness,20],rounding=2,p1=[0,0]);
			translate([15,8,MountThickness+8]) color("red") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([15,MountThickness*2-1,MountThickness+8]) color("khaki") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
			translate([45,8,MountThickness+8]) color("white") rotate([90,0,0])  cylinder(h=10,d=screw5);
			translate([45,MountThickness*2-1,MountThickness+8]) color("green") rotate([90,0,0])  cylinder(h=5,d=screw5hd);
		}
	} else {
		difference() {
			color("blue") cuboid([MountThickness,Pi4Length,20],rounding=2,p1=[0,0]);
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
			translate([3,0,-6]) rotate([-6,0,0]) color("white") cuboid([MountThickness,Pi4Length-3,20],rounding=2,p1=[0,0]);
			translate([0,-2.5,-18]) color("salmon") cube([MountThickness+5,Pi4Length+5,20]);
		}
		translate([52,0,0]) difference() {
			translate([3,0,-6]) rotate([-6,0,0]) color("gray") cuboid([MountThickness,Pi4Length-3,20],rounding=2,p1=[0,0]);
			translate([2,0,-18]) color("gray") cube([MountThickness+3,Pi4Length+5,20]);
		}
	} else {
		difference() {
			translate([-1,0,-3]) rotate([0,12,0]) color("white") cuboid([Pi4Width-3,MountThickness,20],rounding=2,p1=[0,0]);
			translate([-5,-2.5,-18]) color("salmon") cube([Pi4Length+5,MountThickness+5,20]);
		}
		difference() {
			translate([-1,Pi4Length-MountThickness,-3]) rotate([0,12,0]) color("gray")
				cuboid([Pi4Width-3,MountThickness,20],rounding=2,p1=[0,0]);
			translate([-1,Pi4Length-MountThickness-2,-18]) color("gray") cube([Pi4Width+5,MountThickness+3,20]);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4Cover(DoFan=0) {
	difference() {
		color("cyan") cuboid([Pi4Width+8,Pi4Length+8,CoverThickness],rounding=1,p1=[0,0]);
		translate([8,8,-2]) Pi4MountHoles(screw3);
		if(DoFan) translate([15,20,0]) CoverFan();
	}
	translate([8,8,0]) color("blue") Spacer(1,50,screw3);
	translate([pi4VOffset+8,8,0]) color("red") Spacer(1,50,screw3);
	translate([8,pi4HOffset+8,0]) color("green") Spacer(1,50,screw3);
	translate([pi4VOffset+8,pi4HOffset+8,0]) color("khaki") Spacer(1,50,screw3);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

module CoverFan() { // add fan holes here
	translate([32/2,32/2,1.5]) color("red") cyl(h=CoverThickness+0.2,d=37,rounding=-1);
	color("blue") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
	translate([FanMountOffset,0,0]) color("purple") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
	translate([FanMountOffset,FanMountOffset,0]) color("white") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
	translate([0,FanMountOffset,0]) color("lightgray") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeBrassInsert));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4MountHoles(Screw=Yes2p5mmInsert(Use2p5mmInsert)) {
	translate([0,pi4HOffset,-5]) color("white") cylinder(h=30,d=Screw);
	translate([pi4VOffset,0,-5]) color("black") cylinder(h=30,d=Screw);
	translate([pi4VOffset,pi4HOffset,-5]) color("gray") cylinder(h=30,d=Screw);
	translate([0,0,-5]) color("red") cylinder(h=30,d=Screw);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module Pi4Base(ShowPi=0) {
	if(ShowPi) %translate([3,0,-6]) cube([Pi4Width,Pi4Length,2]); // show pi location
	color("cyan") cuboid([Pi4Width+4,Pi4BracketWidth,MountThickness],rounding=2,p1=[0,0]);
	translate([0,Pi4Length-Pi4BracketWidth,0]) color("blue") 
		cuboid([Pi4Width,Pi4BracketWidth,MountThickness],rounding=2,p1=[0,0]);
	color("yellow") cuboid([Pi4BracketWidth,Pi4Length,MountThickness],rounding=2,p1=[0,0]);
	translate([Pi4Width+4-Pi4BracketWidth,0,0]) color("purple") 
		cuboid([Pi4BracketWidth,Pi4Length,MountThickness],rounding=2,p1=[0,0]);
	//--- crossmembers
	translate([Pi4BracketWidth-2,0,0]) color("pink") rotate([0,0,60]) 
		cuboid([Pi4Width+33,Pi4BracketWidth/3,MountThickness/2],rounding=1,p1=[0,0]);
	translate([6,Pi4Length-Pi4BracketWidth+7,0]) color("lightgray") rotate([0,0,-60])
		cuboid([Pi4Width+33,Pi4BracketWidth/3,MountThickness/2],rounding=1,p1=[0,0]);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module pi4_support(DoMiddle=1) {
	translate([-9,4.5,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("pink") cuboid([Pi4Width+3,MountThickness,20],rounding=2,p1=[0,0]);
		translate([0,-2.5,-18]) color("green") cube([Pi4Width+10,MountThickness+5,20]);
	}
	translate([-9,75,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("pink") cuboid([Pi4Width+3,MountThickness,20],rounding=2,p1=[0,0]);
		translate([0,-2.5,-18]) color("salmon") cube([Pi4Width+10,MountThickness+5,20]);
	}
	if(DoMiddle) translate([-9,38,0]) difference() {
		translate([3,0,-6]) rotate([0,7,0])	color("red") cuboid([Pi4Width+3,MountThickness,20],rounding=2,p1=[0,0]);
		translate([0,-2.5,-18]) color("purple") cube([Pi4Width+10,MountThickness+5,20]);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module Blower5150(blower_h=20,blower_w=15,blower_m_dist=43,ShiftUD=0,BlowerOffset=5) {
	difference() { // to use a 50mm 10x15 blower instead of a 40mm axial
		color("cyan") cuboid([FanMountOffset+10,blower_w+10.5+ShiftUD,PlatformThickness+1],rounding=2,p1=[0,0]);
		translate([blower_h/2+BlowerOffset,PlatformThickness+ShiftUD,-2]) color("red") cube([blower_h,blower_w,10]);
		BlowerAdapterScrew();
	}
	difference() {
		translate([21+BlowerOffset,ShiftUD-1.5,0]) color("black")
			cuboid([screw4+4,screw4+1,blower_m_dist+screw4+1],rounding=2,p1=[0,0]);
		translate([screw4/2+23+BlowerOffset,screw4+blower_w+6+ShiftUD,blower_m_dist]) rotate([90,0,0]) {
			if(Use4mmInsert) {
				color("white") cylinder(h=30,d=Yes4mmInsert());
			} else {
				color("white") cylinder(h=30,d=screw4);
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

module Blower4010(Show=0,DoTab=1) {
	difference() {
		union() {
			color("cyan") cuboid([47,45,PlatformThickness],rounding=2,p1=[0,0]);
			if(DoTab) {
				translate([1,1,0]) color("gray") cylinder(h=LayerThickness,d=15);
				translate([1,38,0]) color("lightgray") cylinder(h=LayerThickness,d=15);
				translate([44,1,0]) color("green") cylinder(h=LayerThickness,d=15);
				translate([44,38,0]) color("salmon") cylinder(h=LayerThickness,d=15);
			}
		}
		translate([8.5,5,0]) 4010MountHoles();
		translate([0,6.5,0]) 4010MountToDuet();
	}
	translate([3,22,0]) color("purple") cylinder(h=18,d=3);
	difference() {
		color("pink") cuboid([6,45,19],rounding=2,p1=[0,0]);
		translate([-1,8,PlatformThickness]) color("gray") cuboid([10,30,10],rounding=1,p1=[0,0]);
		translate([0,6.5,0]) 4010MountToDuet();
	}
	if(Show) translate([20,20,3]) ShowBlower4010();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module 4010MountHoles(Screw=Yes2mmInsert(Use2mmInsert)) {
	translate([0,0,-2]) color("red") cylinder(h=10,d=Screw);
	translate([4040MountOffset,0,-2]) color("blue") cylinder(h=10,d=Screw);
	translate([0,4040MountOffset,-2]) color("plum") cylinder(h=10,d=Screw);
	translate([4040MountOffset,4040MountOffset,-2]) color("black") cylinder(h=10,d=Screw);
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
