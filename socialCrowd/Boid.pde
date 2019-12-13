// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Boid class
// Methods for Separation, Cohesion, Alignment added

class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float cr, cg, cb;
  //int s;

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    position = new PVector(x, y);
    r = 7;
    maxspeed = 3;
    maxforce = 0.05;
    //s = 10;
    cr = 0;
    cg = 0;
    cb = 0;
  }

  void run(ArrayList<Boid> boids, Innovator innovator) {
    flock(boids, innovator);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids, Innovator innovator) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids, innovator);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    //float theta = velocity.heading2D() + radians(90);

    noStroke();
    fill(0);
    ellipse(position.x, position.y, r, r*1.25);
    rectMode(CORNERS);
    rect(position.x-.85*r, position.y+.8*r, position.x-.65*r, position.y+2*r);
    rect(position.x+.85*r, position.y+.8*r, position.x+.65*r, position.y+2*r);
    rectMode(CORNER);
    rect(position.x-.1*r, position.y+2.8*r, -.7*r, -.25*r);
    rect(position.x+.1*r, position.y+2.8*r, .7*r, -.25*r);
    fill (cr, cg, cb);
    stroke(255);
    quad(position.x-.85*r, position.y+.8*r, position.x+.85*r, position.y+.8*r, position.x+.3*r, position.y+2.5*r, position.x-.3*r, position.y+2.5*r);

    //constrain
    cr = constrain (cr, 0, 255);
    cg = constrain (cg, 0, 255); 
    cb = constrain (cb, 0, 255);
  }

  void loss_i() {
    cr = cr + 1;
    cg = cg + 1;
    cb = cb + 1;
  }
  void gain_i() {      
    cr = cr -.01;
    cg = cg -.01;
    cb = cb -.01;
  }

  void plant_idea () {
    cr = 200;
    cg = 0;
    cb = 0;
  }

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 20;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids,  Innovator innovator) {
    float neighbordist = 15;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        this.loss_i();
        other.loss_i();
        sum.add(other.position); // Add position
        count++;
        
      } else {
        other.gain_i();
      }
      //println(mouseX, innovator.x - 10);
      if (mousePressed && mouseX > other.position.x - 10 && mouseX < other.position.x + 10 && mouseY < other.position.y + 10 && mouseY > other.position.y - 10) {
        other.plant_idea();
        //println("change color");
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0, 0);
    }
  }
}
