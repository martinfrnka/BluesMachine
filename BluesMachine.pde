
/**
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


int cellWidth = 43;
int cellHeight = 30;
int numTones = 7;
int numCells = 24;

int oldX = -1;
int oldY = -1;
int xIdx, yIdx;

int w = cellWidth * numCells;
int h = cellHeight * numCells;

int[] dorD = {50, 52, 53, 55, 57, 59, 60};
int[] dorG = {55, 57, 58, 60, 62, 64, 65};
int[][] dor = {
  {50, 52, 53, 55, 57, 59, 60},
  {48, 50, 52, 53, 55, 57, 59}
};

int scale = 0;
int speed = 200;
int lastTime = 0;

void setup() {
  size(w, h);
  frameRate(60);
  cursor(CROSS);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",11000);
}

void sendMsg(int noteX, int noteY, float gain)
{
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/foo/notes");

  myMessage.add(noteX); 
  myMessage.add(noteY); 
  myMessage.add(gain); 

  // send the message 
  oscP5.send(myMessage, myRemoteLocation); 
  //print("### sended an osc message.");
  //print(" addrpattern: "+myMessage.addrPattern());
  //println(" typetag: "+myMessage.typetag());
}

int count =0;
void draw() {
  if (mousePressed && (mouseButton == LEFT)) {
    scale = 0;
  }
  if (mousePressed && (mouseButton == RIGHT)) {
    scale = 1;
  }
  count++;
  background(0); 
  stroke(255);
  
  //vert lines
  for (int i = 0; i<=width;i+=cellWidth)
  {
    line(i,0,i,height);
  }
  
  //horizontal lines
  for (int i = 0; i<=height;i+=cellHeight)
  {
    line(0,i,width,i);
  }
  fill(120,0,0);
  rect((mouseX/cellWidth)*cellWidth,(mouseY/cellHeight)*cellHeight,cellWidth, cellHeight);
  fill(255,255,255,120);
  rect(xIdx*cellWidth,yIdx*cellHeight,cellWidth, cellHeight);
  int now = millis();
  if ((now-lastTime)>=speed)
  {
    mousing();
    lastTime = now; 
  }
}

void mousing() {
  oldX = xIdx;  
  oldY = yIdx;

  xIdx = mouseX/cellWidth;
  yIdx = mouseY/cellHeight;
  
  int noteX = ((xIdx / numTones) * 12) + dor[scale][(xIdx % numTones)]; 
  int noteY = ((yIdx / numTones) * 12) + dor[scale][(yIdx % numTones)] +12; 
   
  sendMsg(noteX, noteY, random(0.1,0.5));


}


/* incoming osc message are forwarded to the oscEvent method. */
/*
void oscEvent(OscMessage theOscMessage) {
  // print the address pattern and the typetag of the received OscMessage
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
*/

void mouseWheel(MouseEvent event) {
 speed += 20*(int)event.getAmount();
 if (speed<20) {
   speed = 20;
 }
 if (speed>800) {
   speed = 800;
 }
}
