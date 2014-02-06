import processing.video.*;

int sX = displayWidth;
int sY = displayHeight;
int fRate = 20;

Capture camera = null;
String[] cameras = null;
boolean recording = false;

ArrayList<PImage> frames = null;
int currentFrame = 0;

void setup() {
  size(sX, sY);
  frameRate(fRate);  
  cameras = Capture.list();  
  printAvailableCameras();
}

void printAvailableCameras() {
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(i + ": " + cameras[i]);
    }
  }
}

void setCamera(int n) {
  printAvailableCameras();
  if (n >= 0 && n < cameras.length) {
    if (camera != null) {
      camera.stop();
    }
    println("Starting camera no. " + n);    
    camera = new Capture(this, cameras[n]);
    camera.start();
  }
}

void startRec() {
  if (!recording && camera != null) {
    recording = true;   
    frames = new ArrayList<PImage>(15 * fRate);  
    println("Recording started");
  }
}

void stopRec() {
  if (recording) {
    recording = false;
    currentFrame = 0;
    println("Recording stopped");
  }
}

void recordFrame() {
  if (!camera.available()) {
    //println("Frame not available!");
    if (frames != null && !frames.isEmpty()) {
      PImage lastFrame = frames.get(frames.size() - 1);
      frames.add(lastFrame);
    }
  } 
  else {  
    camera.read();
    image(camera, 0, 0, sX, sY);
    PImage img = createImage(camera.width, camera.height, RGB);
    img.loadPixels();
    for (int i = 0; i < camera.pixels.length; i++) {
      img.pixels[i] = camera.pixels[i];
    }
    img.updatePixels();   
    frames.add(img);
  }
}

void playFrame() {
  if (frames != null && !frames.isEmpty()) {    
    println("Frames: ["+frames.size()+"] currentFrame: ["+currentFrame+"] hc: ["+frames.get(currentFrame)+"]");
    image(frames.get(currentFrame), 0, 0, sX, sY);
    currentFrame = (currentFrame + 1) % frames.size();
  } 
  else if (camera != null && camera.available()) {
    camera.read();
    image(camera, 0, 0, sX, sY);
  }
}

void keyPressed() {
  println("Key pressed: ["+key+"]");
  switch(key) {
  case ' ': 
    startRec(); 
    break;
  }
}

void keyReleased() {
  println("Key released: ["+key+"]");
  switch(key) {
  case ' ': 
    stopRec(); 
    break;
  case '0': 
    setCamera(0); 
    break;
  case '1': 
    setCamera(1); 
    break;
  case '2': 
    setCamera(2); 
    break;
  case '3': 
    setCamera(3); 
    break;
  case '4': 
    setCamera(4); 
    break;
  case '5': 
    setCamera(5); 
    break;
  case '6': 
    setCamera(6); 
    break;
  case '7': 
    setCamera(7); 
    break;
  case '8': 
    setCamera(8); 
    break;
  case '9': 
    setCamera(9); 
    break;
  }
}

void draw() {  
  if (recording) {
    recordFrame();
  } 
  else {
    playFrame();
  }
}

