import java.util.Arrays;

Grid grid;
int score;
float topBarSize = 25;


void setup() {
  size(400, 400);
  background(255);
  grid = new Grid(100, 4);
}

void keyPressed() {
  grid.slide(keyCode);
}

void draw() {
  
  background(0);
  
  grid.display();
  
}