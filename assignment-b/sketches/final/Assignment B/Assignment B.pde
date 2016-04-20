/*The following code was referenced from Richard Marxer.
 
 Here he teaches you how to create audio-reactive geomerative 
 visuals using the Geomerative Library.
 
 The Author is Andy Best and the link is below.
 
 http://www.ricardmarxer.com/geomerative*/
 

import geomerative.*;
import ddf.minim.*;
import codeanticode.syphon.SyphonServer;

SyphonServer syphon;

Minim mySound; //CREATE A NEW SOUND OBJECT
AudioInput in;

RFont font;
String myText = "F ∆ U X E";
//COULD USE A NOISE FUNCTION HERE FOR WIGGLE.
//float wiggle = 3.7;
boolean stopAnime = false;


void settings() {
size(960, 540, P3D);
PJOGL.profile = 1;
}
//----------------SETUP---------------------------------

void setup() {
  
syphon = new SyphonServer( this, "p5-to-syphon" );
size(960, 540);
background(255);
smooth();
RG.init(this); 
font = new RFont("FreeSans.ttf", 200, CENTER);
  
  mySound = new Minim(this);
  in = mySound.getLineIn(Minim.STEREO,512);
}

//----------------DRAW---------------------------------
void draw() {
  background(0);
  stroke(#3F7C36);
  noFill();
  translate(width/2, height/1.6);
  
  float soundLevel = in.mix.level(); //GET OUR AUDIO IN LEVEL

  RCommand.setSegmentLength(soundLevel*1000);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);

  RGroup myGoup = font.toGroup(myText); 
  RPoint[] myPoints = myGoup.getPoints();

  beginShape(TRIANGLE_STRIP);
  for (int i=0; i<myPoints.length; i++) {

    vertex(myPoints[i].x, myPoints[i].y);
  }
  endShape();
  
  syphon.sendScreen();
}



 

//----------------KEYS---------------------------------
void keyReleased() {
  if (key == 'f') 
    stopAnime = !stopAnime;
  if (stopAnime == true) 
    noLoop(); 
  else loop();
}
//////////////////////////////////////////////