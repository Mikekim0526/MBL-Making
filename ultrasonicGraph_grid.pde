import processing.serial.*;


int xPos = 1;         // horizontal position of the graph
int lf = 10;
String myString = null;
int distance;
float preVal;
Serial port;

void setup () {
  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(this, "COM21", 9600);
  port.clear();

  myString = port.readStringUntil(lf); 
  myString = null;
  
  size(800, 600);
  background(0);
  
    for(int i=0; i<8; i++){
    strokeWeight(1/10);
    stroke(255);
    line(0, i*(height/8), width, i*(height/8));
  }
  for(int j=0; j<20; j++){
    strokeWeight(1/10);
    stroke(255);
    line(j*(width/20), 0, j*(width/20), height);
  }
}

void draw () {
  float val= map(distance, 0,8000,height,0);
  strokeWeight(5);
  stroke(127, 34, 255);
  //point(xPos, mouseY);
  point(xPos, val);
  //line(xPos, val, xPos, preVal);

  if (xPos >= width) {
    xPos = 0;
    background(0);
      for(int i=0; i<8; i++){
    strokeWeight(1/10);
    stroke(255);
    line(0, i*(height/8), width, i*(height/8));
  }
  for(int j=0; j<20; j++){
    strokeWeight(1/10);
    stroke(255);
    line(j*(width/20), 0, j*(width/20), height);
  }
  } else {
    xPos++;
  }
  
  preVal = val;
  delay(100);
}

void serialEvent(Serial port) { 
    myString = port.readStringUntil(lf);
    
    if (myString != null) { 
      try { 
        distance=Integer.parseInt(myString.trim()); 
      } 
      catch (NumberFormatException npe) { 
      }
    }
}
