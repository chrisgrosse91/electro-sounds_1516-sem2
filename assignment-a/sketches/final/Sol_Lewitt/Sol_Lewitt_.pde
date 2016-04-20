//https://github.com/fabiantheblind/sol-lewitt-processing
//based off fabiantheblind's code 
//Christopher's Code 25/1/15

int x = int(random(width));
int y = int(random(height));

Boolean randomcolor = true; // if true tint it black
int numberOfCircles = 30; // this is the number of circles we will draw
float radius = 22 * width; // the initial radius
float decr = radius / numberOfCircles; // the decrement depends on the radius and the number of circles

int r = int(random(0, 255)); 
int g = int(random(0, 255)); 
int b = int(random(0, 255)); 


void setup() {
  size(960, 540); // canvas size

  noStroke();  // removing stroke from circle 

  for (int i = 0; i < numberOfCircles; i++) {
    if (randomcolor  == true) {
      fill(r , g, b); // random color
    } else {
      fill(b , r , g); // random color 
    }

    ellipse(x, y, radius, radius); // draw the ellipse
    radius = radius - decr; // reduce the radius

    // use modulo to set distance between circles
    if (i%2 == 0) {
      randomcolor = false;
    } else {
      randomcolor = true;
    }
  } 
  noLoop();
}