import processing.core.{PApplet, PVector}
import Grid._

import scala.collection.mutable.ArrayBuffer

object Grid {

  private var _gridStart: PVector = _
  def gridStart: PVector = _gridStart
  def gridStart_=(value: PVector): Unit = _gridStart = value

  private var _gridEnd: PVector = _
  def gridEnd: PVector = _gridEnd
  def gridEnd_=(value: PVector): Unit = _gridEnd = value

  private var _tileNum: Int = _
  def tileNum: Int = _tileNum
  def tileNum_=(value: Int): Unit = _tileNum = value

  def tileSize: Float = _gridEnd.x / _tileNum

  def gridWidth: Float = gridEnd.x - gridStart.x
  def gridHeight: Float = gridEnd.y - gridStart.y

}

class Grid extends PApplet {

  var tiles: ArrayBuffer[Tile] = new ArrayBuffer[Tile]()

  def resetGrid(): Unit = {
    (0 to 1).foreach(_ => addTile())
  }

  def addTile(): Unit = {
    new PVector(random(0, tileNum).toInt * tileSize, random(0, tileNum).toInt * tileSize) match {
      case pv if tiles.exists(_.pos == pv) => addTile()
      case pv => tiles.append(new Tile(pv))
    }
  }

}
