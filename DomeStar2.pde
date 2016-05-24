Routine leftRoutine;
Routine rightRoutine;
PGraphics mix;
MapEntry[] map;
Transmitter transmitter;
float fader = 127;

int xofs,yofs;
float xfade;

RoutineFactory[] routines = new RoutineFactory[] {
  new PerlinFactory(),
  new RectFactory()
};

public void setup() {
  size(1024, 1024, P3D);
  frameRate(60);
  noSmooth();
  //colorMode(HSB);

  leftRoutine = pickRoutine();
  rightRoutine = pickRoutine();
  
  mix = createGraphics(360, 360, P3D);
  
  Mapper mapper = new Mapper();
  map = mapper.build();
  
  transmitter = new Transmitter(this);
}

// Scroll wheel sets cross fader.  TODO make WiiMote and auto.
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  fader = max(0, min(255, fader + e));
}

// TODO: Use WiiMote
void mousePressed() {
  // Update the routine faded away, or
  // randomly update one of either the left or right.
  if (fader < 50) {
    leftRoutine = pickRoutine();
  } else if (fader > 200) {
    rightRoutine = pickRoutine();
  } else if (random(2) > 1.0) {
    leftRoutine = pickRoutine();
  } else {
    rightRoutine = pickRoutine();
  }
}

Routine pickRoutine() {
  int idx = int(random(routines.length));
  RoutineFactory factory = routines[idx];

  Routine instance = factory.create();
  instance.beginDraw();
  instance.setup();
  instance.endDraw();
  return instance;
}

public void draw() {
  background(100);
  
  // Draw the left routine
  leftRoutine.beginDraw();
  leftRoutine.draw();
  leftRoutine.endDraw();
  
  // Draw the right routine
  rightRoutine.beginDraw();
  rightRoutine.draw();
  rightRoutine.endDraw();

  // Figure out center offsets
  xofs = (mouseX - width/2) / (width / 90);
  yofs = (mouseY - height/2) / (height / 90);
  
  // Blit the left and right routines to screen with offsets
  leftRoutine.imageCenter(width/4+xofs, height/4+yofs);
  rightRoutine.imageCenter(3*width/4-xofs, height/4-yofs);
  
  // Draw the clipping box
  noFill();
  stroke(100, 255, 255);
  strokeWeight(1);
  rect(width/4-180-1, height/4-180-1, 362, 362);
  rect(3*width/4-180-1, height/4-180-1, 362, 362);

  // Blit the left and right to the mix with tint and fade
  mix.beginDraw();
  mix.tint(255, fader);
  leftRoutine.imageCenter(mix, 180+xofs, 180+yofs);
  mix.tint(255, 255-fader);
  rightRoutine.imageCenter(mix, 180-xofs, 180-yofs);
  mix.endDraw();  
  image(mix, width/2-180, 3*height/4-180);
 
  // Draw the fader bar
  stroke(0);
  line(width/2-255,height/2+25,width/2+255,height/2+25);
  stroke(0, 0, 255);
  strokeWeight(10);
  xfade = width/2 - (fader-127)*2;
  line(xfade, height/2, xfade, height/2 + 50);
  
  // Send the mix to the dome
  transmitter.sendData(mix, map); 
}