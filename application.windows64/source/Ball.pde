class Ball {
  
  float x, y;
  int xDir, yDir;
  float dX, dY;
  int radius;
  //int hue, sat, bri;
  TweenHue hue;
  
  Ball(float x, float y, float dX, float dY, int radius) {
     this.x= x;
     this.y = y;
     this.xDir = 1;
     this.yDir = 1;
     this.dX = dX;
     this.dY = dY;
     this.radius = radius;
     hue = new TweenHue();
  }
  
  void drawBall() {
    noStroke();
    hue.fillColor();
    ellipse(x, y, 2 * radius, 2 * radius);
  }
  
  void update () {
    if (x + radius > width || x - radius <= 0) {
      xDir *= -1;
    }
    
    if (y + radius > height || y - radius <= 0) {
      yDir *= -1;
    }
    
    x += dX * xDir;
    y += dY * yDir;
    
    hue.update();
  }
  
  boolean popped () {
    float mouseDist = sqrt(sq(x - mouseX) + sq(y - mouseY));
    
    return mouseDist < radius;
  }
  
}