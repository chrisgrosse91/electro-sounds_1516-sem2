class squareWeb {



  squareWeb() {
  }


  void display() {

    // fft.forward(in.mix);

    pushMatrix();
    translate(width/2, height/2);
    noFill();
    stroke(100);
    strokeWeight(3);
    rotateX(frameCount*0.01);

    for (int i=0; i<fft.avgSize(); i++) {
      box(380 + fft.getAvg(i) * 20);
    }

    popMatrix();
  }
}