import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BubblePop extends PApplet {


ArrayList<Ball> balls = new ArrayList<Ball>();
int faults;

public void setup() {
  
  for (int i = 0; i < 30; ++i) {
      int radius = (int) random(10, 50);
      
      balls.add(new Ball(radius + random(width - 2 * radius), radius + random(height - 2 * radius), random(.2f, 2), random(.2f, 2), radius));
  }
  
}

public void draw() {
    background(0);
    for (Ball b : balls) {
      if (b == null) {
        continue;
      }
      b.update();
      b.drawBall();
      
    }
    fill(255);
    text("Faults: " + faults, 10, 18);
}

public void mousePressed() {
  boolean poppedABall = false;
  for (int i = balls.size() - 1; i >= 0; --i) {// backwards loop to remove most forward (z-order) first
    if (balls.get(i).popped()) {
        balls.remove(i);
        println("popped");
        poppedABall = true;
        break;
    }
  }
  if (!poppedABall) {
      int radius = (int) random(10, 50);
      int correctMX = mouseX <= radius ? radius + 2 : mouseX > width - radius ?  width - radius : mouseX;
      int correctMY = mouseY <= radius ? radius + 2 : mouseY > height - radius ?  height - radius : mouseY;
      balls.add(new Ball(correctMX, correctMY, random(.2f, 2), random(.2f, 2), radius));
      ++faults;
  }
}  
  
  
  
  
  
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
  
  public void drawBall() {
    noStroke();
    hue.fillColor();
    ellipse(x, y, 2 * radius, 2 * radius);
  }
  
  public void update () {
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
  
  public boolean popped () {
    float mouseDist = sqrt(sq(x - mouseX) + sq(y - mouseY));
    
    return mouseDist < radius;
  }
  
}
public class TweenColor {
  
  
  protected int h, s, b;
  protected int dHMax, dSMax, dBMax;
  
  public TweenColor() {
    h = (int) random(0, 255);  
    s = (int) random(0, 255);
    b = (int) random(0, 255);
    dHMax = 5;
    dSMax = dBMax = 1;
  }
  
  public void update() {
    h += (int) random(0, dHMax);
    s += (int) random(0, dSMax);
    b += (int) random(0, dBMax);
    
    h %= 255;
    s %= 255;
    b %= 255;
  }
  
  public void fillColor() {
    colorMode(HSB, 255);
    fill(h, s, b);
  }
  
  public int getH() {
    return h;
  }
  
  public int getS() {
    return s;
  }
  
  public int getB() {
    return b;
  }
  
  

  
  
  
  
  
}  
class TweenHue extends TweenColor {
  
  public TweenHue() {
    s = 255;
    b = 255;
    dHMax = 2;
  }
  
  @Override
  public void update() {
    h += (int) random(0, dHMax);
    h %= 255;
  }
  
}
  public void settings() {  size(960, 540); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BubblePop" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
