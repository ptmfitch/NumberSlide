import java.util.Arrays;

class Grid {
  
  ArrayList<Tile> tiles;
  float len;
  float tileSize;
  PVector boundary;
  
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
  
  void slide(int pressed) {
    PVector vel;
    PVector offset = null;
    if (pressed == RIGHT) {
      vel = new PVector(10, 0);
      offset = new PVector(tileSize, 0);
    } else if (pressed == LEFT) {
      vel = new PVector(-10, 0);
      offset = new PVector(-tileSize, 0);
    } else if (pressed == UP) {
      vel = new PVector(0, -10);
      offset = new PVector(0, -tileSize);
    } else if (pressed == DOWN) {
      vel = new PVector(0, 10);
      offset = new PVector(0, tileSize);
    } else {
      vel = new PVector(0, 0);
    }
    for (Tile tile : tiles) {
      tile.neighbour = findNeighbour(tile, offset);
      tile.vel = vel;
    }
  }
  
  Tile findNeighbour(Tile tile, PVector offset) {
    if (offset == null) return null;
    PVector search = PVector.add(tile.pos, offset);
    while (search.x >= 0 && search.x <= boundary.x && search.y >= 0 && search.y <= boundary.y) {
      for (Tile toSearch : tiles) {
        if (toSearch.pos.equals(search)) return toSearch;
      }
      search.add(offset);
    }
    return null;
  }
  
  void display() {
    for (Tile tile : tiles) tile.display();
  }

}