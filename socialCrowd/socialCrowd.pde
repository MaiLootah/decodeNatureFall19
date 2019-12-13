// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Demonstration of Craig Reynolds' "Flocking" behavior
// See: http://www.red3d.com/cwr/
// Rules: Cohesion, Separation, Alignment

// Click mouse to add boids into the system

Flock flock;
Innovator You;

void setup() {
  //size(640,360);
  fullScreen();
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 500; i++) {
    Boid b = new Boid(width/2,height/2);
    flock.addBoid(b);
    
  }
  You = new Innovator();
  //frameRate(200);
}

void draw() {
  background(255);
  flock.run(You);
  
    if (mousePressed) {
      You.displayI(mouseX,mouseY);
  }
  


}

class Innovator {
  
  float x, y, c;
  int s;
  
  //constructor
  Innovator () {
    s = 10;
    c = 200;
  }
  
  void displayI (float x, float y) {
    noStroke();
    fill(0);
    ellipse(x, y, s, s*1.25);
    rectMode(CORNERS);
    rect(x-.85*s, y+.8*s, x-.65*s, y+2*s);
    rect(x+.85*s, y+.8*s, x+.65*s, y+2*s);
    rectMode(CORNER);
    rect(x-.1*s, y+2.8*s, -.7*s, -.25*s);
    rect(x+.1*s, y+2.8*s, .7*s, -.25*s);
    fill (c,0,0);
    stroke(255);
    quad(x-.85*s, y+.8*s, x+.85*s, y+.8*s, x+.3*s, y+2.5*s, x-.3*s, y+2.5*s);
    
    //constrains
    x = constrain(x, s, width-10);
    y = constrain(y, s, height-10);   
  }
  
  //whisper from innovator to sheeple
 //boolean whisper(Boid p0) { 
   
 // // distance between two persons 
 // float dT = dist(You.x,You.y,p0.x,p0.y);  
  
 //  if ((dT > 0) && (dT < s*1.5)) {              
 //   return true;
 //  } else {
 //   return false;
 //  }
 //}

 
 
}
