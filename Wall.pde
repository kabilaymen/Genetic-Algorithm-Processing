class Wall {
  float x, y, w, h;
  
  Wall(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void show() {
    stroke(0);
    strokeWeight(2);
    fill(0, 100);
    rect(x, y, w, h);
  }
}