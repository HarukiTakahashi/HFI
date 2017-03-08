// External parameters template; main program reads and rewrites up to 7 lines
pos_x = 10.0;
pos_y = 10.0;
rot_x = 0;
rot_y = 0;
t = 0; //elapsed time
pos_z = t * 3; //do some math to retrieve z_height from elapsed time t

original = ""; // stl file
inserted = ""; // stl file
shape = [[1,0],[2,5],[-3,0]]; //vertice pairs from annotation shape feature extraction

// main processing
module pause(){

}

// *************************** Technique 1 ***************************//
// pos_x, pos_y, rot_x, rot_y = localization info
// t = pause time to retrive paused height
// *******************************************************************//
module insertPhysicalGeometry(pos_x, pos_y, rot_x, rot_y, t){
  difference(){
    import(original); //original stl

    scale([1.1, 1.1, 1]){ // scale to avoid collision with extruder
      rotate([rot_x, rot_y, 0]){
        translate([pos_x, pos_y, t]){ // inserted geometry
          import(inserted);
        }
      }
    } //EOF scale
  }
}

// *************************** Technique 2 ***************************//
// pos_x, pos_y = 2D localization info (here we won't need rotation info)
// shpae = set of vertices from extracted features; take from test.scad outputfile
// scaleFactor (optional) = if we can get any gesture input from user
// t1 = paused height
// t2 = extrusion height
// *******************************************************************//
module extrudeWith2DAnnotation(pos_x, pos_y, shape, scaleFactor, t1, t2){
  //complete the rest of printing until the innter tube does not pierece the external model
  difference(){
    import(original);
    translate([pos_x, pos_y, t1])
      tubes(shape, coil, topWidth, t2);
  }

  module tubes(shape, coil, scaleFactor, t2){
    linear_extrude(height=t2)
    //, scale=[1,1,scaleFactor], twist=coil) --> scale & twist doesn't work for acute shapes
      polygon(shape);
  }
}

//do minkowski corner
module minkowskiExtrusion(){
    minkowski(){
      import(original);
      //cylinders at the edge-- in which radius??
    }
}

// scaleUp = T/F
module scaleExtrusion(scaleFactor, t){
  cropBox = cube([1000, 1000, t]); //big enough to crop the original object

  //h = the original heght of input model
  scaledUpperPart = linear_extrude(height = (h-t))
                      proejction(cut=true)  //to get top surface only
                        translate([0,0,-t]) //since OpenSCAD takes projection at z=0,
                                            //we need to get the top surface to extrude by mitigating the position
                                            //to get the top surface polygon, translate top suface to z=0
                          upperPart()

  return
    union(){
        scaledUppoerPart;
        lowerPart;
    }

  module upperPart(){
    intersection(){
      import(original);
      translate([0,0,t])
        cropBox;
    }
  }

  module lowerPart(){
    intersection(){
      import(original);
      cropbox;
    }
  }
}

//add random bumps around the surface
module extrudeWithBumps(){
    union(){
      import(original);
      //add bumps following the surface of inserted item
    }
}


module insertCavityAfterAlert(){
  //do difference up to the largest projection surface

  //segment to two stl >> send to queue separately

  module project(){
    projection(cut=false)
      import(inserted);
  }
}
