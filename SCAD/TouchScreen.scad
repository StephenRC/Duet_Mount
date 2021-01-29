////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TouchScreen.scad
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// created 12/25/2020
// last update 1/10/21
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 12/25/20	- One piece touchscreen mount for 10" ebay touchscreen
// 1/10/21	- Change to two seperate parts for the ends on the touchscreen, reduces print time and filament
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
include <inc/cubex.scad>
include <inc/screwsizes.scad>
$fn=100;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Thickness=5;
XPosition=256.5;
BaseLength=266.5;
BaseL=74;
BaseWidth=50;
SupportWidth=10;
SupportHeightFront=180;
SupportHeightRear=159;
VertialScreenScrewHeight=162.5;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

TouchScreenMount(2);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScrewCounterSink(Screw=screw3) {
	if(Screw==screw3) {
		color("plum") hull() {
			cylinder(h=0.1,d=screw3hd);
			translate([0,0,-1]) cylinder(h=0.1,d=Screw);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module TouchScreenMount(Qty=1,ShowScrewV=0) {
	for(x=[0:Qty-1]) {
		translate([0,x*55,0]) {
			Base();
			Support(ShowScrewV);
			translate([XPosition/4,0,0]) Support(ShowScrewV);
			ExtrusionMount();
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Base() {
	difference() {
		color("cyan") cubeX([BaseL,BaseWidth,Thickness],2);
		ScrewAccess();
		translate([64,0,0]) ScrewAccess();
		BaseScrewMount();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module Support(ShowScrewV=0) {
	rotate([16.7,0,0]) difference() {
		translate([0,45,-13]) color("gray") cubeX([SupportWidth,Thickness,SupportHeightFront],2);
		ScreenScrewMount(screw3,ShowScrewV);
	}
	difference() {
		translate([0,0,0]) color("plum") cubeX([SupportWidth,Thickness,SupportHeightRear],2);
		translate([0,0,2]) ScrewAccess();
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScreenScrewMount(Screw=screw3,ShowScrewV=0) {
	if(ShowScrewV) #translate([0,50,-5]) rotate([0,0,0]) cubeX([10,Thickness,VertialScreenScrewHeight],2);
	translate([5,53,-5]) rotate([90,0,0]) color("red") cylinder(h=Thickness*2,d=Screw);
	translate([5,45,-5]) rotate([90,0,0]) ScrewCounterSink();
	translate([5,53,VertialScreenScrewHeight-5]) rotate([90,0,0]) color("red") cylinder(h=Thickness*2,d=Screw);
	translate([5,45,VertialScreenScrewHeight-5]) rotate([90,0,0]) ScrewCounterSink(Screw);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ExtrusionMount(Screw=screw5) {
	difference() {
		color("khaki") cubeX([BaseL,Thickness,40],2);
		translate([38,10,12]) rotate([90,0,0]) color("red") cylinder(h=Thickness*3,d=Screw);
		translate([38,10,32]) rotate([90,0,0]) color("blue") cylinder(h=Thickness*3,d=Screw);
		if(Screw==screw5) {
			translate([38,9.5,12]) rotate([90,0,0]) color("blue") cylinder(h=Thickness,d=screw5hd);
			translate([38,9.5,32]) rotate([90,0,0]) color("red") cylinder(h=Thickness,d=screw5hd);
		}
		BaseScrewMount();
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module BaseScrewMount(Screw=screw5) {
	translate([38,10,-3]) color("red") cylinder(h=Thickness*3,d=Screw);
	if(Screw==screw5) translate([38,10,Thickness-1]) color("blue") cylinder(h=Thickness*2,d=screw5hd);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module ScrewAccess(Screw=screw3hd) {
	translate([5,45,8]) rotate([106.5,0,0]) color("white") cylinder(h=Thickness*10,d=Screw);
	translate([261.5,45,8]) rotate([106.5,0,0]) color("black") cylinder(h=Thickness*10,d=Screw);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////