import processing.core.PApplet

object NumberSlide extends PApplet {

  def main(args: Array[String]): Unit = {
    val processingArgs: Array[String] = Array("NumberSlide")
    val numberSlide: NumberSlide = new NumberSlide
    PApplet.runSketch(processingArgs, numberSlide)
  }
}

class NumberSlide extends PApplet {
  override def setup(): Unit = {}
  override def draw(): Unit = {}
}
