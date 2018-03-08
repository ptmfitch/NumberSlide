class Tile {
  private int n;
  private float r, c, s;
  
  Tile(float r_, float c_, float s_) {
    r = r_;
    c = c_;
    s = s_;
    n = (Math.random()<0.5)?2:4; // Randomly chooses 2 or 4 for new numbers
  }
  
  Tile(float r_, float c_, float s_, int n_) {
    r = r_;
    c = c_;
    s = s_;
    n = n_;
  }
  
  int getN() {
    return n;
  }
  
  void setN(int n_) {
    n = n_;
  }
  
  void doubleN() {
    n *= 2;
  }
  
  void combine(Tile t_) {
    n += t_.getN();
    t_.setN(0);
  }
  
  boolean sameAs(Tile t_) {
    return n == t_.getN();
  }
  
  boolean sameAs(int n_) {
    return n == n_;
  }

  boolean isEmpty() {
    return n == 0;
  }
  
  boolean nonEmpty() {
    return n != 0;
  }

  void display() {
    int[] col = getColour();
    stroke(0);
    fill(col[0], col[1], col[2]);
    rect(c,r,s,s);
    fill(0);
    if (!isEmpty()) text(String.valueOf(n), c+s/2, r+s/2);
  }

  int[] getColour() { // Returns an RGB colour value
    switch(n) {
      case 0:    return new int[]{255, 255, 255};
      case 2:    return new int[]{255, 255,   0};
      case 4:    return new int[]{255,   0, 255};
      case 8:    return new int[]{128, 128, 255};
      case 16:   return new int[]{  0, 255, 255};
      case 32:   return new int[]{255,   0, 128};
      case 64:   return new int[]{255, 128,   0};
      case 128:  return new int[]{128, 255, 128};
      case 256:  return new int[]{255, 255, 128};
      case 512:  return new int[]{255, 128, 255};
      case 1024: return new int[]{255, 128, 128};
      case 2048: return new int[]{128, 255, 255};
      default:   return new int[]{255, 255, 255};
    }    
  }
}