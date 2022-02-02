
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


ArrayList rects;
ArrayList hiht;
void setup() {
  background(#373F47);
  frameRate(4);
  size(490,200);
  oscP5 = new OscP5(this,4560);
  myRemoteLocation = new NetAddress("127.0.0.1",4560);
  
  rects = new ArrayList();
  hiht = new ArrayList();
  int pos = 10;
  for(int i = 0; i < 16; i++) { 
    hiht.add(new Rec(pos, 80, 20, 30));
    rects.add(new Rec(pos, 40, 20, 30));
    pos = pos + 30;
    
  }
}

  int count = 0;

void draw() {
  text("Sequencer", 10, 20);
  
  for(int i = 0; i < rects.size(); i++) {
    Rec aRec = (Rec) rects.get(i);
    aRec.draw();
    Rec aHiht = (Rec) hiht.get(i);
    aHiht.draw();
    
  }
  
  //Color next Rec for every iteration
  
  //init previous BaseRec && HihtRec
  Rec prevRec = (Rec) rects.get(1);
  Rec prevHiht = (Rec) hiht.get(1);
  if(count != 0) {
    prevRec = (Rec) rects.get(count-1);
    prevHiht = (Rec) hiht.get(count-1);
  }
  else {
    prevRec = (Rec) rects.get(rects.size()-1);
    prevHiht = (Rec) hiht.get(hiht.size()-1);  
  }
  
  //Blink Current Recs and prevRecs
  Rec aRec = (Rec) rects.get(count);
  Rec aHiht = (Rec) hiht.get(count);
  
  prevRec.time = false;
  prevHiht.time = false;
  
  aRec.time = true;
  aHiht.time = true;
  
  prevRec.blink();
  prevHiht.blink();
  
  aRec.blink();
  aHiht.blink();
  
  //Color next HiHt for every iteration
  
  
  
  
  //restart counter after 16 iterations
  count++;
  if(count == 16) count = 0;
  
  //give Base value for every iteration
  OscMessage baseMessage = new OscMessage("/sec");
  if(aRec.b) baseMessage.add(1);
  else baseMessage.add(0);
  
  if(aHiht.b) baseMessage.add(1);
  else baseMessage.add(0);
  oscP5.send(baseMessage, myRemoteLocation);
  
  //give Hiht value for every iteration
  
}

void mouseClicked(){
    for (int i = 0; i < rects.size(); i++) {
    //check if BaseRec was clicked
    Rec aRec = (Rec) rects.get(i);
    aRec.clickCheck(mouseX, mouseY);
    //check if hihtRec was clicked
    Rec aHiht = (Rec) hiht.get(i);
    aHiht.clickCheck(mouseX, mouseY);
}

}

//ButtonClass
class Rec {
  int x,y,w,h;
  color c;
  boolean b;
  boolean time;
  Rec(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = #6C91C2;
    b = false;
    time = false;
  }
  void draw(){
    noStroke();
    fill(c);
    rect(x,y,w,h);
    fill(#ffffff);
  }
  
  void blink() {
    if(time == false && b == false) c = #6C91C2;
    else if(time && b) c = #E4B363;
    else if(time) c = #47A025;
    else if(time == false && b) c = #EF6461;
  }
  
  void clickCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      if(b){
        b = false;
        c = #6C91C2;
      } else {
        b = true;
        c = #EF6461;
      }
    }
  }
}
