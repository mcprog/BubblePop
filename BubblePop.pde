import processing.sound.*;


/**
* @author Michael Curtis
* @since 6/3/2016
* @version 1.1.0
**/
ArrayList<Ball> balls = new ArrayList<Ball>();
int faults;
int sexySecs;
SoundFile pop;
SoundFile bubble;
PImage screenShot;
PImage helpIcon;
boolean helpWhite;
float helpScale;
float helpAlpha;

public static final String[] HELP_LINES = {
    "Welcome to BubblePop", 
    "------------------------------",
    "BubblePop is all about precision.",
    "",
    "Goal: pop all the bubbles as fast and",
    "precisely as possible.",
    "",
    "Faults: Every time you miss-click, a new", 
    "bubble spawns. This is a fault. Try to",
    "get as few faults as possible."};

public static final String SCREENSHOT_PATH = "data/BubblePop.png";
public static final int MENU_HEIGHT = 30;

void setup() {
  size(960, 540);
  pop = new SoundFile(this, "pop-cut.wav");
  bubble = new SoundFile(this, "bubble-tiny.wav");
  for (int i = 0; i < 30; ++i) {
      int radius = (int) random(10, 50);
      
      balls.add(new Ball(radius + random(width - 2 * radius), radius + random(height - 2 * radius - Ball.MARGIN_TOP) + Ball.MARGIN_TOP, random(.2f, 2), random(.2f, 2), radius));
  }
  helpIcon = loadImage("ic_help_black_24dp_1x.png");

}

void draw() {
    background(0);
    colorMode(HSB, 360, 100, 100, 100);
    for (Ball b : balls) {
      if (b == null) {
        continue;
      }
      b.update();
      b.drawBall();
      
    }
    
    drawHelpMenu();
     
    
    fill(360, 0, 50);
    rect(0, 0, width, MENU_HEIGHT);
    
    fill(0, 0, 100);
    textSize(14);
    textAlign(LEFT, TOP);
    text("Faults: " + faults, 10, 5);
    textAlign(CENTER, TOP);
    text("\"r\" to reset, \"s\" to screenshot", width / 2, 5);
    if (balls.size() > 0) {
      
      ++sexySecs;
    }
    textAlign(RIGHT, TOP);
    text("Time: " + sexySecs / 60, width - 70, 5);
    
    
    
    imageMode(CENTER);
    image(helpIcon, width - 20, MENU_HEIGHT / 2);
    
    
}

void drawHelpMenu() {
  fill(360, 0, 25, 85);
  final int rectWidth = 250;
  final int margin = 5;
  pushMatrix();
  scale(1, helpScale);
  rect(width - rectWidth - margin, MENU_HEIGHT + margin, rectWidth, 170, 3, 3, 3, 3);
  triangle(width - 25, MENU_HEIGHT + margin, width - 20, MENU_HEIGHT, width - 15, MENU_HEIGHT + margin);
  popMatrix();
  if (helpWhite) {   
    if (helpScale < 1) {
      helpScale += .05f;
    } 
    else if (helpAlpha < 1) {
      helpAlpha += .05f;
    }
  } else {
    if (helpAlpha > 0) {
      helpAlpha -= .1f;
    }
    else if (helpScale > 0) {
      helpScale -= .1f;
    }
    
  }
  
  //textWidth(rectWidth - 2 * margin);
  textAlign(LEFT, TOP);
  textSize(18);
  fill(0, 0, 100, helpAlpha * 100);
  text(HELP_LINES[0], width - rectWidth + margin, MENU_HEIGHT + 2 * margin);
  textAlign(LEFT, TOP);
  textSize(12);
  final float dY = textAscent() + textDescent();
  for (int i = 1; i < HELP_LINES.length; ++i) {
    text(HELP_LINES[i], width - rectWidth + margin, MENU_HEIGHT + 3 * margin + dY * i);
  }
  
  
}

void mousePressed() {
  if (mouseY <= MENU_HEIGHT) {
    float distFromHelp = sqrt(sq(width - 20 - mouseX) + sq(15 - mouseY));
    if (distFromHelp <= 10) {
      helpIcon.filter(INVERT);
      helpWhite = !helpWhite;
    }
    return;
  }
  boolean poppedABall = false;
  for (int i = balls.size() - 1; i >= 0; --i) {// backwards loop to remove most forward (z-order) first
    if (balls.get(i).popped()) {
        balls.remove(i);
        pop.play();
        poppedABall = true;
        break;
    }
  }
  if (!poppedABall) {
      int radius = (int) random(10, 50);
      int correctMX = mouseX <= radius ? radius + 2 : mouseX > width - radius ?  width - radius : mouseX;
      int correctMY = mouseY <= radius + MENU_HEIGHT ? radius + 2 + MENU_HEIGHT : mouseY > height - radius ?  height - radius: mouseY;
      balls.add(new Ball(correctMX, correctMY, random(.2f, 2), random(.2f, 2), radius));
      bubble.play();
      ++faults;
  }
}

void keyReleased() {
  
    if (key == 'r') {
      balls.clear();
      faults = 0;
      sexySecs = 0;
      for (int i = 0; i < 30; ++i) {
        int radius = (int) random(10, 50);
        
        balls.add(new Ball(radius + random(width - 2 * radius), radius + random(height - 2 * radius - Ball.MARGIN_TOP) + MENU_HEIGHT, random(.2f, 2), random(.2f, 2), radius));
      }
    }
    if (key == 's') {
      screenShot();
    }
  
}

void screenShot() {
  
  saveFrame(SCREENSHOT_PATH);
  screenShot = loadImage(SCREENSHOT_PATH);
  selectFolder("Select folder to save screenshot to:", "folderSelected");
}

void folderSelected(File folder) {
  if (folder == null) {
    println("Window was closed or the user hit cancel. Screenshot saved at " + sketchPath(SCREENSHOT_PATH));
  } else {
    screenShot.save(folder.getPath() + SCREENSHOT_PATH);
  }
}
  
  
  
  
  
  