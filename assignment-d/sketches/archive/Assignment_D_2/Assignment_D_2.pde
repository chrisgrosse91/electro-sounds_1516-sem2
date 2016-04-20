/*The following code was referenced from Andy Best.

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
PImage fade;
int hVal;

float rWidth, rHeight;

ArrayList <circleExpander> cirEx = new ArrayList();
ArrayList <flyLines> flyL = new ArrayList();
ArrayList <circleExpander2> cirEx2 = new ArrayList();
ArrayList <flyLines2> flyL2 = new ArrayList();
ArrayList <squareWeb> sqWeb = new ArrayList();
ArrayList <squareWebRotate> sqWebRotate = new ArrayList();





void setup () {
  /* size should be 1280x720 */
  size(1280, 720, P3D);
  
  syphon = new SyphonServer( this, "p5-to-syphon" );
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(100, 7);
 
  cirEx.add(new circleExpander());
  for (int i=0; i<200; i ++) {
    flyL.add(new flyLines());
  }
  cirEx2.add(new circleExpander2());
  for (int i=0; i<200; i ++) {
    flyL2.add(new flyLines2());
  }
  sqWeb.add(new squareWeb());
  sqWebRotate.add(new squareWebRotate());
  smooth();
  
  
  w= width/fft.avgSize(); // ?
  
  stroke(200);
  strokeWeight(w);
  strokeCap(SQUARE);
  colorMode(HSB);
  
  background (255);
  fade = get(0, 0, width, height);

  rWidth = width * 0.99;
  rHeight = height * 0.99;
  hVal = 0;
  
  
}

void draw() {
  
  
  /* do some calculations here */
  
  
  /* now draw */
  background (0);
  
  // ?
  tint(255, 255, 255, 254);
  image(fade, (width - rWidth)/2, 0, rWidth, rHeight);
  noTint();
  
  fft.forward(in.mix);
  
  // ?
  colorMode(HSB);
  stroke(hVal, 255, 255);
  colorMode(RGB);
  
  for(int i = 0; i < fft.avgSize(); i++)
  {
    line((i * w) + (w / 2), height, (i * w) + (w / 2), height - fft.getAvg(i) * 4);
    
  }
   
    fade = get(0, 0, width, height);
    
    hVal += 2;
    if(hVal > 255)
    {
      hVal = 0;
    }
    
  pushMatrix();
  translate(1280, 720);
  fill(0, 10);
  rect(0, 0, 1280, 720);
  popMatrix();

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

    for (squareWebRotate g : sqWebRotate) {
      g.display();
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

 
 