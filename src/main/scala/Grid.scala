import processing.core.{PApplet, PVector}
import Grid._
import Direction._

import scala.collection.immutable
import scala.collection.mutable.ArrayBuffer

object Grid {

  private var _gridStart: PVector = _
  def gridStart: PVector = _gridStart.copy()
  def gridStart_=(value: PVector): Unit = _gridStart = value

  private var _gridEnd: PVector = _
  def gridEnd: PVector = _gridEnd.copy()
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
    tiles = new ArrayBuffer[Tile]()
    (0 to 1).foreach(_ => addTile())
  }
  
  def tiles_=(ts: Iterable[Tile]): Unit = {
    tiles = new ArrayBuffer[Tile]()
    tiles ++= ts
  }

  def addTile(): Unit = {
    new PVector(random(0, tileNum).toInt * tileSize, random(0, tileNum).toInt * tileSize) match {
      case pv if tiles.exists(_.pos == pv) => addTile()
      case pv => tiles.append(new Tile(pv))
    }
  }

  def slide(dir: Direction): Unit = {
    dir match {
      case Left =>
        val collapsed: Iterable[List[Tile]] = tiles.sortBy(_.pos.x).groupBy(_.pos.y).map { case (_, ts) => collapse(ts.toList) }
        collapsed.foreach(row => {
          var n = 0
          row.foreach {
            case tile if !tile.isActive => tile.nextPosX_=(-tile.size)
            case tile =>
              tile.nextPosX_=(n * tile.size)
              n += 1
          }
        })
        tiles_=(collapsed.flatten)
      case Up =>
        val collapsed: Iterable[List[Tile]] = tiles.sortBy(_.pos.y).groupBy(_.pos.x).map { case (_, ts) => collapse(ts.toList) }
        collapsed.foreach(col => {
          var n = 0
          col.foreach {
            case tile if !tile.isActive => tile.nextPosY_=(-tile.size)
            case tile =>
              tile.nextPosY_=(n * tile.size)
              n += 1
          }
        })
        tiles_=(collapsed.flatten)
      case Right =>
        val collapsed: Iterable[List[Tile]] = tiles.sortBy(_.pos.x).reverse.groupBy(_.pos.y).map { case (_, ts) => collapse(ts.toList) }
        collapsed.foreach(row => {
          var n = 0
          row.foreach {
            case tile if !tile.isActive => tile.nextPosX_=(gridWidth)
            case tile =>
              tile.nextPosX_=(gridWidth - (n + 1) * tile.size)
              n += 1
          }
        })
        tiles_=(collapsed.flatten)
      case Down =>
        val collapsed: Iterable[List[Tile]] = tiles.sortBy(_.pos.y).reverse.groupBy(_.pos.x).map { case (_, ts) => collapse(ts.toList) }
        collapsed.foreach(col => {
          var n = 0
          col.foreach {
            case tile if !tile.isActive => tile.nextPosY_=(gridHeight)
            case tile =>
              tile.nextPosY_=(gridHeight - (n + 1) * tile.size)
              n += 1
          }
        })
        tiles_=(collapsed.flatten)
    }
    val isChanged: Boolean = !tiles.forall(tile => tile.isActive && tile.num == tile.nextNum && tile.pos == tile.nextPos)
    tiles_=(tiles.filter(_.isActive))
    tiles.foreach(tile => {
      tile.num_=(tile.nextNum)
      tile.pos_=(tile.nextPos)
    })
    if (isChanged) addTile()
  }

  def collapse(ts: List[Tile]): List[Tile] = ts match {
    case _ if ts.isEmpty => ts
    case h :: Nil => List(h)
    case h :: t if h.num == t.head.num =>
      h.nextNum_=(h.num * 2)
      t.head.isActive_=(false) // Set merged tile for deletion
      if (t.tail.nonEmpty) List(h, t.head) ++ collapse(t.tail) else List(h, t.head)
    case h :: t => h +: collapse(t)
  }


}
