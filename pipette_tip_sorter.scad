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
hole_d = 7.9;


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

//cassette(rows,columns,rows_outer,cols_outer,hole_d);



module bars(rows,width,outer_c,height,length){
    spacing = (outer_c - hole_d)/(rows-1);
    for(i=[0:1:rows-1]){
        translate([0,i*spacing,0])cube([length,width,height],center=true);
    }//end for
}//end bars

module sorter_box(length){
    translate([0,-(rows_outer-hole_d)/2,0])difference(){
        translate([0,(rows_outer)/2-hole_d/2,-2])cube([length,rows_outer+5,top_h+2],center=true);
        translate([2,0,0])bars(columns, hole_d, rows_outer,top_h,length);
        translate([2,0,-(top_h+2)/2])bars(columns, lip_d, rows_outer,top_h+2,length);
    }//end difference
    translate([0,0,(top_h-2)])difference(){
        cube([length,rows_outer+5,top_h+2],center=true);
        cube([length-8,rows_outer,top_h+2],center=true);
    }//end difference
    rotate([90,90,0])translate([-top_h-6,length/2-2,0])cylinder(r=2.31,h=rows_outer+5,$fn=6,center=true);
    difference(){
        translate([length/2-2,0,top_h-7])rotate([90,0,0])cylinder(r=4,h=30,$fn=6,center=true);
        translate([0,0,(top_h-2)])cube([length-8,rows_outer,top_h+2],center=true);
    }//end difference
}//end sorter box

//sorter_box(70);

module door(){
    difference(){
        translate([lower_h*3+30,0,top_h/2+0.2])cube([lower_d,rows_outer+5,top_h*2+4],center=true);
        translate([rows_outer+22.4,0,top_h-7])rotate([90,0,0])cylinder(r=4,h=30,$fn=6,center=true);
    }//end difference
    difference (){
        translate([129.2,0,24.9])cube([4,rows_outer+5,3.2],center=true);
        rotate([90,90,0])translate([-top_h-6,129.2,0])cylinder(r=2.31,h=rows_outer+5,$fn=6,center=true);
    }//end difference
}//end door
 
//door();

module pipette_holder_thing(length, channel_w){
    difference(){
    cube([length,cols_outer+6,top_h],center=true);
    translate([0,-cols_outer/2 + hole_d/2,0])bars(rows, channel_w, cols_outer,top_h,length);
}//end difference
    translate([length/2,0,0])cube([channel_w,cols_outer+15,top_h],center=true);
    difference(){
        translate([(length/2)+14,0,0])cube([24,cols_outer-20,top_h],center=true);
        translate([(length/2)+11,0,0])cube([19,cols_outer-30,top_h],center=true);
    
    
    
    
    }//end difference
}//end pipette holder thing
pipette_holder_thing(100, lower_d);
