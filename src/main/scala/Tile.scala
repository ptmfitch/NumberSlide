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

  private var _vel: PVector = new PVector(0, 0)
  private var _num: Int = if (Math.random < 0.5) 2 else 4

  val size: Float = tileSize

  def pos: PVector = _pos
  def pos_=(value: PVector): Unit = _pos = value
  def posx_=(value: Float): Unit = _pos.x = value
  def posy_=(value: Float): Unit = _pos.y = value

  def vel: PVector = _vel
  def vel_=(value: PVector): Unit = _vel = value
  def velx_=(value: Float): Unit = _vel.x = value
  def vely_=(value: Float): Unit = _vel.y = value

  def num: Int = _num
  def doubleNum(): Unit = _num *= 2
  def resetNum(): Unit = _num = 0

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