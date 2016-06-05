public class TweenColor {
  
  
  protected int h, s, b;
  protected int dHMax, dSMax, dBMax;
  
  public TweenColor() {
    h = (int) random(0, 360);  
    s = (int) random(0, 100);
    b = (int) random(0, 100);
    dHMax = 5;
    dSMax = dBMax = 1;
  }
  
  public void update() {
    h += (int) random(0, dHMax);
    s += (int) random(0, dSMax);
    b += (int) random(0, dBMax);
    
    h %= 360;
    s %= 100;
    b %= 100;
  }
  
  public void fillColor() {
    
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