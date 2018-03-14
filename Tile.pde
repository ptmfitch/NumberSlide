class Tile {
  
  PVector pos; // The top left corner
  PVector vel;
  float size; // Length of each side
  int num; // Value of tile
  boolean combined;
  
  Tile neighbour;
  
  PVector maxPos;
  
  Tile(PVector pos_, float size_, PVector maxPos_) {
    vel = new PVector(0, 0);
    pos = pos_;
    maxPos = maxPos_;
    size = size_;
    num = (Math.random()<0.5)?2:4;
    combined = false;
  }
  
  int getNum() {
    return num;
  }
  
  void setNum(int num_) {
    num = num_;
  }
  
  int getDir() {
    if (vel.x == 0 && vel.y < 0) {
      return 0; // UP
    } else if (vel.y == 0 && vel.x > 0) {
      return 1; // RIGHT
    } else if (vel.x == 0 && vel.y > 0) {
      return 2; // DOWN
    } else if (vel.y == 0 && vel.x < 0) {
      return 3; // LEFT
    } else {
      return -1; // OTHER
    }
  }
  
  void collide() {
    if (neighbour == null) return;      
    if (Math.abs(neighbour.pos.x - pos.x) < size && vel.x != 0) { // Horizontal collision
      if (num == neighbour.num && !neighbour.combined) {
        num = 0;
        neighbour.num *= 2;
        neighbour.combined = true;
        return;
      }
      float offset = size;
      if (vel.x > 0) offset *= -1;
      pos.x = neighbour.pos.x + offset;
      vel = neighbour.vel;
    } else if (Math.abs(neighbour.pos.y - pos.y) < size && vel.y != 0) {
      if (num == neighbour.num && !neighbour.combined) {
        num = 0;
        neighbour.num *= 2;
        neighbour.combined = true;
        return;
      }
      float offset = size;
      if (vel.y > 0) offset *= -1;
      pos.y = neighbour.pos.y + offset;
      vel = neighbour.vel;
    }
  }

  void display() {
    
    checkEdges();
    if (vel.mag() != 0) collide();
    
    pos.add(vel);
    
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
  
  void checkEdges() {
    if (pos.x < 0) {
      pos.x = 0;
      vel = new PVector(0, 0);
    } else if (pos.x > maxPos.x) {
      pos.x = maxPos.x;
      vel = new PVector(0, 0);
    }
    if (pos.y < 0) {
      pos.y = 0;
      vel = new PVector(0, 0);
    } else if(pos.y > maxPos.y) {
      pos.y = maxPos.y;
      vel = new PVector(0, 0);
    }
  }
  
  void findNeighbour(ArrayList<Tile> tiles) {
    Tile neighbour_ = null;
    for (Tile toSearch : tiles) {
      switch(getDir()) {
        case 0: // UP
          if (toSearch.pos.x == pos.x && toSearch.pos.y < pos.y) {
            if (neighbour_ == null) {
              neighbour_ = toSearch;
            } else {
              if (toSearch.pos.y > neighbour_.pos.y) neighbour_ = toSearch;
            }
          }
          break;
        case 1: // RIGHT
          if (toSearch.pos.y == pos.y && toSearch.pos.x > pos.x) {
            if (neighbour_ == null) {
              neighbour_ = toSearch;
            } else {
              if (toSearch.pos.x < neighbour_.pos.x) neighbour_ = toSearch;
            }
          }
          break;
        case 2: // DOWN
          if (toSearch.pos.x == pos.x && toSearch.pos.y > pos.y) {
            if (neighbour_ == null) {
              neighbour_ = toSearch;
            } else {
              if (toSearch.pos.y < neighbour_.pos.y) neighbour_ = toSearch;
            }
          }
          break;
        case 3: // LEFT
          if (toSearch.pos.y == pos.y && toSearch.pos.x < pos.x) {
            if (neighbour_ == null) {
              neighbour_ = toSearch;
            } else {
              if (toSearch.pos.x > neighbour_.pos.x) neighbour_ = toSearch;
            }
          }
          break;
        default:
          break;
      }
    }
    neighbour = neighbour_;
  }
  
}