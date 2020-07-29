////////////////////////////////////////////////////////////////////////////////////////////////////////////
// keyboard.scad
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Created 7/19/2020
// Last Update 7/25/20
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 7/19/20	- Keybaord platform
// 7/20/20	- Keyboard bracing
// 7/23/20	- Added a second version of braces to not use the keyboard()
//////////////////////////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
include <inc/cubex.scad>
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
		color("cyan") cubeX([Length+Thickness*2,Width,Thickness],1);
		MakeHoles();
	}
	color("blue") cubeX([Length+Thickness*2,Thickness,Thickness*2],1);
	color("red") cubeX([Thickness,Width,Thickness*2],1);
	translate([Length+Thickness,0,0]) color("khaki") cubeX([Thickness,Width,Thickness*2],1);
	difference() {
		translate([0,Width-2,0]) color("plum") cubeX([20,40,Thickness],1);
		translate([10,Width+25,0]) color("red") cylinder(h=10,d=screw5);
	}
	difference() {
		translate([Length/2-30,Width-2,0]) color("purple") cubeX([60,40,Thickness],1);
		translate([Length/2-15,Width+25,0]) color("gray") cylinder(h=10,d=screw5);
		translate([Length/2+15,Width+25,0]) color("pink") cylinder(h=10,d=screw5);
	}
	difference() {
		translate([Length-20+Thickness*2,Width-2,0]) color("black") cubeX([20,40,Thickness],1);
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
				color("blue") cubeX([40,Thickness,40],1);
				translate([10,0,10]) ScrewHoles(screw5);
			}
			color("red") cubeX([Thickness,Width,Thickness],1);
			translate([40-Thickness,0,0]) color("cyan") cubeX([Thickness,Width,Thickness],1);
			translate([0,0,40-Thickness]) color("plum") rotate([-21,0,0]) cubeX([Thickness,Width+5,Thickness],1);
			translate([40-Thickness,0,40-Thickness]) color("gray") rotate([-21,0,0]) cubeX([Thickness,Width+5,Thickness],1);
			translate([0,Width-Thickness,0]) color("pink") cubeX([40,Thickness,Thickness],1);
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////

module SimpleKeyboardBraces(Qty=1) {
	for(x = [0 : Qty-1]) {
		translate([x*45,0,0]) rotate([201,0,0]) {
			difference() { // 2040 mounting
				color("blue") cubeX([40,Thickness,40.5],1);
				translate([10,0,10]) ScrewHoles(screw5);
			}
			difference() {
				TheBraces(); // holds keyboard
				translate([-2,-2,40.45]) color("khaki") cube([45,10,10]);
				translate([-2,-9,-2]) color("green") cube([10,10,10]);
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module TheBraces() { // holds keyboard
	color("red") cubeX([Thickness,Width,Thickness],1);
	translate([40-Thickness,0,0]) color("cyan") cubeX([Thickness,Width,Thickness],1);
	translate([0,0,0]) color("plum") rotate([0,0,-20]) cubeX([Thickness,Width+5,Thickness],1);
	translate([0,0,40-Thickness+1.75]) color("black") rotate([-21,0,0]) cubeX([Thickness,Width+4,Thickness],1);
	translate([40-Thickness,-0,40-Thickness+1.75]) color("gray") rotate([-21,0,0]) cubeX([Thickness,Width+4,Thickness],1);
	translate([0,Width-Thickness+1.5,-Thickness-0.6]) color("pink") rotate([10,0,0]) cubeX([40,Thickness,Thickness*2],1);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module ScrewHoles(Screw=screw5) {
	translate([0,Thickness+2,0]) color("red") rotate([90,0,0]) cylinder(h=10,d=Screw);
	translate([20,Thickness+2,0]) color("black") rotate([90,0,0]) cylinder(h=10,d=Screw);
	translate([0,Thickness+2,20]) color("white") rotate([90,0,0]) cylinder(h=10,d=Screw);
	translate([20,Thickness+2,20]) color("cyan") rotate([90,0,0]) cylinder(h=10,d=Screw);
	if(Screw==screw5) {
		translate([0,Thickness*2-1.5,0]) color("cyan") rotate([90,0,0]) cylinder(h=5,d=screw5hd);
		translate([20,Thickness*2-1.5,0]) color("white") rotate([90,0,0]) cylinder(h=5,d=screw5hd);
		translate([0,Thickness*2-1.5,20]) color("black") rotate([90,0,0]) cylinder(h=5,d=screw5hd);
		translate([20,Thickness*2-1.5,20]) color("red") rotate([90,0,0]) cylinder(h=5,d=screw5hd);
	}
}


////////////////////////////////////////////////////////////////////////////////////////////////////////