class circleExpander2 {

  int morph;
  float speed;
  float boom =75;
  float speedo;
  float up;
  float speedy = 1;
  float x;
  float speedoo;

  circleExpander2() {
  }

  void display() {

    // fft.forward(in.mix);

    speed = 1;
    morph += speed;

    x = random(350, 610);
    //x = random(

    //boom += speedo;
    //speedo = 10;

    //if(boom>500){
    // boom = 100; 
    //}

    if (morph > 29) {
      morph = 0;
    }

    up += speedy;
    if (up > 100) {
      up = 5;
    }

    pushMatrix();
    translate(640, 560);
    //noFill();
    fill(255, 20);
    stroke(0, 255, 0, 100);
    rotateY(frameCount*0.01);
    int numOfSpheres = 10;
    for (int i=0; i<numOfSpheres; i++) {
      sphere(boom + fft.getAvg(i)*(up));
      scale(1);
      fill(255, 0, 0, 30);
      sphere(boom + fft.getAvg(i)*(30));
    }
    sphereDetail(morph, morph);
    lights();
    popMatrix();
  }
}