import processing.core.PApplet

object NumberSlide extends PApplet {
  def main(args: Array[String]): Unit = {
    val numberSlide: NumberSlide = new NumberSlide
    PApplet.runSketch(Array("NumberSlide"), numberSlide)
  }
}

class NumberSlide extends PApplet {
  override def setup(): Unit = {}
  override def draw(): Unit = {}
}
