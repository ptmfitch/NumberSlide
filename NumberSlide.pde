import java.util.Arrays;

Grid grid;
int score;
float topBarSize = 25;


void setup() {
  noLoop();
  size(1000,1025);
  background(255);
  grid = new Grid(4);
}

void keyPressed() {
  grid.slide(keyCode);
  // TODO add checking to see if grid has changed after slide attempt, if not do not add tile
  if (!grid.addTile()) grid.initialiseBoard();
  redraw();
}

void draw() {
  
  background(0);
  
  grid.display();

  // Display score
  fill(255);
  text(String.valueOf(score), width / 2, height - topBarSize/2);
  
}