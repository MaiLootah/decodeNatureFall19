/**
 * ParticleSystemPShape
 * 
 * A particle system optimized for drawing using PShape
 */

// Particle System object
ParticleSystem ps;
// A PImage for particle's texture
PImage sprite;  


int circleX, circleY;  // Position of circle button
int circleSize = 93;   // Diameter of circle
color circleColor, baseColor;
color circleHighlight;
color currentColor;
boolean circleOver = false;

void setup() {
  size(640, 360, P2D);
  // Load the image
  sprite = loadImage("sprite.png");
  // A new particle system with 10,000 particles
  ps = new ParticleSystem(10000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
  
  circleColor = color(255);
  circleHighlight = color(204);
  baseColor = color(102);
  currentColor = baseColor;
  circleX = width; //2+circleSize/2+10;
  circleY = height/2;
  ellipseMode(CENTER);

} 

void draw () {
  //background(0);
  update(mouseX, mouseY);
  background(currentColor);
    if (circleOver) {
    fill(circleHighlight);
      // Update and display system
  ps.update();
  ps.display();
  
  // Set the particle system's emitter location to the mouse
  ps.setEmitter(random(width/2),random(height/2));
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
  
  //// Update and display system
  //ps.update();
  //ps.display();
  
  //// Set the particle system's emitter location to the mouse
  //ps.setEmitter(random(width/2),random(height/2));
  
  // Display frame rate
  fill(255);
  textSize(16);
  text("Frame rate: " + int(frameRate),10,20);
  
}

void update(int x, int y) {
  if ( overCircle(circleX, circleY, circleSize) ) {
    circleOver = true;
  } else {
    circleOver = false;
  }
}

void mousePressed() {
  if (circleOver) {
    currentColor = circleColor;
  }

}



boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
