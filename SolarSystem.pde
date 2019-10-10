import peasy.*;

Planet sun;

PeasyCam cam;

PImage sunTexture;
PImage[] textures = new PImage[7];
PImage space;


void setup() {
  size (650, 600, P3D);
  sunTexture = loadImage("sun.jpg");
  textures[0] = loadImage("earth.jpg");
  textures[1] = loadImage("jupiter.jpg");
  textures[2] = loadImage("neptune.jpg");
  textures[3] = loadImage("mars.jpg");
  textures[4] = loadImage("venus.jpg");
  textures[5] = loadImage("saturn.jpg");
  textures[6] = loadImage("mercury.jpg");
  space = loadImage("space.jpg");
  cam = new PeasyCam(this, 500); //where to look at the world
  sun = new Planet(50, 0, 0, sunTexture); //distance is 0 cuz it will be in the center
  sun.spawnMoons(7, 1); //level 0
  
}


void draw() {
  background(space);
  lights(); //to make shadows to seem 3D
  //translate (width/2, height/2); //to move it to the middle
  sun.show();
  sun.orbit();
  
  
}
