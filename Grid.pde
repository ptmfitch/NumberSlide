import java.util.Arrays;

class Grid {
  
  //REFACTOR AS A STATE MACHINE
  // 1 - button pressed
  // 2 - calculate next state
  // 3 - if different show sliding animation, add new tile when finished, else do nothing
  
  ArrayList<Tile> tiles;
  float len;
  float tileSize;
  PVector boundary;
  int speed = 4; // Speed is tiles per second
  
  Grid(int tileSize_, int len_) {
    tileSize = tileSize_;
    len = len_;
    boundary = new PVector((len - 1) * tileSize, (len - 1) * tileSize);
    initialiseBoard();
  }
  
  void initialiseBoard() {
    score = 0;
    tiles = new ArrayList<Tile>();
    addTile();
    addTile();
  }
  
  void removeTiles() {
    for (int i = 0; i < tiles.size(); i++) {
      Tile tile = tiles.get(i);
      tile.findNeighbour(tiles);
      if (tile.num == 0) {
        tiles.remove(tile);
        i--;
      }
    }
  }
  
  void addTile() {
    PVector randomPos = new PVector((int)random(0,len) * tileSize, (int)random(0,len) * tileSize);
    while (isOccupied(randomPos)) {
      randomPos = new PVector((int)random(0,len) * tileSize, (int)random(0,len) * tileSize);
    }
    tiles.add(new Tile(randomPos, tileSize, boundary));
  }
  
  boolean isOccupied(PVector pos) {
    for (Tile tile : tiles) if (tile.pos.equals(pos)) return true;
    return false;
  }
  
  boolean slide(int pressed) {
    PVector vel = null;
    if (pressed == RIGHT) {
      vel = new PVector(tileSize/speed, 0);
    } else if (pressed == LEFT) {
      vel = new PVector(-tileSize/speed, 0);
    } else if (pressed == UP) {
      vel = new PVector(0, -tileSize/speed);
    } else if (pressed == DOWN) {
      vel = new PVector(0, tileSize/speed);
    }
    if (vel == null) return false;
    for (Tile tile : tiles) {
      tile.findNeighbour(tiles);
      tile.vel = vel;
    }
    return true;
  }
  
  boolean isStationary() {
    for (Tile tile : tiles) {
      if (tile.vel.mag() > 0) {
        return false;
      }
    }
    return true;
  }
  
  void display() {
    for (Tile tile : tiles) tile.display();
  }

}