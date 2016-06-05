class TweenHue extends TweenColor {
  
  public TweenHue() {
    s = 100;
    b = 100;
    dHMax = 2;
  }
  
  @Override
  public void update() {
    h += (int) random(0, dHMax);
    h %= 360;
  }
  
}