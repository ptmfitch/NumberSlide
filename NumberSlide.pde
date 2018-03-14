import java.util.Arrays;

Grid grid;
int score;
float topBarSize = 25;
boolean isMoving;
boolean isStationary;


void setup() {
  size(400, 400);
  background(255);
  grid = new Grid(100, 4);
  isStationary = true;
  isMoving = false;
}

void keyPressed() {
  isMoving = grid.slide(keyCode);
}

void draw() {
  
  background(0);
  
  grid.display();
  
  grid.removeTiles();
  
  if (isMoving) { 
    if (grid.isStationary()) {
      isMoving = false;
      for(Tile tile : grid.tiles) {
        tile.combined = false;
      }
      grid.addTile();
    }
  }
  
}