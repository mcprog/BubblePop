/**
* @author Michael Curtis
* @since 6/3/2016
* @version 1.0.0
**/
ArrayList<Ball> balls = new ArrayList<Ball>();
int faults;

void setup() {
  size(960, 540);
  for (int i = 0; i < 30; ++i) {
      int radius = (int) random(10, 50);
      
      balls.add(new Ball(radius + random(width - 2 * radius), radius + random(height - 2 * radius), random(.2f, 2), random(.2f, 2), radius));
  }
  
}

void draw() {
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

void mousePressed() {
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
  
  
  
  
  