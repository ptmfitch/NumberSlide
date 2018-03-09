import java.util.Arrays;

class Grid {
  
  ArrayList<Tile> tiles;
  float len;
  float tileSize;
  
  Grid(int tileSize_, int len_) {
    tileSize = tileSize_;
    len = len_;
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
    while (isOccupied(randomPos)) randomPos = new PVector((int)random(0,len) * tileSize, (int)random(0,len) * tileSize);
    tiles.add(new Tile(randomPos, tileSize));
  }
  
  boolean isOccupied(PVector pos) {
    for (Tile tile : tiles) if (tile.pos.equals(pos)) return true;
    return false;
  }
  
  void slide(int pressed) {
    if (pressed == RIGHT) {
      
    } else if (pressed == LEFT) {
      
    } else if (pressed == UP) {

    } else if (pressed == DOWN) {

    }
  }
  
  void display() {
    for (Tile tile : tiles) tile.display();
  }

}