class Particle extends VerletParticle2D {
  
  float radius=0;
  
  Particle(float x, float y) {
    super(x,y);
    
  }
  
  void display() {
    fill(127);
    stroke(0);
    strokeWeight(2);
    ellipse(x,y,0,0); //radius*2
  }
}
