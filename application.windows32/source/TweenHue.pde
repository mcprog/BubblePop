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