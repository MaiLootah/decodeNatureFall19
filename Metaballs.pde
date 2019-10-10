//isoSurface, the pixels, the color is a function inversely proportional to the distance from Blob
//Blob b; single object
Blob[] blobs = new Blob [7];

void setup(){
  size (640, 640);
  //fullScreen();
  colorMode(HSB);
  for (int i = 0; i < blobs.length; i++){
    blobs[i] = new Blob(random(width), random(height));
  }
  //b = new Blob(100, 100);
  
  
}


void draw(){
  background(1);
  
  loadPixels();
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){ 
      int index = x + y * width;
      float sum = 0;
      for (Blob b: blobs) {           //for every blob look for distance 
          float d = dist(x, y, b.pos.x, b.pos.y);
          sum += 1500 * blobs[0].r / d;
    }
    
    pixels[index] = color(sum % 100, 220, 250);
    //constrain(sum, 0, 200)
    //color (x, 0, y); coloring every pixel, iso-surface
  }
  
  
  }
  
  updatePixels();
  
  for (Blob b: blobs) {
  b.update();
  //b.show();
  
  }
  
}
