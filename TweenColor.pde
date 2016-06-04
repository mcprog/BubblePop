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