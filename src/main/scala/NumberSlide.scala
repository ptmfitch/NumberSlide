import processing.core.{PApplet, PVector}
import Grid._

object NumberSlide extends PApplet {
  def main(args: Array[String]): Unit = {
    val numberSlide: NumberSlide = new NumberSlide
    PApplet.runSketch(Array("NumberSlide"), numberSlide)
  }
}

class NumberSlide extends PApplet {

  val grid: Grid = new Grid

  override def settings(): Unit = {
    size(400, 400)
  }

  override def setup(): Unit = {
    gridStart_=(new PVector(0, 0))
    gridEnd_=(new PVector(width, height))
    tileNum_=(4)
    grid.resetGrid()
  }

  override def draw(): Unit = {
    background(0)
    noStroke()
    fill(255)
    rect(gridStart.x, gridStart.y, gridWidth, gridHeight)
    grid.tiles.foreach(tile => {
      tile.update()
      stroke(0)
      fill(100, 200, 0)
      rect(tile.pos.x, tile.pos.y, tile.size, tile.size)
    })
  }

}
