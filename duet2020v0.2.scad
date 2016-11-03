//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// duet2020.scad - mount a duet to 2020 extrusion
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 5/5/2016
// last update 10/25/2016
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 5/22/16 Added DueX4 board and a simple covers for the Duet & DueX4
// 6/26/16 Added overhang version where it places the board out over the 2020 it mounts on
// 7/8/16  Redesigned the simple covers to be simpler, they just mount to 2020
//         Added a i/o port cover
// 8/9/16  Added a 40mm fan mount to blow directly on the bottom of the stepper section
//		   Changed spacer thickness to 5 from 3, for better cooling underneath
//		   Added protective cover for the wifi antenna, uses nozzle_diameter to set thickness
//		   of the support for it
//		   Added an adapter to use a 10x15 50mm blower instead of a 40mm axial fan
// 8/15/16 Added vars for wifi antenna size and position
// 9/5/16  Tweaked board position in duetoverhang() to have mounting screws go into 2020 slot
// 9/10/16 Received the DuetWifi and adjusted the antenna hole
// 10/25/16 DueX2 & DueX5 info released, mouning holes same as DuetWifi, print and use a set of 5mm spacers
//			to mount them back to back.  Will need longer spacers between X board and mount
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Demensions from:
// Duet 0.8.5: http://reprap.org/wiki/Duet#Dimensions
// DueX4: http://reprap.org/wiki/Duex4#Dimensions
// DuetWifi: https://duet3d.com/wiki/Mounting_and_cooling_the_board#Mounting
// DueX2 & DueX5: https://duet3d.com/wiki/DueX2_and_DueX5_expansion_boards
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// I/O port cover vars are next to portcover()
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tap the board screw holes with a 3mm tap
// The i/o port cover mounts in place of the spacers at the i/o port end
// Cover mounts to a 2020 that's above the one the board mounts on
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NOTES: DueX4 board dimensions are untested, don't have one.
//		  DueX2 & DueX not tested, don't have one.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// includes
include <inc/screwsizes.scad>
use <inc/cubeX.scad> // http://www.thingiverse.com/thing:112008
$fn=50;		// 100 takes a long, long time to render
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// vars
////////////////////////////////////////////////////////////////////////////////////////////////////////////
bwidth = 100;	// Duet 0.85 info from http://reprap.org/wiki/Duet
blength = 123;	// rounded up from original 129.999
hole_offset = 4;	// all four holes are at the corners
x4width = 77.409; // duex4 size from http://reprap,org/wiki/duex4
x4length = 123;
x4hole_offset1 = 4;	// DueX4 mounting hole offsets from DueX4 wiki page
x4hole_offset2 = 3.048;
x4hole_offset3 = 12.131;
bthick = 4; // thickness of platform
mthick = 5; // thickness of mount
sthick = 5; // thickness of supports
pcsthick = 5; // thickness of the pc board spacers
mheight = 20;	// height of mount
fan_support = 32; // 32 for 40mm fan
screwfan_support = screw3t; // screw size for fan
fan_platform = 32; // 32 for 40mm fan
screwfan_platform = screw3t; // screw hole tap size for fan mounting
//								if you need a bigger hole, don't forget to increase bthick
screw_platform = 20;	// depth of screw hole
nozzle_diameter = 0.4;	// hotend nozzle size for wifi protection support, if you change this
//						   check the position of the support pieces
dueX_spacer = 10;	// thickness of spacer for DueX2&5 boards for the components to clear platform
/////////////////////////////////////////////////////////////////////////////////////////////////////////

//all(1,2);	// 1st arg: 0-duet&port cover;1-overhang duet&port cover
			//			2-duet& wifi port cover;3-overhang duet & wifi port cover
			// 2nd arg: bottom fan mount: 0-column,1-notched,2-none
partial();

/////////////////////////////////////////////////////////////////////////////////////////////////////////

module all(WhichOne,FanNotch) {
	if(WhichOne==0) { // Duet 085 & cover
		// for duet() & duetoverhang() bottom fan mount: 0-column,1-notched,2-none
		duet(FanNotch);	// Duet 0.8.5 & DuetWiFi
		translate([0,-20,0]) portcover(0); // 0 = Duet 0.8.5; 1 - DuetWiFi (not tested)
	}
	if(WhichOne==1) { // Overhang Duet 085 & cover
		duetoverhang(FanNotch);	// Duet 0.8.5 (maybe DuetWiFi) puts i/o ports close the the outer edge of the 2020
		portcover(0); // 0 = Duet 0.8.5; 1 - DuetWiFi (not tested)
	}
	if(WhichOne==2) { // DuetWifi & cover
		duet(FanNotch);	// Duet 0.8.5 & DuetWiFi
		translate([0,-20,0]) portcover(1); // 0 = Duet 0.8.5; 1 - DuetWiFi (not tested)
	}
	if(WhichOne==3) { // Overhang Duet 085 & cover
		duetoverhang(FanNotch);	// Duet 0.8.5 (maybe DuetWiFi) puts i/o ports close the the outer edge of the 2020
		portcover(1); // 0 = Duet 0.8.5; 1 - DuetWiFi (not tested)
	}
	translate([0,-35,0]) blower_adapter(20,15,48,0); // args: height, width, mounting screw height, shift up
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module partial() {
	// for duet() & duetoverhang() bottom fan mount: 0-column,1-notched,2-none
	//duet(2);	// Duet 0.8.5 & DuetWiFi
	//duetoverhang(2);	// Duet 0.8.5 & DuetWiFi puts i/o ports close the the outer edge of the 2020
	//duex4();	// DueX4 expansion board
	//dueX25(0); //  0 - does just the spacers, 1 - include board platform
	//cover();	// something to keep stuff from falling on the exposed board
	//coverx4();
	//translate([0,-20,0]) // use with duet() for port cover
	//	portcover(0); // 0 = Duet 0.8.5; 1 - DuetWiFi
	//translate([0,-35,0])
		blower_adapter(20,15,48);
}

//////////////////////////////////////////////////////////////////////

module dueX25(Type=0) {
	if(Type) {
		duetoverhang(2);	// Duet 0.8.5 & DuetWiFi) puts i/o ports close the the outer edge of the 2020
		translate([50,40,0]) spacer(dueX_spacer); // put them in one of the vent holes
		translate([50,50,0]) spacer(dueX_spacer); // put them in one of the vent holes
		translate([50,60,0]) spacer(dueX_spacer); // put them in one of the vent holes
		translate([50,70,0]) spacer(dueX_spacer); // put them in one of the vent holes
	} else {
		translate([0,0,0]) spacer(dueX_spacer); // put them in one of the vent holes
		translate([0,10,0]) spacer(dueX_spacer); // put them in one of the vent holes
		translate([0,20,0]) spacer(dueX_spacer); // put them in one of the vent holes
		translate([0,30,0]) spacer(dueX_spacer); // put them in one of the vent holes
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////

module duet(FanNotch=2) {
	platform(0); // 0 - don't add side fan mount holes; 1 - add side fan mount holes;
	mount(1);
	supports(0,FanNotch);
	translate([20,30,0]) spacer(); // put them in one of the vent holes
	translate([20,40,0]) spacer(); // put them in one of the vent holes
	translate([20,50,0]) spacer(); // put them in one of the vent holes
	translate([20,60,0]) spacer(); // put them in one of the vent holes
}

//////////////////////////////////////////////////////////////////////////

module duetoverhang(FanNotch=2) {
	translate([0,20,0]) platform(0,1); // 0 - don't add side fan mount holes; 1 - add side fan mount holes;
	mountw(1);
	supports(1,FanNotch);
	translate([20,40,0]) spacer(); // put them in one of the vent holes
	translate([20,50,0]) spacer(); // put them in one of the vent holes
	translate([20,60,0]) spacer(); // put them in one of the vent holes
	translate([20,70,0]) spacer(); // put them in one of the vent holes
	translate([12,blength+12,bthick-1]) ms_tab(bwidth-25);
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
	translate([20,30,0]) spacer(); // put them in one of the vent holes
	translate([20,40,0]) spacer(); // put them in one of the vent holes
	translate([20,50,0]) spacer(); // put them in one of the vent holes
	translate([20,60,0]) spacer(); // put them in one of the vent holes
}

///////////////////////////////////////////////////////////////////////

module fanmountside() { // on side of platform
	cylinder(h=screw_platform+5,r=screwfan_platform/2);
	translate([0,fan_platform,0]) cylinder(h=screw_platform+5,r=screwfan_platform/2);
}

////////////////////////////////////////////////////////////////////////
module fanmountplatform() {
	cylinder(h=screw_platform+5,r=screwfan_platform/2);
	translate([fan_platform,0,0]) cylinder(h=screw_platform+5,r=screwfan_platform/2);
}

///////////////////////////////////////////////////////////////////////

module spacer(HSpc=pcsthick) { // spacer to move pc board off platform
	difference() {
		cylinder(h=HSpc,r = screw3);
		translate([0,0,-1]) cylinder(h=HSpc*2,r = screw3/2);
	}
}

//////////////////////////////////////////////////////////////////////

module platform(Side_fan = 0,over = 0) { // main platform
	difference() {
		translate([-5,-7,0]) cubeX([bwidth+10,blength+mthick+7,bthick],2);
		translate([hole_offset,hole_offset-1,-1]) cylinder(h=bthick*2,r=screw3t/2);
		translate([bwidth-hole_offset,hole_offset-1,-1]) cylinder(h=bthick*2,r=screw3t/2);
		translate([bwidth-hole_offset,blength-hole_offset+0.5,-1]) cylinder(h=bthick*2,r=screw3t/2);
		translate([hole_offset,blength-hole_offset+0.5,-1]) cylinder(h=bthick*2,r=screw3t/2);
		vents(over);
		translate([0,screw_platform-4,bthick/2]) rotate([90,0,0]) fanmountplatform();
		if(Side_fan) {
			translate([-10,blength/2-fan_platform/2,bthick/2]) rotate([0,90,0]) fanmountside();
			translate([bwidth-16,blength/2-fan_platform/2,bthick/2]) rotate([0,90,0]) fanmountside();
		}
	}
}

//////////////////////////////////////////////////////////////////////

module platform4(Side_fan = 0) { // main platform
	difference() {
		translate([-5,-5,0]) cubeX([x4width+10,x4length+mthick+5,bthick]);
		translate([x4hole_offset1,x4hole_offset1,-1]) cylinder(h=bthick*2,r=screw3t/2);
		translate([x4width-x4hole_offset3,x4hole_offset2,-1]) cylinder(h=bthick*2,r=screw3t/2);
		translate([x4width-x4hole_offset3,x4length-x4hole_offset2+2,-1]) cylinder(h=bthick*2,r=screw3t/2);
		translate([x4hole_offset1,x4length-x4hole_offset1+2,-1]) cylinder(h=bthick*2,r=screw3t/2);
		vents4();
		translate([x4width/2,screw_platform,bthick/2]) rotate([90,0,0]) fanmountplatform();
		if(Side_fan) {
			translate([-10,x4length/2-fan_platform/2,bthick/2]) rotate([0,90,0]) fanmountside();
			translate([x4width-16,x4length/2-fan_platform/2,bthick/2]) rotate([0,90,0]) fanmountside();
		}
	}
}

///////////////////////////////////////////////////////////////////////

module mount4() { // 2020 mount
	difference() {
		translate([0,x4length,0]) cubeX([x4width,mthick,mheight],2);
		translate([15,x4length+7,10]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
		translate([x4width-15,x4length+7,10]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////

module vents(over = 0) { // vent holes in platform
	if(!over) {
		hull() {
			translate([bwidth/3-15.5,25,-1]) cylinder(h=mthick*2,r=bwidth/9);
			translate([bwidth/3-15.5,blength-25,-1]) cylinder(h=mthick*2,r=bwidth/9);
		}
		hull() {
			translate([2*(bwidth/3)-16.5,25,-1]) cylinder(h=mthick*2,r=bwidth/9);
			translate([2*(bwidth/3)-16.5,blength-25,-1]) cylinder(h=mthick*2,r=bwidth/9);
		}
		hull() {
			translate([3*(bwidth/3)-17.5,25,-1]) cylinder(h=mthick*2,r=bwidth/9);
			translate([3*(bwidth/3)-17.5,blength-25,-1]) cylinder(h=mthick*2,r=bwidth/9);
		}
	} else {
		hull() {
			translate([bwidth/3-15,25,-1]) cylinder(h=mthick*2,r=bwidth/9);
			translate([bwidth/3-15,blength-35,-1]) cylinder(h=mthick*2,r=bwidth/9);
		}
		hull() {
			translate([2*(bwidth/3)-16.5,25,-1]) cylinder(h=mthick*2,r=bwidth/9);
			translate([2*(bwidth/3)-16.5,blength-35,-1]) cylinder(h=mthick*2,r=bwidth/9);
		}
		hull() {
			translate([3*(bwidth/3)-18.3,25,-1]) cylinder(h=mthick*2,r=bwidth/9);
			translate([3*(bwidth/3)-18.3,blength-35,-1]) cylinder(h=mthick*2,r=bwidth/9);
		}
	}
}

///////////////////////////////////////////////////////////////////////

module mount(center = 1) { // 2020 mount
	difference() {
		translate([0,blength,0]) cubeX([bwidth,mthick,mheight],2);
		if(center) translate([bwidth/2,blength+7,10]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
		translate([12,blength+7,10]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
		translate([bwidth-12,blength+7,10]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
	}
}

///////////////////////////////////////////////////////////////////////

module mountw(center = 1) { // 2020 mount
	difference() {
		translate([0,blength,0]) cubeX([bwidth,mthick,mheight+bthick],2);
		if(center) translate([bwidth/2,blength+7,10+bthick]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
		translate([12,blength+7,10+bthick]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
		translate([bwidth-12,blength+7,10+bthick]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////

module supports(over = 0, FanNotch=0) { // connects & support main platform
	if(!over) {
		fanonsupportleveler(FanNotch);
		difference() {
			translate([0.5,7,-mheight+sthick]) rotate([7,0,0]) cubeX([sthick,blength,mheight],2);
			translate([4,4,-1]) cylinder(h=bthick*2,r=screw3/2);
			translate([-1,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,screw_platform+5,bthick/2]) rotate([90,0,0]) fanmountplatform();
			translate([hole_offset,blength-hole_offset+0.5,-1]) cylinder(h=bthick*4,r=screw3/2);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
			fanonsupport(FanNotch);
			fanonsupportnotch(FanNotch);
		}
		difference() {
			translate([bwidth-sthick-0.5,7,-mheight+sthick]) rotate([7,0,0]) cubeX([mthick,blength,mheight],2);
			translate([bwidth-4,4,-1]) cylinder(h=bthick*2,r=screw3/2);
			translate([bwidth-sthick-1,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([bwidth-hole_offset,blength-hole_offset+0.5,-1]) cylinder(h=bthick*4,r=screw3/2);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
		}
		difference() {
			translate([bwidth/3-sthick/2,7,-mheight+sthick]) rotate([7,0,0]) cubeX([mthick,blength,mheight],2);
			translate([bwidth/3-sthick/2-1,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,screw_platform+5,bthick/2]) rotate([90,0,0]) fanmountplatform();
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
			fanonsupportnotch(FanNotch);
		}
		difference() {
			translate([bwidth/3+bwidth/3-sthick/2,7,-mheight+sthick]) rotate([7,0,0]) cubeX([mthick,blength,mheight],2);
			translate([bwidth/3+bwidth/3-sthick/2-1,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
		}
	} else {
		fanonsupportleveler(FanNotch);
		difference() {
			translate([0.5,29,-mheight+sthick-3]) rotate([10,0,0]) cubeX([sthick,blength-20,mheight+bthick],2);
			//translate([4,24,-1]) cylinder(h=bthick*2,r=screw3/2);
			translate([0,screw_platform+20,bthick/2]) rotate([90,0,0]) fanmountplatform();
			translate([-2,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
			fanonsupport(FanNotch);
			fanonsupportnotch(FanNotch);
		}
		difference() {
			translate([bwidth-sthick-0.5,29,-mheight+sthick-3]) rotate([10,0,0]) cubeX([mthick,blength-20,mheight+bthick],2);
			//translate([bwidth-4,24,-1]) cylinder(h=bthick*2,r=screw3/2);
			translate([bwidth-sthick-2,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
		}
		difference() {
			translate([bwidth/3-sthick/2,29,-mheight+sthick-3]) rotate([10,0,0]) cubeX([mthick,blength-20,mheight+bthick],2);
			translate([0,screw_platform+20,bthick/2]) rotate([90,0,0]) fanmountplatform();
			translate([bwidth/3-sthick/2-1,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
			fanonsupportnotch(FanNotch);
		}
		difference() {
			translate([bwidth/3+bwidth/3-sthick/2,29,-mheight+sthick-3]) rotate([10,0,0]) cubeX([mthick,blength-20,mheight+bthick],2);
			translate([bwidth/3+bwidth/3-sthick/2-1,3,-sthick-19]) cube([mthick+5,blength+5,mheight+5]);
			translate([0,blength+4,0]) cube([bwidth,10,mheight+10]);
		}
	}
//translate([21,blength-(blength/2)+16,0]) cylinder(h=10,d1=20,d2=40);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanonsupport(NotchIt=0) {
	if(NotchIt != 2) {
		translate([3,blength-(blength/2),-5]) cylinder(h=screw_platform+5,r=screwfan_platform/2);
		translate([3,fan_support+blength-(blength/2),-5]) cylinder(h=screw_platform+5,r=screwfan_platform/2);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanonsupportleveler(NotchIt=0) {
	if(NotchIt==0) {
		difference() {
			translate([3,blength-(blength/2),0]) cylinder(h=screw_platform-5,r=screwfan_platform-0.1);
			translate([3,blength-(blength/2),-5]) cylinder(h=screw_platform+5,r=screwfan_platform/2);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module fanonsupportnotch(NotchIt=0) {
	if(NotchIt==1) {
		translate([0,blength-(blength/2)-6,10]) cube([45,45,20]);
translate([21,blength-(blength/2)+16,0.5]) cylinder(h=10,d1=10,d2=40);
	}
}

//////////////////////////////////////////////////////////////////////

module supports4() { // connects & support main platform
	difference() {
		translate([0,5,-mheight+sthick]) rotate([7,0,0]) cubeX([sthick,x4length,mheight],2);
		translate([4,4,-1]) cylinder(h=bthick*2,r=screw3/2);
		translate([-1,3,-sthick-19]) cube([mthick+5,x4length+5,mheight+5]);
		translate([hole_offset,x4length-hole_offset+2,-1]) cylinder(h=bthick*4,r=screw3/2);
	}

	difference() {
		translate([x4width-sthick,5,-mheight+sthick]) rotate([7,0,0]) cubeX([mthick,x4length,mheight],2);
		translate([x4width-sthick-1,3,-sthick-19]) cube([mthick+5,x4length+5,mheight+5]);
	}
	difference() {
		translate([x4width/2-sthick/2,5,-mheight+sthick]) rotate([7,0,0]) cubeX([mthick,blength,mheight],2);
		translate([x4width/2-sthick/2-1,3,-sthick-19]) cube([mthick+5,x4length+5,mheight+5]);
	}
}

//////////////////////////////////////////////////////////////////////

module vents4() { // vent holes in platform
	
	hull() {
		translate([x4width/2-18,25,-1]) cylinder(h=mthick*2,r=x4width/6);
		translate([x4width/2-18,x4length-25,-1]) cylinder(h=mthick*2,r=x4width/6);
	}
	hull() {
		translate([2*(x4width/2)-20,25,-1]) cylinder(h=mthick*2,r=x4width/6);
		translate([2*(x4width/2)-20,x4length-25,-1]) cylinder(h=mthick*2,r=x4width/6);
	}
}

////////////////////////////////////////////////////////////////////

module cover() { // cover for main platform - mounts on 2020
//	difference() {
//		cubeX([bwidth+10,blength+mthick+35,bthick],2);
//		translate([12,blength+25,-1]) cylinder(h=mthick*2,r=screw5/2);
//		translate([bwidth-12,blength+25,-1]) cylinder(h=mthick*2,r=screw5/2);
//	}
	cubeX([bwidth+10,blength+mthick+35,bthick],2);
	difference() {
		cubeX([bwidth+10,bthick,20+bthick],2);
		translate([20,bthick+1,10+bthick]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
		translate([bwidth-10,bthick+1,10+bthick]) rotate([90,0,0]) cylinder(h=mthick*2,r=screw5/2);
	}
	
}

/////////////////////////////////////////////////////////////////////

module coverx4() { // cover for main platform - mounts on 2020
	difference() {
		cubeX([x4width+10,x4length+mthick+35,bthick],2);
		translate([12,x4length+25,-1]) cylinder(h=mthick*2,r=screw5/2);
		translate([x4width-5,blength+25,-1]) cylinder(h=mthick*2,r=screw5/2);
	}
}

//////////////////////////////////////////////////////////////////////////////////////
// portcover vars
PHeight = 30;	// height of port cover
PThick = 4;		// thickness of port cover
Bgap = pcsthick + 1.5; // distance from bottom of platform to top of pc board
// ??gap is actual distance + 4
Lgap = 12;	// distance from left edge of platform to the left most led
Egap = 33.5; // to erase button
Rgap = 41.8;	// to reset button
Ugap = 46.5;		// to usb port
SDgap = 59.6;	// to microsd card
Ethgap = 80;	// to ethernet port
Wgap = 77;		// to wifi antennae - to be determined
Wdepth = 8;		// how far wifi antenna sticks out + 2
Wwidth = 18;	// width of wifi antenna + 2
Wheight = 0;	// height of wifi antenna above the board
Wthickness = 3;	// thickness of the wifi antenna + clearance
ResetHole = 1.5; //screw3t-0.6;	// size of reset button hole
EraseHole = 1.5; //screw3t-1;	// size of erase button hole
ButtonHole = 4;	// erase & reset button clearance on back
//---------------------------------------------------------------------------------------

module portcover(WiFi=0) { // i/o port cover for the duet 085 & DuetWifi
	rotate([90,0,0]) {
		difference() {
			cubeX([bwidth+10,PHeight,PThick],2);
			if(!WiFi) // ethernet
				translate([Ethgap,Bgap,-2]) cube([16,14,10]);
			else 	// WiFi - not tested ----------------------------------------------------
				translate([Wgap,Bgap+Wheight,-2]) cube([Wwidth,Wthickness,Wdepth+2]);
			// sd
			translate([SDgap,Bgap,-2]) cube([14,3,10]);
			// usb
			translate([Ugap,Bgap,-2]) cube([9,4,10]);
			// reset
			translate([Rgap,Bgap+ResetHole/4,-2]) cylinder(h=bthick*2,d=ResetHole);
			translate([Rgap,Bgap+ResetHole/4,-3.5]) cylinder(h=bthick,d=ButtonHole); // button clearance
			// erase
			translate([Egap,Bgap+EraseHole/4,-2]) cylinder(h=bthick*2,d=EraseHole);
			translate([Egap,Bgap+EraseHole/4,-3.5]) cylinder(h=bthick,d=ButtonHole); // button clearance
			// lights
			translate([Lgap,Bgap,-2]) cube([18,3,10]);
			translate([Lgap,Bgap-2,-2]) rotate([-35,0,0]) cube([18,3,10]); // give a bit more viewing angle
			// -----
			portfingernotches();
		}
		// label the erase & reset holes
		translate([Rgap-1.5,Bgap+2,bthick-0.9]) printchar("R");
		translate([Egap-1.5,Bgap+2,bthick-0.9]) printchar("E");
		if(WiFi) wificover(); // cover for the wifi antenna
	}
	difference() {	// mounting base, it replaces the two spacers on the i/o port end
		translate([1,-3,0]) cubeX([bwidth+8,11,pcsthick]);
		translate([3.5,0,0]) portcovermountholes(1);
		rotate([90,0,0]) portfingernotches();
		// ** will the wifi version need a notch?
		if(!WiFi) translate([Ethgap-4,6,-2]) cube([22,5,pcsthick+3]);	// notch for ethernet wires
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module wificover() { // cover for the wifi antenna
	difference() {
		translate([Wgap-2,Bgap-2+Wheight,0]) cubeX([Wwidth+4,Wthickness+4,Wdepth+2],2);
		translate([Wgap,Bgap+Wheight,0]) cube([Wwidth,Wthickness,Wdepth]);
	}
	wifisupport();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////


module wifisupport() { // print support for the cover for the wifi antenna
	translate([Wgap-0.2,0,Wdepth]) cube([Wwidth+0.4,Wheight+5,nozzle_diameter]);
	translate([Wgap-0.2,0,nozzle_diameter+3.7]) cube([nozzle_diameter,Wheight+5,Wdepth-4]);
	translate([Wgap+nozzle_diameter+Wwidth-0.6,0,nozzle_diameter+3.7]) cube([nozzle_diameter,Wheight+5,Wdepth-4]);
}

//////////////////////////////////////////////////////////////////////////////////////////

module portfingernotches() { // finger access to microsd slot and let a cable plug into the usb
	translate([SDgap-1.8,Bgap-2.5,0.75]) cubeX([17.2,12,5]);	// finger notch to reach microsd card
	translate([Ugap-1.6,Bgap-2.5,0.75]) cubeX([12.5,9,5]);	// notch so usb cable can plug in
}

/////////////////////////////////////////////////////////////////////////////////////////
screw3o = screw3+0.5; // add a bit to screw3t for some wiggle room

module portcovermountholes(Offset=0) {  // mounting holes to platform
	translate([hole_offset+Offset,hole_offset,-1]) cylinder(h=bthick*2,r=screw3o/2);
	translate([bwidth-hole_offset+Offset,hole_offset,-1]) cylinder(h=bthick*2,r=screw3o/2);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

module printchar(String) { // print something
	linear_extrude(height = 1) text(String, font = "Liberation Sans",size=3.5);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

module blower_adapter(blower_h,blower_w,blower_m_dist,ShiftUp=0) { // to use a 50mm 10x15 blower instead of a 40mm axial
	difference() {
		cubeX([fan_support+10,blower_w+10.5+ShiftUp,bthick+1]);
		translate([blower_h/2,bthick+ShiftUp,-2]) cube([blower_h,blower_w,10]);
		translate([5,2.5,-2]) cylinder(h=bthick*2,r=screw3/2);
		translate([fan_platform+5,2.5,-2]) cylinder(h=bthick*2,r=screw3/2);
		translate([5,2.5,3]) cylinder(h=bthick*2,r=screw3hd/2);
		translate([fan_platform+5,2.5,3]) cylinder(h=bthick*2,r=screw3hd/2);
	}
	difference() {
		translate([21,blower_w+4+ShiftUp,0]) cubeX([screw4+4,screw4+1,blower_m_dist+screw4+1],2);
		translate([screw4/2+23,screw4+blower_w+6+ShiftUp,blower_m_dist]) rotate([90,0,0]) cylinder(h=10,d=screw4);
	}
}
//////////////////// end of duet2020.scad ////////////////////////////////////////////////////////////
