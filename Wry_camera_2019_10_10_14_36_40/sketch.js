
//let wave;

function setup() {
  createCanvas(600, 600);
  wave = new Wave();

}

function draw() {
  background(10, 10); 
  

  wave.render();
  wave.render2();

}
