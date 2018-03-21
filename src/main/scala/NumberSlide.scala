import processing.core.{PApplet, PConstants, PVector}
import Grid._
import Direction._

object NumberSlide extends PApplet {
  def main(args: Array[String]): Unit = {
    val numberSlide: NumberSlide = new NumberSlide
    PApplet.runSketch(Array("NumberSlide"), numberSlide)
  }
}

class NumberSlide extends PApplet with PConstants {

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

  override def keyPressed(): Unit = keyCode match {
    case _ if KeyConfig.left.contains(keyCode) => grid.slide(Left)
    case _ if KeyConfig.up.contains(keyCode) => grid.slide(Up)
    case _ if KeyConfig.right.contains(keyCode) => grid.slide(Right)
    case _ if KeyConfig.down.contains(keyCode) => grid.slide(Down)
    case _ => println("Unrecognised keyCode: " + keyCode)
  }

  override def draw(): Unit = {
    background(0)
    noStroke()
    fill(255)
    rect(gridStart.x, gridStart.y, gridWidth, gridHeight)
    grid.tiles.foreach(tile => {
      tile.update()
      stroke(0)
      fill(ColorPicker.pickColor(tile.num))
      rect(tile.pos.x, tile.pos.y, tile.size, tile.size, tile.size / 8)
      fill(0)
      textAlign(PConstants.CENTER)
      text(tile.num, tile.pos.x + tileSize/2, tile.pos.y + tileSize/2)
    })
  }

}
