//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// duet085 and 2.scad - mount a duet 085, 2 and 3 to 2020 extrusion
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 5/5/2016
// last update 1/6/22
// https://creativecommons.org/licenses/by-sa/4.0/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 5/22/16	- Added DueX4 board and a simple covers for the Duet & DueX4
// 6/26/16	- Added overhang version where it places the board out over the 2020 it mounts on
// 7/8/16	- Redesigned the simple covers to be simpler, they just mount to 2020
//			  Added a i/o port cover
// 8/9/16	- Added a 40mm fan mount to blow directly on the bottom of the stepper section
//			  Changed spacer thickness to 5 from 3, for better cooling underneath
//			  Added protective cover for the wifi antenna, uses nozzle_diameter to set thickness
//			  of the support for it
//			  Added an adapter to use a 10x15 50mm blower instead of a 40mm axial fan
// 8/15/16	- Added vars for wifi antenna size and position
// 9/5/16	- Tweaked board position in duetoverhang() to have mounting screws go into 2020 slot
// 9/10/16	- Received the DuetWifi and adjusted the antenna hole
// 10/25/16	- DueX2 & DueX5 info released, mouning holes same as DuetWifi, print and use a set of 5mm spacers
//			  to mount them back to back.  Will need longer spacers between X board and mount
// 1/18/17	- Added colors to preview for easier editing
// 6/22/20	- Seperated Duet 085 and 2 to a separate file from Duet 3, this one has Duet 085 and 2
// 9/15/20	- Added a standoff cover for the Duet 2
// 1/6/22	- BOSL2. fixed duet 2 ethernet port cover, removed old stepper cooling fan mount
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Demensions from:
// Duet 0.8.5: http://reprap.org/wiki/Duet#Dimensions
// DueX4: http://reprap.org/wiki/Duex4#Dimensions
// Duet 2 Wifi & Ethernet: https://duet3d.com/wiki/Mounting_and_cooling_the_board#Mounting
// DueX2 & DueX5: https://duet3d.com/wiki/DueX2_and_DueX5_expansion_boards
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Duet 2 I/O port cover vars are next to portcover()  (works for v1.0)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tap the board screw holes with a 3mm tap, unless you're using brass inserts
// The i/o port cover mounts in place of the spacers at the i/o port end
// Cover mounts to a 2020 that's above the one the board mounts on
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NOTES: DueX4 board dimensions are untested, don't have one.
//		  DueX2 & DueX not tested, don't have one.
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// includes
include <inc/screwsizes.scad>
use <bosl2/std.scad> // http://www.thingiverse.com/thing:112008
include <inc/brassinserts.scad>
$fn=50;		// 100 takes a long, long time to render
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// vars
////////////////////////////////////////////////////////////////////////////////////////////////////////////
Use3mmInsert=1;
Use4mmInsert=1;
LargeInsert=1;
SpacerThickness=5; //spacer thickness
DueX4Width = 77.409; // duex4 size from http://reprap,org/wiki/duex4
DueX4Length = 123;
DueX4HoleOffset1 = 4;	// DueX4 mounting hole offsets from DueX4 wiki page
DueX4HoleOffset2 = 3.048;
DueX4HoleOffset3 = 12.131;
PlatformThickness = 5; // thickness of platform
MountThickness = 5; // thickness of mount
SupportThickness = 5; // thickness of supports
PCSpacerThickness = 5; // thickness of the pc board spacers
PortCoverHeight = 20;	// height of mount
FanMountOffset = 32; // 32 for 40mm fan
FanPlatformMountOffset = 32; // 32 for 40mm fan
NozzleDiameter = 0.4;	// hotend nozzle size for wifi antenna protection support
LayerThickness = 0.3;	// layer thickness of print
D085Width = 100;	// Duet 085 width
D085Length = 123;	// Duet 085 length rounded up
D085HoleOffset = 4;	// Duet 085 corner hole offset
D2Width = 100;		// Duet 2 width
D2Length = 123;		// Duet 2 length
D2HoleOffset = 4;	// Duet 2 corner hole offset
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//Duet085(1,0,0,D2Width,D2Length,D2HoleOffset,0);	// Arg2:FanNotch 0 ? 1;
												// Arg3:Blower 0 ? 1; Arg3:Width; Arg4:Length; Arg4: HoleOffset
												// Arg6:Duet 2 cover:0=ethernet,1=none,2=wifi

Duet2(1,0,D2Width,D2Length,D2HoleOffset,2);	// Arg1: 0 duet085, Duet 2; Arg2:unused;
												// Arg3:Blower 0 ? 1; Arg4:Width; Arg5:Length; Arg6: HoleOffset
												// Arg7:Duet 2 cover:3=ethernet,1=none,2=wifi
//DuetCover(D2Width,D2Length,D2HoleOffset);
//DuetCover(D085Width,D085Length,D085HoleOffset);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet085(WhichOne,Blower,Width,Length,HoleOffset,Board) {
	Duet2(0,0,Blower,Width,Length,HoleOffset,Board);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

module Duet2(WhichOne,Blower,Width,Length,HoleOffset,Board) {
	if(WhichOne==0) { // Duet 085 & cover
		// for duet() & duetoverhang() bottom fan mount: 0-column,1-notched,2-none
		duet(0);	// Duet 0.8.5 & DuetWiFi
		translate([0,-20,0]) portcover(Board,0,0,Width,Length,HoleOffset); // 0 = Duet 0.8.5; 2 - DuetWiFi
	}//portcover(Board=0,EthernetX,EthernetY,Width,Length,HoleOffset)
	if(WhichOne==1) { // Overhang Duet 085 & cover
		duetoverhang(0);	// Duet 0.8.5 (maybe DuetWiFi) puts i/o ports close the the outer edge of the 2020
		portcover(Board,0,0,Width,Length,HoleOffset); // 0 = Duet 0.8.5; 1 - DuetWiFi (not tested)
	}
	if(WhichOne==2) { // DuetWifi & cover
		duet(0);	// Duet 0.8.5 & DuetWiFi
		translate([0,-20,0]) portcover(Board,0,0,Width,Length,HoleOffset); // 0 = Duet 0.8.5; 1 - DuetWiFi (v1.02)
	}
	if(WhichOne==3) { // Overhang Duet 085 & cover
		duetoverhang(0);	// Duet 0.8.5 (maybe DuetWiFi) puts i/o ports close the the outer edge of the 2020
		portcover(Board,0,0,Width,Length,HoleOffset); // 0 = Duet 0.8.5; 1 - DuetWiFi (not tested)
	}
	if(Blower) {
		translate([0,-35,0]) blower_adapter(20,15,48,0); // args: height, width, mounting screw height, shift up
	}
}


//////////////////////////////////////////////////////////////////////

module DuetCover(Width,Length,HoleOffset,Screw=screw3) {
	difference() {
		color("cyan") cuboid([Width,Length,4],rounding=2,p1=[0,0]);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeInsert),Width,Length,HoleOffset);
		translate([Width/2-15,Length/2-15,0]) CoverFan(4);
	}
	translate([HoleOffset,HoleOffset-1,0]) color("red") TaperedSpacer(40,Screw);
	translate([Width-HoleOffset,HoleOffset-1,-1]) color("black") TaperedSpacer(40,Screw);
	translate([Width-HoleOffset,Length-HoleOffset-0.5,-1]) color("blue") TaperedSpacer(40,Screw);
	translate([HoleOffset,Length-HoleOffset-0.5,-1]) color("gray") TaperedSpacer(40,Screw);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

module CoverFan(Thickness=5) { // add fan holes here
	translate([32/2,32/2,Thickness/2]) color("red") cyl(h=Thickness+0.1,d=37,rounding=-1);
	color("blue") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
	translate([FanMountOffset,0,0]) color("purple") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
	translate([FanMountOffset,FanMountOffset,0]) color("white") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
	translate([0,FanMountOffset,0]) color("lightgray") cyl(h=20,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
}

///////////////////////////////////////////////////////////////////////

module TaperedSpacer(Thickness,Screw=screw3,Quanity=1) { // spacer to move pc board off platform
	for(i = [0:Quanity-1]) {
		translate([0,i*10,0]) difference() {
			color("blue") hull() {
				translate([0,0,Thickness]) cylinder(h=1,d = Screw*1.5);
				translate([0,0,0]) cylinder(h=1,d = Screw*2.5);
			}
			translate([0,0,-2]) color("green") cylinder(h=Thickness+10,d = Screw);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module dueX25(Type=0) {
	if(Type) {
		duetoverhang(2);	// Duet 0.8.5 & DuetWiFi) puts i/o ports close the the outer edge of the 2020
		TaperedSpacer(,SpacerThickness,screw3,4); // put them in one of the vent holes
	} else
		TaperedSpacer(4,SpacerThickness,screw3,4); // put them in one of the vent holes
}

//////////////////////////////////////////////////////////////////////////////////////////////

module duet(FanNotch=0) {
	union() {
		platform(1); // 0 - don't add side fan mount holes; 1 - add side fan mount holes;
		mount(1);
		supports(0,FanNotch);
	}
	translate([17,25,0]) TaperedSpacer(SpacerThickness,screw3,4); // put them in one of the vent holes
}

//////////////////////////////////////////////////////////////////////////

module duetoverhang(FanNotch=2) {
	translate([0,20,0]) platform(0,1); // 0 - don't add side fan mount holes; 1 - add side fan mount holes;
	mountw(1);
	supports(1,FanNotch);
	translate([18,45,0]) TaperedSpacer(SpacerThickness,screw3,4); // put them in one of the vent holes
	translate([12,D085Length+12,PlatformThickness-1]) ms_tab(D085Width-25);
}

///////////////////////////////////////////////////////////////////////////////////////////////

module ms_tab(Width) {
	color("Navy") cube([Width,6,2]);
}

//////////////////////////////////////////////////////////////////////////

module duex4() {
	platform4(0); // 0 - don't add side fan mount holes; 1 - add side fan mount holes;
	mount4();
	supports4();
	TaperedSacer(SpacerThickness,screw3,4); // put them in one of the vent holes
}

///////////////////////////////////////////////////////////////////////

module fanmountside(Screw=Yes3mmInsert(Use3mmInsert,LargeInsert)) { // on side of platform
	color("white") cylinder(h=20,d=Screw);
	translate([0,FanPlatformMountOffset,0]) color("red") cylinder(h=20,d=Screw);
}

////////////////////////////////////////////////////////////////////////
module fanmountplatform(Screw=Yes3mmInsert(Use3mmInsert,LargeInsert)) {
	cylinder(h=20,d=Screw);
	translate([FanPlatformMountOffset,0,0]) cylinder(h=20,d=Screw);
}


//////////////////////////////////////////////////////////////////////

module platform(Side_fan = 0,over = 0,BottomFan=0) { // main platform
	difference() {
		translate([-5,-7,0]) color("cyan")
			cuboid([D085Width+10,D085Length+MountThickness+7,PlatformThickness],rounding=2,p1=[0,0]);
		translate([D085HoleOffset,D085HoleOffset-1,-1]) color("red")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([D085Width-D085HoleOffset,D085HoleOffset-1,-1]) color("white")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([D085Width-D085HoleOffset,D085Length-D085HoleOffset+0.5,-1]) color("blue")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([D085HoleOffset,D085Length-D085HoleOffset+0.5,-1]) color("gray")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		vents(over);
		translate([0,20-10,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
		if(Side_fan) {
			translate([-10,D085Length/2-FanPlatformMountOffset/2,PlatformThickness/2]) rotate([0,90,0])
				fanmountside(Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([D085Width-16,D085Length/2-FanPlatformMountOffset/2,PlatformThickness/2]) rotate([0,90,0])
				fanmountside(Yes3mmInsert(Use3mmInsert,LargeInsert));
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////

module platform3(Width,Length,HoleOffset) { // main platform
	%translate([0,0,-6]) cube([D3Width,D3Length,2]); // show duet location
	%translate([4,0,-1]) cube([D3Width-D3HoleOffset*2,5,7]); // check mount locations
	%translate([2,3.5,-1]) cube([5,D3Length-D3HoleOffset*2,7]);
	difference() {
		translate([-5,-7,0]) color("cyan") 
			cuboid([Width+10,Length+MountThickness+7,PlatformThickness],rounding=2,p1=[0,0]);
		PlatformScrewMounts(Yes3mmInsert(Use3mmInsert,LargeInsert),Width,Length,HoleOffset);
		vents3();
		translate([0,GetHoleLen3mm(Yes3mmInsert(Use3mmInsert,LargeInsert))-4,PlatformThickness/2]) rotate([90,0,0]) 
			fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([45,GetHoleLen3mm(Yes3mmInsert(Use3mmInsert,LargeInsert))-4,PlatformThickness/2]) rotate([90,0,0])
				fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module PlatformScrewMounts(Screw=Yes3mmInsert(Use3mmInsert,LargeInsert),Width,Length,HoleOffset) {
	translate([HoleOffset,HoleOffset-1,-1]) color("red") cylinder(h=PlatformThickness*2,d=Screw);
	translate([Width-HoleOffset,HoleOffset-1,-1]) color("black") cylinder(h=PlatformThickness*2,d=Screw);
	translate([Width-HoleOffset,Length-HoleOffset-0.5,-1]) color("blue") cylinder(h=PlatformThickness*2,d=Screw);
	translate([HoleOffset,Length-HoleOffset-0.5,-1]) color("gray") cylinder(h=PlatformThickness*2,d=Screw);
}

//////////////////////////////////////////////////////////////////////

module platform4(Side_fan = 0) { // main platform
	difference() {
		translate([-5,-5,0]) color("cyan") 
			cuboid([DueX4Width+10,DueX4length+MountThickness+5,PlatformThickness],p1=[0,0]);
		translate([DueX4HoleOffset1,DueX4HoleOffset1,-1]) color("red") cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([DueX4Width-DueX4HoleOffset3,DueX4HoleOffset2,-1]) color("white")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([DueX4Width-DueX4HoleOffset3,DueX4length-DueX4HoleOffset2+2,-1]) color("blue")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([DueX4HoleOffset1,DueX4length-DueX4HoleOffset1+2,-1]) color("gray")
			cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		vents4();
		translate([DueDueX4Width/2,GetHoleLen3mm(Yes3mmInsert(Use3mmInsert,LargeInsert)),PlatformThickness/2]) rotate([90,0,0])
			fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
		if(Side_fan) {
			translate([-10,DueX4length/2-FanPlatformMountOffset/2,PlatformThickness/2]) rotate([0,90,0])
				fanmountside(Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([DueDueX4Width-16,DueX4length/2-FanPlatformMountOffset/2,PlatformThickness/2])
				rotate([0,90,0]) fanmountside(Yes3mmInsert(Use3mmInsert,LargeInsert));
		}
	}
}

///////////////////////////////////////////////////////////////////////

module mount4() { // 2020 mount
	difference() {
		translate([0,DueX4length,0]) color("cyan")
			cuboid([DueX4Width,MountThickness,PortCoverHeight],rounding=2,p1=[0,0]);
		translate([15,DueX4length+7,10]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
		translate([DueX4Width-15,DueX4length+7,10]) rotate([90,0,0]) color("black") cylinder(h=MountThickness*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////

module vents(over = 0) { // vent holes in platform
	if(!over) {
		color("red") hull() {
			translate([D085Width/3-15.5,25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
			translate([D085Width/3-15.5,D085Length-25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
		}
		color("white") hull() {
			translate([2*(D085Width/3)-16.5,25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
			translate([2*(D085Width/3)-16.5,D085Length-25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
		}
		color("blue") hull() {
			translate([3*(D085Width/3)-17.5,25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
			translate([3*(D085Width/3)-17.5,D085Length-25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
		}
	} else {
		color("red") hull() {
			translate([D085Width/3-15,25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
			translate([D085Width/3-15,D085Length-35,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
		}
		color("white") hull() {
			translate([2*(D085Width/3)-16.5,25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
			translate([2*(D085Width/3)-16.5,D085Length-35,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
		}
		color("blue") hull() {
			translate([3*(D085Width/3)-18.3,25,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
			translate([3*(D085Width/3)-18.3,D085Length-35,-1]) cylinder(h=MountThickness*2,r=D085Width/9);
		}
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

module mount(center = 1) { // 2020 mount
	difference() {
		translate([0,D085Length,0]) color("gray") 
			cuboid([D085Width,MountThickness,PortCoverHeight],rounding=2,p1=[0,0]);
		if(center) translate([D085Width/2,D085Length+7,10]) rotate([90,0,0]) color("red") cylinder(h=MountThickness*2,r=screw5/2);
		translate([12,D085Length+7,10]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
		translate([D085Width-12,D085Length+7,10]) rotate([90,0,0]) color("blue") cylinder(h=MountThickness*2,r=screw5/2);
	}
}

///////////////////////////////////////////////////////////////////////

module mount3(Width,Length,HoleOffset,MSTab=0) { // 2020 mount
	difference() {
		translate([-5,Length,0]) color("gray") cuboid([Width+10,MountThickness,PortCoverHeight+8],rounding=2,p1=[0,0]);
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
		translate([0,D085Length,0]) color("gray") 
			cuboid([D085Width,MountThickness,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		if(center) translate([D085Width/2,D085Length+7,10+PlatformThickness]) rotate([90,0,0])
			color("red") cylinder(h=MountThickness*2,r=screw5/2);
		translate([12,D085Length+7,10+PlatformThickness]) rotate([90,0,0]) color("white") cylinder(h=MountThickness*2,r=screw5/2);
		translate([D085Width-12,D085Length+7,10+PlatformThickness]) rotate([90,0,0]) color("blue")
			cylinder(h=MountThickness*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////

module supports(over = 0, FanNotch=0) { // connects & support main platform
	if(!over) {
		difference() {
			translate([0.5,7,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
				color("cyan") cuboid([SupportThickness,D085Length,PortCoverHeight],rounding=2,p1=[0,0]);
			translate([4,4,-1]) color("red") cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([-1,3,-SupportThickness-19]) color("white") cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,20+5,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([D085HoleOffset,D085Length-D085HoleOffset+0.5,-1]) color("blue")
				cylinder(h=PlatformThickness*4,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([0,D085Length+4,0]) color("gray") cube([D085Width,10,PortCoverHeight+10]);
		}
		difference() {
			translate([D085Width-SupportThickness-0.5,7,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
				color("gray") cuboid([MountThickness,D085Length,PortCoverHeight],rounding=2,p1=[0,0]);
			translate([D085Width-4,4,-1]) color("cyan")
				cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([D085Width-SupportThickness-1,3,-SupportThickness-19]) color("red")
				cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([D085Width-D085HoleOffset,D085Length-D085HoleOffset+0.5,-1]) color("white")
				cylinder(h=PlatformThickness*4,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([0,D085Length+4,0]) color("pink") cube([D085Width,10,PortCoverHeight+10]);
		}
		difference() {
			translate([D085Width/3-SupportThickness/2,7,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
				color("blue") cuboid([MountThickness,D085Length,PortCoverHeight],rounding=2,p1=[0,0]);
			translate([D085Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("red")
				cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,20+5,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([0,D085Length+4,0]) color("white") cube([D085Width,10,PortCoverHeight+10]);
		}
		difference() {
			translate([D085Width/3+D085Width/3-SupportThickness/2,7,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
				color("black") cuboid([MountThickness,D085Length,PortCoverHeight],rounding=2,p1=[0,0]);
			translate([D085Width/3+D085Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("red")
				cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,D085Length+4,0]) color("yellow") cube([D085Width,10,PortCoverHeight+10]);
		}
	} else {
		difference() {
			translate([0.5,29,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
				color("pink") cuboid([SupportThickness,D085Length-20,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
			translate([0,20+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([-2,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,D085Length+4,0]) color("white") cube([D085Width,10,PortCoverHeight+10]);
		}
		difference() {
			translate([D085Width-SupportThickness-0.5,29,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
				color("red") cuboid([MountThickness,D085Length-20,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
			translate([D085Width-SupportThickness-2,3,-SupportThickness-19]) color("black")
				cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,D085Length+4,0]) color("white") cube([D085Width,10,PortCoverHeight+10]);
		}
		difference() {
			translate([D085Width/3-SupportThickness/2,29,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
				color("blue") cuboid([MountThickness,D085Length-20,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
			translate([0,20+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
			translate([D085Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("white")
				cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,D085Length+4,0]) color("red") cube([D085Width,10,PortCoverHeight+10]);
		}
		difference() {
			translate([D085Width/3+D085Width/3-SupportThickness/2,29,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
				color("purple") cuboid([MountThickness,D085Length-20,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
			translate([D085Width/3+D085Width/3-SupportThickness/2-1,3,-SupportThickness-19]) color("cyan")
				cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
			translate([0,D085Length+4,0]) color("white") cube([D085Width,10,PortCoverHeight+10]);
		}
	}
}

//////////////////////////////////////////////////////////////////////

module supports3(Width,Length,HoleOffset) { // connects & support main platform
	difference() {
		translate([0.5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("pink") cuboid([SupportThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,20+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([-2,3,-SupportThickness-19]) color("cyan") cube([MountThickness+5,D085Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width-SupportThickness+1.5,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("red") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([Width-SupportThickness-2,3,-SupportThickness-19]) color("black")
			cube([MountThickness+5,Length+5,PortCoverHeight+5]);
		translate([-5,Length+4.8,0]) color("white") cube([Width+10,10,PortCoverHeight+10]);
	}
	difference() {
		translate([Width/3-SupportThickness/2,19,-PortCoverHeight+SupportThickness-3]) rotate([10,0,0])
			color("blue") cuboid([MountThickness,Length-10,PortCoverHeight+PlatformThickness],rounding=2,p1=[0,0]);
		translate([0,20+20,PlatformThickness/2]) rotate([90,0,0]) fanmountplatform(Yes3mmInsert(Use3mmInsert,LargeInsert));
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

module supports4() { // connects & support main platform
	difference() {
		translate([0,5,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
			color("red") cuboid([SupportThickness,DueX4length,PortCoverHeight],rounding=2,p1=[0,0]);
		translate([4,4,-1]) color("white") cylinder(h=PlatformThickness*2,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
		translate([-1,3,-SupportThickness-19]) color("blue") cube([MountThickness+5,DueX4length+5,PortCoverHeight+5]);
		translate([D085HoleOffset,DueX4length-D085HoleOffset+2,-1])
			color("black") cylinder(h=PlatformThickness*4,d=Yes3mmInsert(Use3mmInsert,LargeInsert));
	}
	difference() {
		translate([DueX4Width-SupportThickness,5,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
			color("cyan") cuboid([MountThickness,DueX4length,PortCoverHeight],rounding=2,p1=[0,0]);
		translate([DueX4Width-SupportThickness-1,3,-SupportThickness-19]) color("salmon")
			cube([MountThickness+5,DueX4length+5,PortCoverHeight+5]);
	}
	difference() {
		translate([DueX4Width/2-SupportThickness/2,5,-PortCoverHeight+SupportThickness]) rotate([7,0,0])
			color("aqua") cuboid([MountThickness,D085Length,PortCoverHeight],rounding=2,p1=[0,0]);
		translate([DueX4Width/2-SupportThickness/2-1,3,-SupportThickness-19]) color("pink")
			cube([MountThickness+5,DueX4length+5,PortCoverHeight+5]);
	}
}

//////////////////////////////////////////////////////////////////////

module vents4() { // vent holes in platform
	
	hull() {
		translate([DueX4Width/2-18,25,-1]) color("red") cylinder(h=MountThickness*2,r=DueX4Width/6);
		translate([DueX4Width/2-18,DueX4length-25,-1]) color("white") cylinder(h=MountThickness*2,r=DueX4Width/6);
	}
	hull() {
		translate([2*(DueX4Width/2)-20,25,-1]) color("blue") cylinder(h=MountThickness*2,r=DueX4Width/6);
		translate([2*(DueX4Width/2)-20,DueX4length-25,-1]) color("green") cylinder(h=MountThickness*2,r=DueX4Width/6);
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// portcover vars
PHeight = 30;	// height of port cover
PThick = 4;		// thickness of port cover
Bgap = PCSpacerThickness + 1.5; // distance from bottom of platform to top of pc board
// ??gap is actual distance + 4
Lgap = 12;			// distance from left edge of platform to the left most led
Egap = 33.5; 		// to erase button
Rgap = 41.8;		// to reset button
Ugap = 46.5;		// to usb port
SDgap = 59.6;		// to microsd card
Ethgap = 80;		// to ethernet port
Wgap = 77;			// to wifi antennae - to be determined
Wdepth = 8;			// how far wifi antenna sticks out + 2
Wwidth = 18;		// width of wifi antenna + 2
Wheight = 0;		// height of wifi antenna above the board
Wthickness = 3;		// thickness of the wifi antenna + clearance
ResetHole = 1.5;	// size of reset button hole
EraseHole = 1.5;	// size of erase button hole
ButtonHole = 4;		// erase & reset button clearance on back
D2EthernetX=SDgap;
D2EthernetY=10.7;
//---------------------------------------------------------------------------------------

module portcover(Board=0,D2EthX,D2EthY,Width,Length,HoleOffset) { // i/o port cover for the duet 085 & Duet 2, & Duet 3
	echo(Board);
	rotate([90,0,0]) {
		if(Board==0) { // Duet 2 ethernet
			difference() {
				color("cyan") cuboid([D085Width+10,PHeight,PThick],rounding=2,p1=[0,0]);
				translate([Ethgap,Bgap,-2]) color("red") cube([16,14,10]);
				// sd
				translate([SDgap,Bgap,-2]) color("blue") cube([14,3,10]);
				// usb
				translate([Ugap,Bgap,-2]) color("black") cube([9,4,10]);
				// reset
				translate([Rgap,Bgap+ResetHole/4,-2]) color("salmon") cylinder(h=PlatformThickness*2,d=ResetHole);
				translate([Rgap,Bgap+ResetHole/4,-3.5]) color("teal")
					cylinder(h=PlatformThickness,d=ButtonHole); // button clearance
				// erase
				translate([Egap,Bgap+EraseHole/4,-2]) color("skyblue") cylinder(h=PlatformThickness*2,d=EraseHole);
				translate([Egap,Bgap+EraseHole/4,-3.5])
					color("powderblue") cylinder(h=PlatformThickness,d=ButtonHole); // button clearance
				portfingernotches();
			}
			// label the erase & reset holes
			translate([Rgap-1.5,Bgap+2,PlatformThickness-0.9]) printchar("R");
			translate([Egap-1.5,Bgap+2,PlatformThickness-0.9]) printchar("E");
			mounting_base(Width,Length,HoleOffset);
		} else if(Board==2) { // Duet 2 WiFi
			difference() {
				color("cyan") cuboid([D085Width+10,PHeight,PThick],rounding=2,p1=[0,0]);
				translate([Wgap,Bgap+Wheight,-2]) color("pink") cube([Wwidth,Wthickness,Wdepth+2]);
				// sd
				translate([SDgap,Bgap,-2]) color("blue") cube([14,3,10]);
				// usb
				translate([Ugap,Bgap,-2]) color("black") cube([9,4,10]);
				// reset
				translate([Rgap,Bgap+ResetHole/4,-2]) color("salmon") cylinder(h=PlatformThickness*2,d=ResetHole);
				translate([Rgap,Bgap+ResetHole/4,-3.5]) color("teal")
					cylinder(h=PlatformThickness,d=ButtonHole); // button clearance
				// erase
				translate([Egap,Bgap+EraseHole/4,-2]) color("skyblue") cylinder(h=PlatformThickness*2,d=EraseHole);
				translate([Egap,Bgap+EraseHole/4,-3.5])
					color("powderblue") cylinder(h=PlatformThickness,d=ButtonHole); // button clearance
				// lights
				translate([Lgap,Bgap,-2]) color("coral") cube([18,3,10]);
				translate([Lgap,Bgap-2,-2]) rotate([-35,0,0]) color("wheat") cube([18,3,10]); // give a bit more viewing angle
				// -----
				portfingernotches();
			}
			// label the erase & reset holes
			translate([Rgap-1.5,Bgap+2,PlatformThickness-0.9]) printchar("R");
			translate([Egap-1.5,Bgap+2,PlatformThickness-0.9]) printchar("E");
			mounting_base(Width,Length,HoleOffset);
		} else if(Board==3) { // Duet 3
			difference() {
				color("cyan") cuboid([Width+10,PHeight,PThick],rounding=2,p1=[0,0]);
				// ethernet
				translate([D2EthernetX,D2EthernetY,-4]) color("blue") cube([14,14,10]);
				// sd
				translate([SDgap,Bgap,-2]) color("blue") cube([14,3,10]);
				// usb
				translate([Ugap,Bgap,-2]) color("black") cube([9,4,10]);
				// reset
				translate([Rgap,Bgap+ResetHole/4,-2]) color("salmon") cylinder(h=PlatformThickness*2,d=ResetHole);
				translate([Rgap,Bgap+ResetHole/4,-3.5]) color("teal")
					cylinder(h=PlatformThickness,d=ButtonHole); // button clearance
				// erase
				translate([Egap,Bgap+EraseHole/4,-2]) color("skyblue") cylinder(h=PlatformThickness*2,d=EraseHole);
				translate([Egap,Bgap+EraseHole/4,-3.5])
					color("powderblue") cylinder(h=PlatformThickness,d=ButtonHole); // button clearance
				// lights
				translate([Lgap,Bgap,-2]) color("coral") cube([18,3,10]);
				translate([Lgap,Bgap-2,-2]) rotate([-35,0,0]) color("wheat")
					cube([18,3,10]); // give a bit more viewing angle
				// -----
				portfingernotches();
			}
			mounting_base(Width,Length,HoleOffset);
			translate([Rgap-1.5,Bgap+2,PlatformThickness-0.9]) printchar("R");
			translate([Egap-1.5,Bgap+2,PlatformThickness-0.9]) printchar("E");
		}
		if(Board==2) wificover(); // cover for the wifi antenna
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module mounting_base(Width,Length,HoleOffset) {
	rotate([-90,0,0]) difference() {	// mounting base, it replaces the two spacers on the i/o port end
		translate([1,-3,0]) color("purple") cuboid([Width+8,11,PCSpacerThickness],p1=[0,0]);
		translate([3.5,HoleOffset,0]) portcovermountholes(Width,HoleOffset);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module wificover() { // cover for the wifi antenna
	difference() {
		translate([Wgap-2,Bgap-2+Wheight,0]) color("yellow") cuboid([Wwidth+4,Wthickness+4,Wdepth+2],rounding=2,p1=[0,0]);
		translate([Wgap,Bgap+Wheight,0]) color("gray") cube([Wwidth,Wthickness,Wdepth]);
	}
	wifisupport();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////


module wifisupport() { // print support for the cover for the wifi antenna
	translate([Wgap-0.2,0,Wdepth]) color("green") cube([Wwidth+0.4,Wheight+5,NozzleDiameter]);
	translate([Wgap-0.2,0,NozzleDiameter+3.7]) color("yellowgreen") cube([NozzleDiameter,Wheight+5,Wdepth-4]);
	translate([Wgap+NozzleDiameter+Wwidth-0.6,0,NozzleDiameter+3.7]) color("springgreen")
		cube([NozzleDiameter,Wheight+5,Wdepth-4]);
}

//////////////////////////////////////////////////////////////////////////////////////////

module portfingernotches() { // finger access to microsd slot and let a cable plug into the usb
	translate([SDgap-1.8,Bgap-2.5,0.75]) color("darkseagreen") 
		cuboid([17.2,12,5],p1=[0,0]);	// finger notch to reach microsd card
	translate([Ugap-1.6,Bgap-2.5,0.75]) color("darkcyan") cuboid([12.5,9,5],p1=[0,0]);	// notch so usb cable can plug in
}

/////////////////////////////////////////////////////////////////////////////////////////

module portcovermountholes(Width,Hole_Offset,Screw=screw3+0.5) {  // mounting holes to platform, add a bit to Screw for more room
	translate([Hole_Offset,0,-1]) color("red") cylinder(h=PlatformThickness*2,d=Screw);
	translate([Width-Hole_Offset,0,-1]) color("black") cylinder(h=PlatformThickness*2,d=Screw);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

module printchar(String) { // print something
	color("darkgray") linear_extrude(height = 1) text(String, font = "Liberation Sans",size=3.5);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module blower_adapter(blower_h,blower_w,blower_m_dist,Shift=0) { // to use a 50mm 10x15 blower instead of a 40mm axial
	difference() {
		color("cyan") cuboid([FanMountOffset+10,blower_w+10.5+Shift,PlatformThickness+1],p1=[0,0]);
		translate([blower_h/2,PlatformThickness+Shift,-2]) color("white") cube([blower_h,blower_w,10]);
		BlowerAdapterScrew();
	}
	difference() {
		translate([21,Shift-1.5,0]) color("black") cuboid([screw4+4,screw4+1,blower_m_dist+screw4+1],rounding=2,p1=[0,0]);
		translate([screw4/2+23,screw4+blower_w+6+Shift,blower_m_dist]) rotate([90,0,0]) {
			if(Use4mmInsert) {
				color("white") cylinder(h=30,d=Yes3mmInsert(Use4mmInsert));
			} else {
				color("white") cylinder(h=30,d=screw4);
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module blower_adapter2(blower_h,blower_w,blower_m_dist,Shift=0) { // to use a 50mm 10x15 blower instead of a 40mm axial
	difference() {
		color("cyan") cuboid([FanMountOffset+10,blower_w+10.5+Shift,PlatformThickness+1],p1=[0,0]);
		translate([blower_h/2,PlatformThickness+Shift,-2]) color("white") cube([blower_h,blower_w,10]);
		translate([0,20,0]) BlowerAdapterScrew();
	}
	difference() {
		translate([10,Shift+20,0]) color("black") cuboid([screw4+4,screw4+1,blower_m_dist+screw4+1],rounding=2,p1=[0,0]);
		translate([screw4/2+12,screw4+blower_w+10+Shift,blower_m_dist]) rotate([90,0,0]) {
			if(Use4mmInsert) {
				color("white") cylinder(h=30,d=Yes3mmInsert(Use4mmInsert));
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

//////////////////// end of duet2020.scad ////////////////////////////////////////////////////////////
