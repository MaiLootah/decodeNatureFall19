//https://www.openprocessing.org/sketch/756293


float thold = 5;
float spifac = 1.05;
int outnum;
float drag = 0.01;
int big = 500;
ball bodies[] = new ball[big];
float mX;
float mY;
float m2x;
float m2y;

void setup() {
  size(900, 450);
  strokeWeight(1);
  fill(255, 255, 255);
  stroke(255, 255, 255, 5);
  background(0, 0, 0);   
  smooth();
  for(int i = 0; i < big; i++) {
    bodies[i] = new ball();
  }
}

void draw() {
  if(keyPressed) {
    saveFrame("Focus " + outnum);
    outnum++;;
  }
  if(mousePressed) {
    background(0, 0, 0);
  }
    m2x = mX + random(-500,50);
    m2y = mY + random(-200,50);
    mX += 0.3 * (random(height) - m2x);
    mY += 0.3 * (random(height) - m2y);
  for(int i = 0; i < big; i++) {
    bodies[i].render();
  }
}

class ball {
  float X;
  float Y;
  float Xv;
  float Yv;
  float pX;
  float pY;
  float w;
  ball() {
    X = random(width);
    Y = random(height);
    w = random(1 / thold, thold);
  }
  void render() {
    if(!mousePressed) {
      Xv /= spifac;
      Yv /= spifac;
    }
    Xv += drag * (mX - X) * w;
    Yv += drag * (mY - Y) * w;
    X += Xv;
    Y += Yv;
    line(X, Y, pX, pY);
    pX = X;
    pY = Y;
  }
}
