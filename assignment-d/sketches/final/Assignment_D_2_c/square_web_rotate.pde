class squareWebRotate {

  float x, y, z;
  float expand;
  float speed;
  float ex = 200;

  squareWebRotate() {

    x = 640;
    y = 360;
    speed = 4;
  }


  void display() {

    // fft.forward(in.mix);

    expand += speed;
    if (expand>500) {

      expand = 30;
    }

    pushMatrix();
    translate(x, y, z);
    noFill();
    stroke(100);
    strokeWeight(3);
    for (int i=0; i<fft.avgSize(); i++) {
      rotateZ(frameCount*(0.01*(fft.getAvg(i)*-10)));
    }

    for (int i=0; i<fft.avgSize(); i++) {
      box(ex+ fft.getAvg(i)*30);
    }

    popMatrix();
  }
}