
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


ArrayList rects;
ArrayList hiht;
ArrayList snare;
ArrayList mute;
ButtonRec clear;
ButtonRec pause;
void setup() {
  background(#282a36);
  frameRate(4);
  size(490,220);
  oscP5 = new OscP5(this,4560);
  myRemoteLocation = new NetAddress("127.0.0.1",4560);
  
  rects = new ArrayList();
  hiht = new ArrayList();
  snare = new ArrayList();
  
  mute = new ArrayList();
  //Clear all Button
  clear = new ButtonRec(430, 10, 50, 20);
  //Pause Button
  pause = new ButtonRec(370, 10, 50, 20);
  
  clear.c = #ff5555;
  pause.c = #50fa7b;
  //Initiate all Recs
  int pos = 10;
  for(int i = 0; i < 16; i++) { 
    rects.add(new Rec(pos, 40, 20, 30));
    hiht.add(new Rec(pos, 100, 20, 30));
    snare.add(new Rec(pos, 160, 20, 30));
    pos = pos + 30;
  }
  int linepos = 125;
  for(int i = 0; i < 3; i++){
    strokeWeight(1);
    stroke(#6272a4);
    line(linepos, 40, linepos, 70);
    line(linepos, 100, linepos, 130);
    line(linepos, 160, linepos, 190);
    linepos = linepos + 120;
  }
  int mutepos = 21;
  int val = 1;
  for(int i = 0; i < 3; i++) {
    mute.add(new ButtonRec(50, mutepos, 10, 10, val));
    val++;
    mutepos = mutepos + 60;
  }
}

  int count = 0;

void draw() {
  clear.draw();
  pause.draw();
  text("PAUSE", 377, 24);
  text("CLEAR", 437, 24);
  fill(#6272a4);
  text("JUMBOTUNE2000 by Adrian Somesan", 10, 210); 
  text("BASE", 10, 30); 
  text("HIHAT", 10, 90); 
  text("SNARE", 10, 150); 
  for(int i = 0; i < rects.size(); i++) {
    Rec aRec = (Rec) rects.get(i);
    aRec.draw();
    Rec aHiht = (Rec) hiht.get(i);
    aHiht.draw();
    Rec aSnare = (Rec) snare.get(i);
    aSnare.draw(); 
  }
  for(int i = 0; i < mute.size(); i++) {
    ButtonRec aMute = (ButtonRec) mute.get(i);
    aMute.draw();
  }

  
  //Color next Rec for every iteration
  
  //init previous BaseRec && HihtRec
  Rec prevRec = (Rec) rects.get(1);
  Rec prevHiht = (Rec) hiht.get(1);
  Rec prevSnare = (Rec) snare.get(1);
  if(count != 0) {
    prevRec = (Rec) rects.get(count-1);
    prevHiht = (Rec) hiht.get(count-1);
    prevSnare = (Rec) snare.get(count-1);
  }
  else {
    prevRec = (Rec) rects.get(rects.size()-1);
    prevHiht = (Rec) hiht.get(hiht.size()-1);  
    prevSnare = (Rec) snare.get(snare.size()-1);
  }
  
  //Blink Current Recs and prevRecs
  Rec aRec = (Rec) rects.get(count);
  Rec aHiht = (Rec) hiht.get(count);
  Rec aSnare = (Rec) snare.get(count);
  
  prevRec.time = false;
  prevHiht.time = false;
  prevSnare.time = false;
  
  aRec.time = true;
  aHiht.time = true;
  aSnare.time = true;
  
  prevRec.blink();
  prevHiht.blink();
  prevSnare.blink();
  
  aRec.blink();
  aHiht.blink();
  aSnare.blink();
  
  //Color next HiHt for every iteration
  
  
  
  
  //restart counter after 16 iterations
  count++;
  if(count == 16) count = 0;
  
  //give Base value for every iteration
  OscMessage baseMessage = new OscMessage("/sec");
  if(aRec.b && aRec.mute != true) baseMessage.add(1);
  else baseMessage.add(0);
  //give Hiht value for every iteration
  if(aHiht.b && aHiht.mute != true) baseMessage.add(1);
  else baseMessage.add(0);
  
  //give Snare value for every iteration
  if(aSnare.b && aSnare.mute != true) baseMessage.add(1);
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
    //check if snareRec was clicked
    Rec aSnare = (Rec) snare.get(i);
    aSnare.clickCheck(mouseX, mouseY);
    

}
    //clear button
    clear.clickCheck(mouseX, mouseY);
    
    //pause button
    pause.pauseCheck(mouseX, mouseY);
    
    for(int i = 0; i < 3; i++) {
      ButtonRec aMute = (ButtonRec) mute.get(i);
      aMute.muteCheck(mouseX, mouseY);
    }

}

//SecClass
class Rec {
  int x,y,w,h;
  color c;
  boolean b;
  boolean time;
  boolean mute;
  Rec(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = #50fa7b;
    b = false;
    time = false;
    mute = false;
  }
  void draw(){
    noStroke();
    fill(c);
    rect(x,y,w,h);
    fill(#ffffff);
  }
  
  void blink() {
    if(time == false && b == false) c = #50fa7b;
    else if(time && b) c = #8be9fd;
    else if(time) c = #bd93f9;
    else if(time == false && b) c = #EF6461;
  }
  
  void clickCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      if(b){
        b = false;
        c = #50fa7b;
      } else {
        b = true;
        c = #ff5555;
      }
    }
  }
}

//Button Class
class ButtonRec {
  int x,y,w,h;
  color c;
  boolean check;
  int val;
  ButtonRec(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = #50fa7b;
    check = false;
    val = 0;
  }
  
  ButtonRec(int _x, int _y, int _w, int _h, int v){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = #ffb86c;
    check = false;
    val = v;
  }
  void draw(){
    noStroke();
    fill(c);
    rect(x,y,w,h);
    fill(#ffffff);
  }
    
  void clickCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      for(int i = 0; i < 16; i++) {
        Rec aRec = (Rec) rects.get(i);
        Rec aHiht = (Rec) hiht.get(i);
        Rec aSnare = (Rec) snare.get(i);
        aRec.b = false;
        aHiht.b = false;
        aSnare.b = false;
        aRec.blink();
        aHiht.blink();
        aSnare.blink();
      }
    }
  }
  
  void pauseCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      if(check) {
        check = false;
        c = #50fa7b;
        pause.draw();
        loop();
      } else {
        c = #ff5555;
        text("PAUSE", 377, 24);
        pause.draw();
        text("PAUSE", 377, 24);
        check = true;
        noLoop();
        OscMessage baseMessage = new OscMessage("/sec");
        baseMessage.add(0);
        baseMessage.add(0);
        baseMessage.add(0);
        oscP5.send(baseMessage, myRemoteLocation);
      }
     
    }
  }
  
  void muteCheck( int _x, int _y ) {
   if( _x > x && _y > y && _x < x+w && _y < y+h ){
     
     if(check == false){
       
       if(val == 3) {
         check = true;
        
         for(int i = 0; i < snare.size(); i++){
           Rec aSnare = (Rec) snare.get(i);
           aSnare.mute = true;
         }
         c = #ff5555;
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();         
       }
       
       else if(val == 2) {
         check = true;
        
         for(int i = 0; i < hiht.size(); i++){
           Rec aHiht = (Rec) hiht.get(i);
           aHiht.mute = true;
         }
         c = #ff5555;
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();         
       }
     
       
       else if(val == 1) {
         check = true;
        
         for(int i = 0; i < rects.size(); i++){
           Rec aRec = (Rec) rects.get(i);
           aRec.mute = true;
         }
         c = #ff5555;
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();         
       }
     }
     
     else if(check) {
       
       if(val == 3) {
         check = false;
         c = #ffb86c;
         
         for(int i = 0; i < snare.size(); i++){
           Rec aSnare = (Rec) snare.get(i);
           aSnare.mute = false;
         }
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();
         redraw();
       }
     
       else if(val == 2) {
         check = false;
         c = #ffb86c;
         
         for(int i = 0; i < hiht.size(); i++){
           Rec aHiht = (Rec) hiht.get(i);
           aHiht.mute = false;
         }
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();
         redraw();
       }
       
     else if(val == 1) {
         check = false;
         c = #ffb86c;
         
         for(int i = 0; i < rects.size(); i++){
           Rec aRec = (Rec) rects.get(i);
           aRec.mute = false;
         }
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();
         redraw();
       }
       
     }
   }
  }
}
