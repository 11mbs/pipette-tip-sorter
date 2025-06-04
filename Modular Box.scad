//Paramaters for 10µL Pipette
//  Comb Thickness Upper 4.7
//  Comb thickness Lower 5.9
//  Comb depth Upper 4
//  Lower Comb Angle 8


//200µL Pipette
//  Comb Thickness Upper 6.1
//  Comb Thickness Lower 3.8
//  Comb Depth Upper 10
//  Lower Comb Angle 6

pipette_name = "200µL";

   //--Box--//
box_length = 200;//not shorter then 121
box_width = 86;
//translate([-10,-15,-9.5])Sorting_Box();

   //--Lid--//
//translate([-10,-15,-5])Lid();

   //--Upper Comb--//
comb_thickness_upper = 4.7;//thickness of pipette / gap
colums = 8;
comb_depth_upper = 10;//Max 10
translate([-10,-9.0,-30])Inlay_gelb();
Upper_Comb_Support(); //for more adhesion on the bed when printing

   //--Lower Comb--//
comb_thickness_lower = 5.9;
rows = 12;
comb_offset_lower = 0.5;
Lower_Comb_Angle = 8;//Default 6
//rotate([0,0,90])translate([-27,-99.5,-13])transfer_Trey_gelb();

  //Upper Comb
module Spalten_Box_gelb(anzahl){ 
difference() {
    translate([10,-5.5,0])
        cube([box_length-10,box_width+1,10]);
    translate([10,2,comb_depth_upper])
        cube([box_length-10,box_width-14,10]);

    for (i=[0:colums-1]){
        translate([box_length/2+5,6.5+i*9,comb_depth_upper/2])
            cube([box_length-10,comb_thickness_upper,comb_depth_upper],center=true);}
}
}

module Inlay_gelb(){
translate([-10,4,30])Spalten_Box_gelb(colums);
translate([box_length-10,-1.5,30])cube([8,box_width+1,10]);
difference(){
translate([box_length-2,box_width/2-19.5,30])cube([20,37,10]);
rotate([0,0,90])translate([box_width/2-17,-box_length-14,38])linear_extrude(2)text(str(pipette_name),size=7.0,font="arial:style=black");}
translate([0,0,14])Support_Inlay_gelb();
translate([box_length/2,0,14])Support_Inlay_gelb();}

module Support_Inlay_gelb(){
translate([2,2,16])cube([5,4,comb_depth_upper+15]);
for (i = [0:colums-2]) {
        translate([2,14.3+9*i,16]) 
            cube([5,1.5,comb_depth_upper+15]);}
translate([2,box_width-8,16])cube([5,4,comb_depth_upper+15]);
translate([2,2,comb_depth_upper+31])cube([5,box_width-6,3]);}

module Upper_Comb_Support(){
for(i=[0:colums-2]){
    translate([-11.5,5.9+i*9,0.125])
        cube([3,3,0.25],center=true);}
for(i=[0:colums-2]){
    translate([-16,5.9+i*9,0.125])
        cylinder(h=0.25,r=5,center=true);}}

  //Lower Comb
module transfer_Trey_gelb(){
Spalten_gelb(rows);
translate([8,0,0])cube([10,comb_thickness_lower+rows*9,10]);
difference(){
translate([-10,comb_thickness_lower/2+35,0]) cube([20,40,10]);
rotate([0,0,270])translate([-comb_thickness_lower/2-74.0,-5,8])linear_extrude(2)text(str(pipette_name),size=8,font="arial:style=black");}}

module Spalten_gelb(anzahl){
    for (i = [0:rows])
        translate([0,i*9,0]) 
            Spitze_gelb();}


comb_width = comb_thickness_lower/1.5;

module Spitze_gelb(){
hull(){
translate([99,0,0])cube([1,comb_width/2,Lower_Comb_Angle]);
translate([99,comb_width,0])cube([1,comb_width/2,Lower_Comb_Angle]);
translate([102,comb_width/1.4+comb_offset_lower,0])cube([0.1,0.1,6]);}
 hull(){
translate([15,0,0])cube([1,comb_width/2,Lower_Comb_Angle]);
translate([15,comb_width,0])cube([1,comb_width/2,Lower_Comb_Angle]);
translate([99,0,0])cube([1,comb_width/2,Lower_Comb_Angle]);
translate([99,comb_width,0])cube([1,comb_width/2,Lower_Comb_Angle]);
translate([102,comb_width/1.4+comb_offset_lower,4])cube([0.1,0.1,6]);
translate([15,comb_width/1.4+comb_offset_lower,4])cube([0.1,0.1,6]);}}




  //Box
module Box(){
translate([0,-3,-16])cube([box_length+5,10,70]);
translate([0,box_width+3,-16])cube([box_length+5,10,70]);
translate([box_length-5,4,-16])cube([10,box_width,70]);
translate([-2.5,4.5,51.5])a();
translate([-2.5,box_width+5.5,51.5])a();}

module a(){
difference(){
cube([5,15,5],center=true);
rotate([0,90,90])cylinder(h=15,d=2.5,$fn=10,center=true);}}

module Sorting_Box(){
difference(){
Box();  
translate([0,4,9])cube([box_length-2,box_width+2,11]);
translate([box_length-2,box_width/2-14,9])cube([15,38,11]);
translate([0,-3,-3.5])cube([comb_thickness_lower+rows*9-1,box_width+10,11]);}}



  //Lid
module Lid(){
 difference(){
translate([-10,-3,0])cube([10,box_width+16,49.5]);
translate([-5,-3,44.5])cube([5,box_width+16,5]);
translate([-7,-3,42.5])cube([7,16.5,7]);
translate([-7,box_width-3.5,42.5])cube([7,16.5,7]);}
translate([-2.5,21,47])a();
translate([-2.5,box_width-11,47])a();}