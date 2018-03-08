import java.util.Arrays;

class Grid {
  Tile[][] board;
  float tileSize;
  
  Grid(int n) {
    tileSize = (height - topBarSize) / n;
    board = new Tile[n][n];
    initialiseBoard();
  }
  
  void initialiseBoard() {
    score = 0;
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        board[i][j] = new Tile(i*tileSize, j*tileSize, tileSize, 0);
      }
    }
    addTile();
    addTile();
  }
  
  boolean isGameOver() {
    for(int i = 0; i < board.length; i++) {
      for(int j = 0; j < board[i].length; j++) {
        if (board[i][j].isEmpty()) return false;
      }
    }
    return true;
  }
  
  boolean addTile() {
    if (isGameOver()) return false;
    int randX = (int)random(0,board.length);
    int randY = (int)random(0,board[randX].length);
    while (board[randX][randY].nonEmpty()) {
      randX = (int)random(0,board.length);
      randY = (int)random(0,board[randX].length);
    }
    board[randX][randY] = new Tile(randX*tileSize, randY*tileSize, tileSize);
    return true;
  }
  
  void slide(int pressed) {
    if (pressed == RIGHT) {
      doMove();
    } else if (pressed == LEFT) {
      flip();
      doMove();
      flip();
    } else if (pressed == UP) {
      rotateClockwise();
      doMove();
      rotateAntiClockwise();
    } else if (pressed == DOWN) {
      rotateAntiClockwise();
      doMove();
      rotateClockwise();
    }
  }
  
  void display() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        board[i][j].display();
      }
    }
  }
  
  void doMove() {
    Tile[][] prev = takeCopy();
    for (int i = 0; i < board.length; i++) {
      Tile[] row = board[i].clone();
      int lastInt = -1;
      int lastIntIndex = -1;
      // Combine consecutive non-zero tiles
      for (int j = row.length - 1; j >= 0; j--) {
        if (row[j].nonEmpty()) {
          if (row[j].sameAs(lastInt)) {
            row[lastIntIndex].combine(row[j]);
            score += row[lastIntIndex].getN();
            lastIntIndex = -1;
            lastInt = -1;
          } else {
            lastInt = row[j].getN();
            lastIntIndex = j;
          }
        }
      }
      // Slide everything along
      int cur = row.length - 1;
      for (int j = row.length -1; j >= 0; j--) {
        if (row[j].nonEmpty()) {
          if(j != cur) {
            row[cur].combine(row[j]);
          } 
          cur--;
        }
      }
      board[i] = row.clone();
    }
  }
  
  void rotateClockwise() {
    Tile[][] rotated = new Tile[board[0].length][board.length];
    for (int i = 0; i < board[0].length; i++) {
      for (int j = 0; j < board.length; j++) {
        rotated[i][j] = board[board.length - j - 1][i];
      }
    }
    board = rotated.clone();
  }
  
  void rotateAntiClockwise() {
    Tile[][] rotated = new Tile[board[0].length][board.length];
    for (int i = 0; i < board[0].length; i++) {
      for (int j = 0; j < board.length; j++) {          
        rotated[i][j] = board[j][board[0].length - i - 1];
      }
    }
    board = rotated.clone();
  }
  
  void flip() {
    for(int i = 0; i < board.length; i++) {
      for(int j = 0; j < board[i].length / 2; j++) {
        Tile temp = board[i][j];
        board[i][j] = board[i][board[i].length - j - 1];
        board[i][board[i].length - j - 1] = temp;
      }
    }
  }
  
  Tile[][] takeCopy() {
    Tile[][] copy = new Tile[board.length][board[0].length];
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        copy[i][j] = board[i][j];
      }
    }
    return copy;
  }
  
  boolean sameAs(Tile[][] prev) {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if(!board[i][j].sameAs(prev[i][j])) {
          return false;
        }
      }
    }
    return true;
  }
}