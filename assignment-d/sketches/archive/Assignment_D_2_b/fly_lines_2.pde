class flyLines2 {

  float x1;
  float x2;
  float thicky;
  float x, y, z;
  float speed = random(-8, 8);

  flyLines2() {

    x = random(1960);
    y = random(1800);
  }

  void display() {

    x += speed;
    x %= width;



    thicky = random(0.5, 2);
    x1 = random(30);
    x2 = random(40, 100);

    stroke(255, 150);
    strokeWeight(thicky);
    pushMatrix();
    translate(x, y, z);
    line(x1, 0, x2, 0);
    popMatrix();
  }


  void move() {

    //speed = random(-3,3);
  }
}