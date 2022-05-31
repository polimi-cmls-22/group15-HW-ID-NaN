class Caos {
  
  int totalPts=200;
  float xv;
  float steps = totalPts;
  int[] x_coo = new int[totalPts];
  int[] y_coo = new int[totalPts];
  color caosColor;
  int sizePoint;


  Caos(int n, float xpos, color c, int s){
    totalPts = n;
    xv = xpos;
    caosColor = c;
    sizePoint = s;
  }

  void drawCaos() {
    stroke(caosColor);
    strokeWeight(sizePoint);
    for (int i=0; i < totalPts; i++){
      x_coo[i] += random(-6, 6);
      y_coo[i] += random(-6, 6);
    }
   
    for (int i=0; i < totalPts; i++){
      point( xv + x_coo[i] , (height/steps) * i + y_coo[i]);
    }
  }


}
