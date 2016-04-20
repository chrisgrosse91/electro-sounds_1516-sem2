/*The following code was referenced from Andy Best.

Here he teaches you how to create audio-reactive visuals using FFT.

The Author is Andy Best and the link is below.

http://andybest.net/2010/01/5-processing-video-tutorials*/


import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
FFT fft;

int w;
PImage fade;
int hVal;

float rWidth, rHeight;


void setup () {
  /* size should be 1280x720 */
  size(1280, 720, P3D);
  
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(100, 7);
  
  
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
}


 
 