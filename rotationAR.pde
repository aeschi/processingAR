import processing.video.*;
import jp.nyatla.nyar4psg.*; // repo: https://github.com/nyatla/NyARToolkit-for-Processing

Capture cam; 
MultiMarker nya;

void setup() {
  size(640, 480, P3D);
  colorMode(RGB, 100);
  println(MultiMarker.VERSION);

  // webcam capture
  cam=new Capture(this, 640, 480); 

  // check/adjust path to marker library
  nya=new MultiMarker(this, width, height, "../../../libraries/nyar4psg/data/camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker(loadImage("../../../libraries/nyar4psg/data/hiro.png"), 16, 25, 80);

  // starts capturing frames from an attached device.
  cam.start();
}

void draw() {
  
  // check for camera
  if (cam.available() !=true) {
    return;
  }
  
  cam.read();
  
  // check if frame/image exists
  nya.detect(cam);
  
  // draw camera frames
  nya.drawBackground(cam);

  // check for marker
  if ((!nya.isExist(0))) {
    println("no marker visible");
    return;
  }

  // translate according to marker position in space
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


// object shape path
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
