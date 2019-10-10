// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

let walker;
let runner;
let sprinter;

function setup() {
  createCanvas(640,360);
  walker = new Walker();
  runner = new Walker();
  sprinter = new Walker();

  background(225, 198, 0);
//  randomNumber = integer(random(6));
//  randomColor = color(random(255),random(255),random(255));
  frameRate (5000);

}

function draw() {
      r = random(255); // r is a random number between 0 - 255
  g = random(100,200); // g is a random number betwen 100 - 200
  b = random(100); // b is a random number between 0 - 100
  a = random(200,255); // a is a random number between 200 - 255
  
  walker.step();
  walker.render();
  walker.step();
  walker.render();
  walker.step();
  walker.render();
  
  runner.step();
  runner.render2();
  runner.step();
  runner.render2();
  runner.step();
  runner.render2();
  
  sprinter.step();
  sprinter.render3();
  sprinter.step();
  sprinter.render3();
  sprinter.step();
  sprinter.render3();
  
  walker.step();
  walker.render();
  walker.step();
  walker.render();
  walker.step();
  walker.render();
  
  runner.step();
  runner.render2();
  runner.step();
  runner.render2();
  runner.step();
  runner.render2();
  
  sprinter.step();
  sprinter.render3();
  sprinter.step();
  sprinter.render3();
  sprinter.step();
  sprinter.render3();
}


