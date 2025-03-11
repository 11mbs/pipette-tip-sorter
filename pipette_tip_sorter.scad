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



module bars(rows,width,catch_w,outer_c,height,length){
    spacing = (outer_c - hole_d)/rows;
    for(i=[0:1:rows]){
        translate([0,i*spacing,0])cube([length,width,height],center=true);
    }//end for
}//end bars

module sorter_box(){
    translate([0,-(rows_outer-hole_d)/2,0])difference(){
        translate([0,(rows_outer)/2-hole_d/2,-2])cube([cols_outer*3,rows_outer+5,top_h+2],center=true);
        bars(columns, hole_d, 5, rows_outer,top_h,cols_outer*3);
        translate([0,0,-(top_h+2)/2])bars(columns, lip_d, 5, rows_outer,top_h+2,cols_outer*3);
    }//end difference
    translate([0,0,(top_h)])difference(){
        cube([cols_outer*3,rows_outer+5,top_h+2],center=true);
        cube([cols_outer*3-8,rows_outer,top_h+2],center=true);
    }//end difference
}//end sorter box

sorter_box();








