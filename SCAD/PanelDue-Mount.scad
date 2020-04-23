///////////////////////////////////////////////////////////////////////////////////////
// PanelDue-Mount.scad - something simple to hold dc42's PanelDue case to 2020
///////////////////////////////////////////////////////////////////////////////////////
// created 7/12/2016
// last update 4/21/20
///////////////////////////////////////////////////////////////////////////////////////
// 8/4/16	- changed bracket to take args for size of paneldue case
// 8/13/16	- width of bracket now based on depth of PanelDue case
//		 	 can now rotate the tabbed version 90 degrees
// 9/3/16	- Added param to select mounting holes in bracket()
// 9/11/16	- Can now tilt bracket if Rt is 0
// 12/17/18	- Added color to preview
// 4/21/20	- Added another tab for streangth
///////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
use <inc/cubeX.scad>
$fn=50;
///////////////////////////////////////////////////////////////////////////////////////
clearance = 2;	// amount needed to let the case slide in
thickness = 7;	// thickness of the bracket
///////////////////////////////////////////////////////////////////////////////////////

//bracket(31,89.5);				// for a 4.3" PanelDue
//bracket(33,124);				// for a 7" PanelDue
//tabbedbracket(31,89.5,20,0);	// 3rd arg is length of mounting tab, 4th arg is rotate 90 degrees
								// 5 arg is angle of bracket if 4th arg is 0 (default: 30)
//tabbedbracket(33,124,20,0);		// for a 7" PanelDue at the bottom 2020 of the printer
tabbedbracket(33,124,60,0);	// for a 7" PanelDue at the top 2040 of the printer

//////////////////////////////////////////////////////////////////////////////////////

module bracket(p_depth,p_height,Mounting=1) {	// 1st arg: depth, 2nd arg: height
	difference() {
		color("cyan") cubeX([p_height+clearance+thickness*2,p_depth+clearance+thickness*2,p_depth],2);
		// suck out center
		translate([thickness,thickness,-1]) color("blue") cube([p_height+clearance,p_depth+clearance,p_depth+5]);
		// remove part in front of screen
		translate([thickness*3,p_depth+clearance,-1]) color("gray") cube([p_height+clearance-thickness*4,p_depth+clearance,45]);
		if(Mounting) mountingholes(p_depth,p_height);
		clampingscrew(p_depth,p_height);
	}

}

//////////////////////////////////////////////////////////////////////////////////////////////

module mountingholes(p_depth,p_height) { // flat mounting
	translate([(p_height+clearance)/4+6,thickness+2,p_depth/2])
		rotate([90,0,0]) color("red") cylinder(h=thickness*2,d=screw5);
	translate([p_height+clearance - p_height/4+6,thickness+2,p_depth/2])
		rotate([90,0,0]) color("black") cylinder(h=thickness*2,d=screw5);
	translate([(p_height+clearance)/4+6,thickness+11,p_depth/2])
		rotate([90,0,0]) color("white") cylinder(h=thickness*2,d=screw5hd);
	translate([p_height+clearance - p_height/4+6,thickness+11,p_depth/2])
		rotate([90,0,0]) color("gray") cylinder(h=thickness*2,d=screw5hd);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////

module clampingscrew(p_depth,p_height) {
	translate([-2,(p_depth+clearance)/2+thickness,p_depth/2]) rotate([0,90,0]) color("plum") cylinder(h=300,d=screw3t);
}

//////////////////////////////////////////////////////////////////////////////////////

module tabbedbracket(p_depth,p_height,m_depth,Rt,Angle=30) {
	// add a tab for horizontal 2020 mount with the PanelDue above
	bracket(p_depth,p_height,0);
	if(Rt)
		translate([0,p_depth,0]) rotate([90,0,0]) thetab(p_depth,p_height,m_depth);
	else {
		%translate([-59,-29,-2]) rotate([0,0,Angle]) cube([20,20,40]);
		translate([5,0,0]) rotate([0,0,Angle]) thetab(p_depth,p_height,m_depth+5);
		translate([-8.5,19.5+thickness/2,0]) rotate([0,0,Angle]) thetab(p_depth,p_height,m_depth+5);
		translate([-10,18.63+thickness/2,0]) rotate([0,0,Angle]) cubeX([20,thickness,p_depth],2);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

module thetab(p_de,p_he,m_de) {
	difference() {
		translate([-m_de+4,0,0]) color("blue") cubeX([m_de,thickness,p_de],2);
		translate([-m_de+12,10,7]) rotate([90,0,0]) color("white") cylinder(h=thickness*2,d=screw5);
		//translate([-m_de+12,thickness*2+5,7]) rotate([90,0,0]) color("gray") cylinder(h=thickness*2,d=screw5hd);
		translate([-m_de+12,10,p_de-7]) rotate([90,0,0]) color("gold") cylinder(h=thickness*2,d=screw5);
		//translate([-m_depth+12,thickness*2+5,p_depth-7]) rotate([90,0,0]) color("black") cylinder(h=thickness*2,d=screw5hd);
	}
}

/////////////////// end of panelduemount.scad ////////////////////////////////////////
