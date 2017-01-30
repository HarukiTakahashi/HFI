float[] getSystem(PVector[] origin, PVector[] trans) {
  float x, y, X, Y;
  double[][] array = new double[8][8];
  double[][] Varray = new double[8][1];


  for (int i=0; i<4; i++) {
    x = origin[i].x;
    y = origin[i].y;
    X = trans[i].x;
    Y = trans[i].y;

    array[i][0] = x;  
    array[i][1] = y;  
    array[i][2] = 1;  
    array[i][3] = 0;
    array[i][4] = 0;  
    array[i][5] = 0;  
    array[i][6] = -x*X;  
    array[i][7] = -y*X;

    array[i+4][0] = 0;  
    array[i+4][1] = 0;  
    array[i+4][2] = 0;  
    array[i+4][3] = x;
    array[i+4][4] = y;  
    array[i+4][5] = 1;  
    array[i+4][6] = -x*Y;  
    array[i+4][7] = -y*Y;

    Varray[i][0] = X;
    Varray[i+4][0] = Y;
  }

  Matrix A = new Matrix(array);
  Matrix V = new Matrix(Varray);

/*
  System.out.print("[");
  for (int i = 0; i < A.getRowDimension(); i++) {
    for (int j = 0; j < A.getColumnDimension(); j++) {
      System.out.print((int)A.get(i, j));
      System.out.print(",");
    }
    System.out.println();
  }
  System.out.print("]\n");
*/

if (A.det() != 0) {
  Matrix Ans = A.inverse().times(V);
  //println("C: " + Ans.getColumnDimension() + " R: " + Ans.getRowDimension());

  float[] system = new float[8];
  system[0] = (float)Ans.get(0, 0);
  system[1] = (float)Ans.get(1, 0);
  system[2] = (float)Ans.get(2, 0);
  system[3] = (float)Ans.get(3, 0);
  system[4] = (float)Ans.get(4, 0);
  system[5] = (float)Ans.get(5, 0);
  system[6] = (float)Ans.get(6, 0);
  system[7] = (float)Ans.get(7, 0);

/*
for (int i = 0; i < system.length; i++) {
    println("i: " + i + " : " + system[i]);
  }
*/
  return system;
}
return null;
}


PVector invert( float u, float v, float[] system ) {
  return new PVector((system[0]*u + system[1] * v + system[2] ) / ( system[6] * u + system[7]*v+1), 
    (system[3]*u+system[4]*v+system[5])/(system[6]*u+system[7]*v+1) );
}