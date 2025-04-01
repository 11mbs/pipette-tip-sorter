 // Pipette details - check the pipette_tip model looks like your real pipette
top_d = 7.5;
top_h = 16.2;
lip_d = 5.8;
lower_d = 4.75;
lower_h = 34.5;

// Cassette details - check it doesn't look wrong
rows = 8;
columns = 12;
rows_outer = 106.8; // from outer edge to outer edge of a single row
cols_outer = 71; // same for columns
hole_d = 8;


module pipette_tip(top_d, top_h, lip_d, lower_d, lower_h, $fn=30){
    cylinder(h=top_h, d1=lip_d, d2=top_d);
    translate([0,0,-lower_h])cylinder(h=lower_h, d1=0,d2=lower_d);
}//end pipette tip

//pipette_tip(top_d,top_h,lip_d,lower_d,lower_h);

module cassette(rows,columns,outer_r,outer_c,hole_d,h=10){
    spacing_r = (outer_c - hole_d)/rows;
    spacing_c = (outer_r - hole_d)/columns;
    
    difference(){
        translate([-(h+hole_d)/2,-(h+hole_d)/2,0]){cube([outer_c+h,outer_r+h, h]);}
    for(i=[0:1:rows]){
        for (j=[0:1:columns]){
            translate([i*spacing_r, j*spacing_c,0])cylinder(d=hole_d,h=2.5*h,center=true);
        }//end for
    }//end for
    
}//end difference
}//end cassette

//translate([]){rotate([0,0,90])cassette(rows,columns,rows_outer,cols_outer,hole_d);}



module bars(rows,width,outer_c,height,length){
    spacing = (outer_c - hole_d)/(rows-1);
    for(i=[0:1:rows-1]){
        translate([0,i*spacing,0])cube([length,width,height],center=true);
    }//end for
}//end bars
base_feet_width = 24;
base_feet_height = 12;
base_feet_in = [15,4,base_feet_height];
base_feet_out = [24,4,base_feet_height];

module sorter_box(length){
    translate([0,-(rows_outer-hole_d)/2,0])difference(){
        translate([0,(rows_outer)/2-hole_d/2,-2])cube([length,rows_outer+5,top_h+2],center=true);
        translate([2,0,0])bars(columns, hole_d, rows_outer,top_h,length);
        translate([2,0,-(top_h+2)/2])bars(columns, lip_d, rows_outer,top_h+2,length);
    }//end difference
    translate([0,0,(top_h)])difference(){
        cube([length,rows_outer+5,top_h+5],center=true);
        cube([length-8,rows_outer,top_h+5],center=true);
    }//end difference
    rotate([90,90,0])translate([-top_h-9.5,length/2-2,0])cylinder(r=2.3,h=rows_outer+5,$fn=6,center=true);

    door_holder=6.5;
    difference(){
        translate([length/2+door_depth/2+1.5,rows_outer/2+3.25,-top_h/5.5])cube([door_depth+3,door_holder,top_h],center=true);
        translate([length/2+door_depth/2+0.25,0,top_h/2+0.2])cube([door_depth+0.5,rows_outer+5,top_h*2+11],center=true);
    }
    difference(){
        translate([length/2+door_depth/2+1.5,-rows_outer/2+3.25,-top_h/5.5])cube([door_depth+3,door_holder,top_h],center=true);
        translate([length/2+door_depth/2+0.25,0,top_h/2+0.2])cube([door_depth+0.5,rows_outer+5,top_h*2+11],center=true);
    }//end difference

//base feet
    difference(){
        translate([length/2-base_feet_width/2,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_out,center=true);
        translate([length/2-base_feet_width/2,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    }//end difference
    difference(){
        translate([length/2-base_feet_width/2,-rows_outer/2-4.5,-top_h/2+base_feet_height/4])cube(base_feet_out,center=true);
        translate([length/2-base_feet_width/2,-rows_outer/2-4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    }//end difference
    difference(){
        translate([(length/2-base_feet_width/2)-cols_outer-lower_d/2,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_out,center=true);
        translate([(length/2-base_feet_width/2)-cols_outer-lower_d/2,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    }//end difference
    difference(){
        translate([(length/2-base_feet_width/2)-cols_outer-lower_d/2,-rows_outer/2-4.5,-top_h/2+base_feet_height/4])cube(base_feet_out,center=true);
        translate([(length/2-base_feet_width/2)-cols_outer-lower_d/2,-rows_outer/2-4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    }//end difference
    difference(){
        translate([-length/2+base_feet_width/2,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_out,center=true);
        translate([-length/2+base_feet_width/2,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    }//end difference
    difference(){
        translate([-length/2+base_feet_width/2,-rows_outer/2-4.5,-top_h/2+base_feet_height/4])cube(base_feet_out,center=true);
        translate([-length/2+base_feet_width/2,-rows_outer/2-4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    }//end difference




}//end sorter box

sorter_box(200);

comb_height = 10;

module feet(length,feet_height,feet_width){
    translate([length/2-12,rows_outer/2+4.5,-top_h/2+base_feet_height/4])cube(base_feet_in,center=true);
    difference(){
        translate([length/2-12,rows_outer/2+2.75,-top_h/2-feet_height/2-3])cube([feet_width,7.5,feet_height],center=true);
        translate([length/2-12,rows_outer/2-1,-top_h/2-feet_height/2-5])cube([feet_width,7,feet_height],center=true);
        translate([length/2-12,rows_outer/2+2.75,-top_h/2-8])rotate(90)bars(1, lower_d+0.5, cols_outer,comb_height+0.5,top_d);
        }//end difference
}//end feet

door_depth=4.75;
//feet(100,16,lower_d+8);
module door(length){
        translate([length/2+door_depth/2,0,top_h/2+1.2])cube([door_depth,rows_outer,top_h*2+9],center=true);
    difference (){
        translate([(length/2+door_depth/2)-4.3,0,top_h*2-4])cube([4,rows_outer,3.2],center=true);
        rotate([90,90,0])translate([-top_h-9.5,(length/2+door_depth/2)-4.35,0])cylinder(r=2.3,h=rows_outer+5,$fn=6,center=true);
    }//end difference
}//end door
 
//door(120);

module comb(length, channel_w){
    handle=19;
    difference(){
        translate([-length/4,0,0])cube([length*1.5,cols_outer+6,comb_height],center=true);
        translate([0,-cols_outer/2 + hole_d/2,0])bars(rows, channel_w, cols_outer,top_h,length*2);
        translate([-length/2,cols_outer/2+3,-comb_height/2]){rotate([0,0,155])cube([length/2,cols_outer+50,comb_height]);}
    }//end difference
    translate([length/2,0,0])cube([door_depth,cols_outer+15,comb_height],center=true);
    difference(){
        translate([(length/2)+14,0,0])cube([handle+5,cols_outer-20,comb_height],center=true);
        translate([(length/2)+11,0,0])cube([handle,cols_outer-30,comb_height],center=true);
    }//end difference
}//end comb
//translate([1.7,0,-top_h])rotate(90)comb(rows_outer*1.2, lower_d);

module test(length){
    translate([47.5,0,0])cube([5,111.8,16.2],center=true);
    door_holder=5;
    difference(){
        translate([length/2+door_depth/2+1.5,rows_outer/2,0])cube([door_depth+3,door_holder,top_h],center=true);
        translate([length/2+door_depth/2+0.25,0,0])cube([door_depth+0.5,rows_outer+0.5,top_h*2+11],center=true);
    }
    difference(){
        translate([length/2+door_depth/2+1.5,-rows_outer/2,0])cube([door_depth+3,door_holder,top_h],center=true);
        translate([length/2+door_depth/2+0.25,0,0])cube([door_depth+0.5,rows_outer+0.5,top_h*2+11],center=true);
    }//end difference
}//end test
//test(100);