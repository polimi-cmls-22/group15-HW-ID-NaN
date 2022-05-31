class Chain {
  
 
  float totalLength;
  int numPoints;
  float strength;
  float position;
  color stringColor;
  
  ArrayList<Particle> particles;
  
  Particle middle;
  
  
  PVector offset = new PVector();
  boolean dragged = false;
  
  Chain(float l, int n, float s, float p, color c) {
    particles = new ArrayList<Particle>();
    
    totalLength = l;
    numPoints = n;
    strength = s;
    position = p;
    stringColor = c;
    
    float len = totalLength / numPoints;
    
    for(int i=0; i < numPoints; i++) {
      
      Particle particle = new Particle(p, i*len);
      
      physics.addParticle(particle);
      particles.add(particle);
      
      if (i!= 0) {
        Particle previous = particles.get(i-1);
        VerletSpring2D spring = new VerletSpring2D(particle,previous,len,strength);
        physics.addSpring(spring);
      }
    }
    
    Particle head=particles.get(0);
    head.lock();
    
    Particle tail=particles.get(numPoints-1);
    tail.lock();
    
    middle = particles.get(numPoints/2);
    
  }
  
  
  
  void contains(int x, int y) {
      dragged = true;
      offset.x = middle.x - x;    
      offset.y = middle.y - y;
      
  }
  
 
  
  void updateMiddle(int x, int y) {
    if (dragged) {
      middle.set(x+offset.x,y+offset.y);
    }
  }
  
  void display() {
    beginShape();
    fill(stringColor);
    stroke(stringColor, 200);
    strokeWeight(10);
    
    
    
    for(Particle p : particles) {
      vertex(p.x,p.y);
    }
    endShape();
    middle.display();
  }
}
