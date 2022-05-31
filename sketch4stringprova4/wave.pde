class Wave {

  int yspacing; // How far apart should each vertical location be spaced
  float xpos;
  int waveLength = height+18; // Length of entire wave
  float theta = 0.0;  // Start angle at 0
  float plus;
  float amplitude;  // Height of wave
  float period;  // How many pixels before the wave repeats
  float dy; // Value for incrementing Y, a function of period and yspacing
  float[] xvalues;  // Using an array to store width values for the wave
  color waveColor;

 Wave(int s, float a, float p, float t, float x, color c) {

  yspacing = s;
  amplitude = a;
  period = p;
  plus = t;
  xpos = x;
  dy = (TWO_PI / period) * yspacing;
  xvalues = new float[waveLength/s];
  waveColor = c;
  
 }

  void calcWave(float p) {
    // Increment theta (try different values for 'angular velocity' here
    theta += p;
    // For every x value, calculate a y value with sine function
    float y = theta;
    for (int i = 0; i < xvalues.length; i++) {
      xvalues[i] = sin(y)*amplitude;
      y+=dy;
    }
  }
 
 void renderWave() {
  noStroke();
  fill(waveColor);
  // A simple way to draw the wave with an ellipse at each location
  for (int y = 0; y < xvalues.length; y++) {
    ellipse(xpos+xvalues[y], y*yspacing, 6, 6);
  }
 }

 
 void display() { 
    calcWave(plus);
    renderWave();     
 }
}
