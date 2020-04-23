///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// BrassFunctions.scad - returns type of screw hole
// created: 4/13/2020
// last modified: 4/13/2020
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 4/13/20	- Functions that return a screw3t (tap hole) or the hole for a 3mm brass insert
//			  4mm & 5mm not implimented yet
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
include <inc/screwsizes.scad>
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function GetHoleLen3mm(Screw) =	(Screw==screw3in) ? screw3inl*2.5 : 25;
function YesInsert3mm() = (Use3mmInsert==1) ? screw3in : screw3t;

//function GetHoleLenM4(Screw) =	(Screw==screw4in) ? screw4inl*2.5 : 25;
//function YesInsertM4() = (Use4mmInsert==1) ? screw4in : screw4;

//function GetHoleLenM5(Screw) =	(Screw==screw5in) ? screw5inl*2.5 : 25;
//function YesInsertM5() = (Use5mmInsert==1) ? screw5in : screw5;

////////////////////////////// end of BrassFunctions.scad ///////////////////////////////////////////////////////
