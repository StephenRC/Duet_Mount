////////////////////////////////////////////////////////////////////////////////////////////////////////////
// keyboard.scad
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Created 7/19/2020
// Last Update 1/6/22
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// https://creativecommons.org/licenses/by-sa/4.0/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 7/19/20	- Keybaord platform
// 7/20/20	- Keyboard bracing
// 7/23/20	- Added a second version of braces to not use the keyboard()
// 8/1/20	- changed the SimpleKeyboardBraces() to hold the keyboard at an angle
// 8/20/20	- changed simplekeyboradbraces to a more solid one
// 1/6/22	- BOSL2
//////////////////////////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
include <bosl2/std.scad>
////////////////////////////////////////////////////////////////////////////////////////////////////////////
$fn=50;
Length=260; // sized for the Rii 12+ Mini Wireless Keyboard Mouse Combo
Width=95; // change this and the support angles need to be changed
Thickness=5;
LayerThickness=0.3;
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//KeyboardPlatform();
//PlatformBraces(2);
SimpleKeyboardBraces(3);

///////////////////////////////////////////////////////////////////////////////////////////////////

module KeyboardPlatform() {
	difference() {
		color("cyan") cuboid([Length+Thickness*2,Width,Thickness],rounding=1,p1=[0,0]);
		MakeHoles();
	}
	color("blue") cuboid([Length+Thickness*2,Thickness,Thickness*2],rounding=1,p1=[0,0]);
	color("red") cuboid([Thickness,Width,Thickness*2],rounding=1,p1=[0,0]);
	translate([Length+Thickness,0,0]) color("khaki") cuboid([Thickness,Width,Thickness*2],rounding=1,p1=[0,0]);
	difference() {
		translate([0,Width-2,0]) color("plum") cuboid([20,40,Thickness],rounding=1,p1=[0,0]);
		translate([10,Width+25,0]) color("red") cylinder(h=10,d=screw5);
	}
	difference() {
		translate([Length/2-30,Width-2,0]) color("purple") cuboid([60,40,Thickness],rounding=1,p1=[0,0]);
		translate([Length/2-15,Width+25,0]) color("gray") cylinder(h=10,d=screw5);
		translate([Length/2+15,Width+25,0]) color("pink") cylinder(h=10,d=screw5);
	}
	difference() {
		translate([Length-20+Thickness*2,Width-2,0]) color("black") cuboid([20,40,Thickness],rounding=1,p1=[0,0]);
		translate([Length-10+Thickness*2,Width+25,0]) color("white") cylinder(h=10,d=screw5);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////

module MakeHoles() { // remove plastic to save filament and print time
	translate([-15,0,0]) for(x = [1 : 5]) {
		translate([50*x,30,-2]) color("gray") hull() {
			cylinder(h=10,d=30);
			translate([0,30,0]) cylinder(h=10,d=30);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////

module PlatformBraces(Qty=1) {
	for(x = [0 : Qty-1]) {
		translate([x*45,0,0]) {
			difference() {
				color("blue") cuboid([40,Thickness,40],rounding=1,p1=[0,0]);
				translate([10,0,10]) ScrewHoles(screw5);
			}
			color("red") cuboid([Thickness,Width,Thickness],rounding=1,p1=[0,0]);
			translate([40-Thickness,0,0]) color("cyan") cuboid([Thickness,Width,Thickness],rounding=1,p1=[0,0]);
			translate([0,0,40-Thickness]) color("plum") rotate([-21,0,0]) 
				cuboid([Thickness,Width+5,Thickness],rounding=1,p1=[0,0]);
			translate([40-Thickness,0,40-Thickness]) color("gray") rotate([-21,0,0]) 
				cuboid([Thickness,Width+5,Thickness],rounding=1,p1=[0,0]);
			translate([0,Width-Thickness,0]) color("pink") cuboid([40,Thickness,Thickness],rounding=1,p1=[0,0]);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////

module SimpleKeyboardBraces(Qty=1) {
	rotate([0,-90,0]) {
		for(x = [0 : Qty-1]) {
			translate([0,0,x*50]) {
				difference() {
					union() {
						translate([0,0,0]) color("blue") cuboid([20,Thickness,40.5],rounding=2,p1=[0,0]); // 2040 mounting
						translate([0,0,36]) rotate([-5,0,0]) color("cyan") 
							cuboid([20,Width,Thickness],rounding=2,p1=[0,0]); //  keyboard shelf
						translate([0,Width-Thickness,28]) rotate([-5,0,0]) color("pink") 
							cuboid([20,Thickness,12],rounding=1,p1=[0,0]);
					}
					translate([10,0,9]) ScrewHoles(screw5);
				}
				difference() {
					SimpleKeyboardSupport();
					translate([10,0,9]) ScrewHoles(screw5);
				}
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module SimpleKeyboardSupport() {
	difference() {
		color("red") rotate([17,0,0]) cuboid([Thickness,Width+4,10],rounding=2,p1=[0,0]);
		translate([-3,0,40]) rotate([-5,0,0]) color("gray") cuboid([Thickness*2,120,Thickness*3],rounding=1,p1=[0,0]);
		translate([-4,-9,0]) rotate([0,0,0]) color("white") cuboid([Thickness*2,10,Thickness*3],rounding=1,p1=[0,0]);
	}
	translate([15,0,0]) difference() {
		color("black") rotate([17,0,0]) cuboid([Thickness,Width+4,10],rounding=2,p1=[0,0]);
		translate([-3,0,40]) rotate([-5,0,0]) color("gray") cuboid([Thickness*2,120,Thickness*3],rounding=1,p1=[0,0]);
		translate([-4,-9,0]) rotate([0,0,0]) color("khaki") cuboid([Thickness*2,10,Thickness*3],rounding=1,p1=[0,0]);
	}
	translate([0,40,13.25]) cuboid([20,Thickness,9.75],rounding=2,p1=[0,0]);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module ScrewHoles(Screw=screw5) {
	translate([0,Thickness+2,0]) color("red") rotate([90,0,0]) cylinder(h=10,d=Screw);
	translate([0,Thickness+2,20]) color("white") rotate([90,0,0]) cylinder(h=10,d=Screw);
	if(Screw==screw5) {
		translate([0,34,0]) color("cyan") rotate([90,0,0]) cylinder(h=30,d=screw5hd);
		translate([0,14,20]) color("green") rotate([90,0,0]) cylinder(h=10,d=screw5hd);
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////////