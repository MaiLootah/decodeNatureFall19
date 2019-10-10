class Walker {
  constructor (){
    this.x = width/2;
    this.y = height/2;
  }
  


  render() {
    stroke(0,g,b,a);
    fill(r,g,b,a);
    //point(this.x,this.y);
    strokeWeight(1);
    ellipse(this.x,this.y,30,30);
  
  }
  
  render2() {
    stroke(r,0,b,a);
    fill(r,g,b,a);
    //point(this.x,this.y);
    strokeWeight(1);
    ellipse(this.x,this.y,30,30);
    
  }
  
  render3() {
    stroke(0,0,b,100);
    fill(r,g,b,a);
    //point(this.x,this.y);
    strokeWeight(1);
    ellipse(this.x,this.y,30,30);
    
  }

  step() {
    var choice = floor(random(4));
    if (choice === 0) {
      this.x++;
    } else if (choice === 1) {
      this.x--;
    } else if (choice === 2) {
      this.y++;
    } else {
      this.y--;
    }
    this.x = constrain(this.x,0,width-1);
    this.y = constrain(this.y,0,height-1);
  }
  

  
  
  

}
