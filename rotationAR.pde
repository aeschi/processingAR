/**
 * NyARToolkit for proce55ing/3.0.5
 * (c)2008-2017 nyatla
 * airmail(at)ebony.plala.or.jp
 * 
 * マーカファイルの変わりにPNGを使います。
 * PNGは任意解像度の正方形である必要があります。
 * PNG画像にはエッジ部分を含めてください。
 * 全ての設定ファイルとマーカファイルはスケッチディレクトリのlibraries/nyar4psg/dataにあります。
 * 
 * This sketch uses a PNG image instead of the standard patt file.
 * The PNG image must be square form that includes edge.
 * Any pattern and configuration files are found in libraries/nyar4psg/data inside your sketchbook folder. 
 */
import processing.video.*;
import jp.nyatla.nyar4psg.*;

Capture cam;
MultiMarker nya;

void setup() {
  size(640, 480, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya=new MultiMarker(this, width, height, "../../libraries/nyar4psg/data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker(loadImage("../../libraries/nyar4psg/data/hiro.png"), 16, 25, 80);
  cam.start();
}

void draw()
{
  if (cam.available() !=true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  background(0);
  nya.drawBackground(cam);
  
  if ((!nya.isExist(0))) {
    return;
  }

  nya.beginTransform(0);

  fill(0, 0, 255);
  drawgrid();
  translate(0, 0, 20);
  rotateX((float)frameCount/60);
  rotateY((float)frameCount/40);
  rotateZ((float)frameCount/30);
  myTriangulation();

  nya.endTransform();
}

// draw x,y,z-axis
void drawgrid() {
  pushMatrix();
  stroke(0);
  strokeWeight(2);
  line(0, 0, 0, 100, 0, 0);
  text("X", 100, 0, 0);
  line(0, 0, 0, 0, 100, 0);
  text("Y", 0, 100, 0);
  line(0, 0, 0, 0, 0, 100);
  text("Z", 0, 0, 100);
  popMatrix();
}

void myTriangulation() {

  // Maltes example
  stroke(237, 34, 93);
  strokeWeight(1);
  beginShape(TRIANGLES);

  // F R O N T
  // BOTTOM
  vertex(-10, 10, 10);
  vertex(0, 35, 10);
  vertex(10, 10, 10);
  // RIGHT
  vertex(10, 10, 10);
  vertex(35, 0, 10);
  vertex(10, -10, 10);
  // TOP
  vertex(10, -10, 10);
  vertex(0, -35, 10);
  vertex(-10, -10, 10);
  // LEFT
  vertex(-10, -10, 10);
  vertex(-35, 0, 10);
  vertex(-10, 10, 10);
  // CENTER LEFT
  vertex(-10, -10, 10);
  vertex(-10, 10, 10);
  vertex(10, 10, 10);
  // CENTER RIGHT
  vertex(-10, -10, 10);
  vertex(10, -10, 10);
  vertex(10, 10, 10);

  // L E F T
  // TOP BOTTOM LEFT
  vertex(0, -35, -10);
  vertex(-10, -10, 10);
  vertex(-10, -10, -10);
  // TOP TOP RIGHT
  vertex(0, -35, -10);
  vertex(0, -35, 10);
  vertex(-10, -10, 10);
  // MID TOP TOP RIGHT
  vertex(-10, -10, 10);
  vertex(-10, -10, -10);
  vertex(-35, 0, 10);
  // MID TOP BOTTOM LEFT
  vertex(-10, -10, -10);
  vertex(-35, 0, 10);
  vertex(-35, 0, -10);
  // MID BOTTOM TOP RIGHT
  vertex(-10, 10, 10);
  vertex(-10, 10, -10);
  vertex(-35, 0, 10);
  // MID BOTTOM BOTTOM LEFT
  vertex(-10, 10, -10);
  vertex(-35, 0, 10);
  vertex(-35, 0, -10);
  // BOTTOM BOTTOM LEFT
  vertex(0, 35, -10);
  vertex(-10, 10, 10);
  vertex(-10, 10, -10);
  // BOTTOM TOP RIGHT
  vertex(0, 35, -10);
  vertex(0, 35, 10);
  vertex(-10, 10, 10);

  // R I G H T
  // TOP BOTTOM LEFT
  vertex(0, -35, -10);
  vertex(10, -10, 10);
  vertex(10, -10, -10);
  // TOP TOP RIGHT
  vertex(0, -35, -10);
  vertex(0, -35, 10);
  vertex(10, -10, 10);
  // MID TOP TOP RIGHT
  vertex(10, -10, 10);
  vertex(10, -10, -10);
  vertex(35, 0, 10);
  // MID TOP BOTTOM LEFT
  vertex(10, -10, -10);
  vertex(35, 0, 10);
  vertex(35, 0, -10);
  // MID BOTTOM TOP RIGHT
  vertex(10, 10, 10);
  vertex(10, 10, -10);
  vertex(35, 0, 10);
  // MID BOTTOM BOTTOM LEFT
  vertex(10, 10, -10);
  vertex(35, 0, 10);
  vertex(35, 0, -10);
  // BOTTOM BOTTOM LEFT
  vertex(0, 35, -10);
  vertex(10, 10, 10);
  vertex(10, 10, -10);
  // BOTTOM TOP RIGHT
  vertex(0, 35, -10);
  vertex(0, 35, 10);
  vertex(10, 10, 10);

  // B A C K
  // BOTTOM
  vertex(-10, 10, -10);
  vertex(0, 35, -10);
  vertex(10, 10, -10);
  // RIGHT
  vertex(10, 10, -10);
  vertex(35, 0, -10);
  vertex(10, -10, -10);
  // TOP
  vertex(10, -10, -10);
  vertex(0, -35, -10);
  vertex(-10, -10, -10);
  // LEFT
  vertex(-10, -10, -10);
  vertex(-35, 0, -10);
  vertex(-10, 10, -10);
  // CENTER LEFT
  vertex(-10, -10, -10);
  vertex(-10, 10, -10);
  vertex(10, 10, -10);
  // CENTER RIGHT
  vertex(-10, -10, -10);
  vertex(10, -10, -10);
  vertex(10, 10, -10);

  endShape();
}
