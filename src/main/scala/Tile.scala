import java.awt.Color

import processing.core.{PApplet, PVector}
import Grid._

object ColorPicker {
  def pickColor(n: Int): Int = n match {
    case 2 => new Color(255, 0, 0).getRGB
    case 4 => new Color(0, 255, 0).getRGB
    case 8 => new Color(0, 0, 255).getRGB
    case 16 => new Color(255, 255, 0).getRGB
    case 32 => new Color(255, 0, 255).getRGB
    case 64 => new Color(0, 255, 255).getRGB
    case 128 => new Color(255, 128, 0).getRGB
    case 256 => new Color(255, 0, 128).getRGB
    case 512 => new Color(128, 255, 0).getRGB
    case 1024 => new Color(128, 0, 255).getRGB
    case 2048 => new Color(0, 255, 128).getRGB
    case 4096 => new Color(0, 128, 255).getRGB
    case _ => new Color(0, 0, 0).getRGB
  }
}

object Direction extends Enumeration {

  type Direction = PVector

  val Up: PVector = new PVector(0, -1)
  val Right: PVector = new PVector(1, 0)
  val Down: PVector = new PVector(0, 1)
  val Left: PVector = new PVector(-1, 0)

}

class Tile(private var _pos: PVector) extends PApplet {
  def pos: PVector = _pos.copy()
  def pos_=(value: PVector): Unit = _pos = value
  def posX_=(value: Float): Unit = _pos.x = value
  def posY_=(value: Float): Unit = _pos.y = value

  private var _nextPos: PVector = _pos.copy()
  def nextPos: PVector = _nextPos.copy()
  def nextPos_=(value: PVector): Unit = _nextPos = value
  def nextPosX_=(value: Float): Unit = _nextPos.x = value
  def nextPosY_=(value: Float): Unit = _nextPos.y = value

  private var _isActive: Boolean = true
  def isActive: Boolean = _isActive
  //noinspection AccessorLikeMethodIsUnit
  def isActive_=(value: Boolean): Unit = _isActive = value

  private var _vel: PVector = new PVector(0, 0)
  def vel: PVector = _vel.copy()
  def vel_=(value: PVector): Unit = _vel = value
  def velX_=(value: Float): Unit = _vel.x = value
  def velY_=(value: Float): Unit = _vel.y = value

  private var _num: Int = if (Math.random < 0.5) 2 else 4
  def num: Int = _num
  def num_=(value: Int): Unit = _num = value

  private var _nextNum: Int = _num
  def nextNum: Int = _nextNum
  def nextNum_=(value: Int): Unit = _nextNum = value

  val size: Float = tileSize

  def checkEdges(): Unit = _pos match {
    case _ if _pos.x < gridStart.x => pos.x = gridStart.x
    case _ if _pos.x > gridEnd.x - size => pos.x = gridEnd.x - size
    case _ if _pos.y < gridStart.y => pos.y = gridStart.y
    case _ if _pos.y > gridEnd.y - size => pos.y = gridEnd.y - size
  }

  def update(): Unit = {
    _pos.add(_vel)
  }

}