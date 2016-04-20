/*The following code was referenced from Andy Best and Farid.
 
 Here he teaches you how to create audio-reactive visuals using FFT.
 
 The Author is Andy Best and the link is below.
 
 http://andybest.net/2010/01/5-processing-video-tutorials*/


import ddf.minim.analysis.*;
import ddf.minim.*;
import codeanticode.syphon.SyphonServer;

SyphonServer syphon;

Minim minim;
AudioInput in;
FFT fft;


int CIRCLEEXPANDER = 1;
int FLYINGLINES = 2;
int FLYINGLINES2 = 4;
int CIRCLEEXPANDER2 = 8;
int SQUAREWEB = 16;
int SQUAREWEBROTATE = 32;

int mode = 0;
int w;
PGraphics fade;
int hVal;

float rWidth, rHeight;

ArrayList <circleExpander> cirEx = new ArrayList();
ArrayList <flyLines> flyL = new ArrayList();
ArrayList <circleExpander2> cirEx2 = new ArrayList();
ArrayList <flyLines2> flyL2 = new ArrayList();
ArrayList <squareWeb> sqWeb = new ArrayList();
ArrayList <squareWebRotate> sqWebRotate = new ArrayList();



void settings() {
  size(1280, 720, P3D);
  PJOGL.profile = 1;
}


void setup () {
  /* size should be 1280x720 */
  syphon = new SyphonServer( this, "p5-to-syphon" );

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(100, 7);

  cirEx.add(new circleExpander());
  for (int i=0; i<1000; i ++) {
    flyL.add(new flyLines());
  }
  cirEx2.add(new circleExpander2());
  for (int i=0; i<2000; i ++) {
    flyL2.add(new flyLines2());
  }
  sqWeb.add(new squareWeb());
  sqWebRotate.add(new squareWebRotate());
  smooth();

  fade = createGraphics(width, height, P2D);
  fade.beginDraw();
  fade.background(0);
  fade.endDraw();

  w= width/fft.avgSize(); // ?


  background (0);

  stroke(200);
  strokeWeight(w);
  strokeCap(SQUARE);
  colorMode(HSB);

  rWidth = width * 0.99;
  rHeight = height * 0.99;
  hVal = 0;
}


void draw() {


  /* do some calculations here */

  fft.forward(in.mix);


  /* now draw */
  // background (0);

  // ?
  // image(fade, 0, 0);
  fade.beginDraw();
  fade.colorMode(HSB);
  fade.fill(hVal, 255, 255);
  fade.colorMode(RGB);
  fade.noStroke();
  int s = fft.avgSize();
  int step = width/s;
  for (int i = 0; i < s; i++) {
    fade.rect(20 + i*step, height, step, -fft.getAvg(i) * 4);
  }
  fade.fill(0);
  fade.rect(0,height-2,width,2);
  fade.tint(255, 255, 255, 254);
  fade.copy(0, 0, width, height, 1, 0, width-2, height-1);
  fade.noTint();
  // just in case, fade to black, change value of intensity
  int intensity = 1;
  fade.pushMatrix();
  fade.fill(0, intensity);
  fade.rect(0, 0, width,height);
  fade.popMatrix();
  fade.endDraw();

  image(fade, 0, 0);
  // fade = get(0, 0, width, height);


  colorMode(HSB);
  stroke(hVal, 255, 255);
  colorMode(RGB);
  
  hVal += 2;
  if (hVal > 255)
  {
    hVal = 0;
  }


  if (isModeActive(CIRCLEEXPANDER)) {
    for (circleExpander b : cirEx) {
      b.display();
    }
  }

  if (isModeActive(FLYINGLINES)) {

    for (flyLines c : flyL) {
      c.display();
    }
  }

  if (isModeActive(FLYINGLINES2)) {

    for (flyLines2 c : flyL2) {
      c.display();
    }
  }

  if (isModeActive(CIRCLEEXPANDER2)) {

    for (circleExpander2 e : cirEx2) {
      e.display();
    }
  }

  if (isModeActive(SQUAREWEB)) {

    for (squareWeb f : sqWeb) {
      f.display();
    }
  }

  if (isModeActive(SQUAREWEBROTATE)) {
    for (squareWebRotate sq : sqWebRotate) {
    sq.display();
    }
  }

  syphon.sendScreen();
}




boolean isModeActive(int theMode) {
  return (mode & theMode)>0;
}

void keyPressed() {
  switch(key) {
    case('1'): 
    mode ^= 1;
    break; 
    case('2'): 
    mode ^= 2;
    break;
    case('3'): 
    mode ^= 4;
    break;
    case('4'): 
    mode ^= 8;
    break;
    case('5'): 
    mode ^= 16;
    break;
    case('6'): 
    mode ^= 32;
    break;
  }
}