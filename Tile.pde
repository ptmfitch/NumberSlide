class Tile {
  
  PVector pos; // The top left corner
  PVector vel;
  float size; // Length of each side
  int num; // Value of tile
  
  Tile(PVector pos_, float size_) {
    pos = pos_;
    size = size_;
    num = (Math.random()<0.5)?2:4;
  }
  
  int getNum() {
    return num;
  }
  
  void setNum(int num_) {
    num = num_;
  }
  
  void combine(Tile t_) {
    num += t_.getNum();
    t_.setNum(0);
  }

  void display() {
    
    stroke(0);
    color c = getColour();
    fill(c);
    rect(pos.x, pos.y, size, size);
    
    fill(0);
    text(String.valueOf(num), pos.x + size/2, pos.y + size/2);
  }

  color getColour() { // Returns an RGB colour value
    switch(num) {
      case 2:    return color(255, 255, 0);
      case 4:    return color(255, 0, 255);
      case 8:    return color(128, 128, 255);
      case 16:   return color(0, 255, 255);
      case 32:   return color(255, 0, 128);
      case 64:   return color(255, 128, 0);
      case 128:  return color(128, 255, 128);
      case 256:  return color(255, 255, 128);
      case 512:  return color(255, 128, 255);
      case 1024: return color(255, 128, 128);
      case 2048: return color(128, 255, 255);
      default:   return color(255, 255, 255);
    }    
  }
  
}