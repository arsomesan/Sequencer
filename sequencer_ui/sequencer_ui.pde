
import oscP5.*;
import netP5.*;
import controlP5.*;
import javax.swing.ImageIcon;

OscP5 oscP5;
ControlP5 cp5;

NetAddress myRemoteLocation;


float bps;
float bpmm = (1/(120/60))*1000;
float timer = 0;
String pValue = "PAUSE";

//initialite Controllers
float volumeValue;

Knob baseRateKnob;
float baseRateValue;

Knob hihtRateKnob;
float hihtRateValue;

Knob snareRateKnob;
float snareRateValue;

Knob percRateKnob;
float percRateValue;

Knob baseAttackKnob;
float baseAttackValue;

Knob hihtAttackKnob;
float hihtAttackValue;

Knob snareAttackKnob;
float snareAttackValue;

Knob percAttackKnob;
float percAttackValue;

Knob mldyAttackKnob;
float mldyAttackValue;

Knob baseReleaseKnob;
float baseReleaseValue;

Knob hihtReleaseKnob;
float hihtReleaseValue;

Knob snareReleaseKnob;
float snareReleaseValue;

Knob percReleaseKnob;
float percReleaseValue;

Knob mldyReleaseKnob;
float mldyReleaseValue;

Slider bpm;
int sliderTicks1 = 120;

Textlabel bpmLabel;

RadioButton slicerWave;
int slicerWaveValue;

Toggle slicerToogle;

int slicerBool;

int[] m = new int[16];

//initialize all ButtonLists
ArrayList rects;
ArrayList hiht;
ArrayList snare;
ArrayList mute;
ArrayList perc;
ArrayList mldy;

//initialize single Buttons
ButtonRec clear;
ButtonRec pause;
AmpControl up;
AmpControl down;
Amp amp;

PImage icon;
float fps;

PFont roboto;


void setup() {
  //Font
  roboto = loadFont("RobotoCondensed-Regular-48.vlw");
  textFont(roboto);
  ControlFont font = new ControlFont(roboto, 15);
  
  //Programm Icon
  icon = loadImage("loop.png");
  ImageIcon barIcon = new ImageIcon(loadBytes("loop.png"));
  frame.setIconImage(barIcon.getImage());
  frame.setTitle("JUMBOTUNE");
  //surface.setIcon(icon);
  //surface.setTitle("JUMBOTUNE");
  
  background(#282a36);
  size(1300,900);
  frameRate(60);
  
  cp5 = new ControlP5(this);
  
  //cp5.setControlFont(font);
  
  //Rate Knobs       
  baseRateKnob = cp5.addKnob("BRate")
                 .setRange(0.1,10)
                 .setValue(1)
                 .setPosition(width - 120, 75)
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 .setHeight(30)
                 .setSize(60,60)
                 .setColorForeground(#8be9fd)
                 .setColorBackground(#282a36)
                 .setColorActive(#50fa7b)
                 ;
                 
  hihtRateKnob = cp5.addKnob("HRate")
               .setRange(0.1,10)
               .setValue(1)
               .setPosition(width - 120, 195)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;

  snareRateKnob = cp5.addKnob("SRate")
               .setRange(0.1,10)
               .setValue(1)
               .setPosition(width - 120, 315)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;     
     
  percRateKnob = cp5.addKnob("PRate")
               .setRange(0.1,10)
               .setValue(1)
               .setPosition(width - 120, 435)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;   
  
  //Attack Knobs  
           
  baseAttackKnob = cp5.addKnob("BAttk")
                 .setRange(0,1)
                 .setValue(0)
                 .setPosition(width - 200, 75)
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 .setHeight(30)
                 .setSize(60,60)
                 .setColorForeground(#8be9fd)
                 .setColorBackground(#282a36)
                 .setColorActive(#50fa7b)
                 ;
                 
  hihtAttackKnob = cp5.addKnob("HAttk")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 200, 195)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;

  snareAttackKnob = cp5.addKnob("SAttk")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 200, 315)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;     
     
  percAttackKnob = cp5.addKnob("PAttk")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 200, 435)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;   
  mldyAttackKnob = cp5.addKnob("MAttk")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 200, 650)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;               
     
     
  //Release Knobs  
           
  baseReleaseKnob = cp5.addKnob("BRel")
                 .setRange(0,1)
                 .setValue(0)
                 .setPosition(width - 280, 75)
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 .setHeight(30)
                 .setSize(60,60)
                 .setColorForeground(#8be9fd)
                 .setColorBackground(#282a36)
                 .setColorActive(#50fa7b)
                 ;
                 
  hihtReleaseKnob = cp5.addKnob("HRel")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 280, 195)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;

  snareReleaseKnob = cp5.addKnob("SRel")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 280, 315)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;     
     
  percReleaseKnob = cp5.addKnob("PRel")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 280, 435)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;  
               
  mldyReleaseKnob = cp5.addKnob("MRel")
               .setRange(0,1)
               .setValue(0)
               .setPosition(width - 280, 650)
               .setRadius(10)
               .setDragDirection(Knob.VERTICAL)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;                 

  //Slider
  cp5.addSlider("BPM")
     .setPosition(30, height - 60)
     .setSize(250,40)
     .setRange(12,50)
     .setValue(24)
     .setDecimalPrecision(0)
     .setNumberOfTickMarks(39)
     .snapToTickMarks(true)
     .setLabelVisible(false)
     .setColorForeground(#bd93f9)
     .setColorBackground(#282a36)
     .setColorActive(#50fa7b)
     ;
   
     cp5.addSlider("Volume")
     .setPosition(width-130,height-60)
     .setSize(100,40)
     .setRange(0,1)
     .setValue(0.5)
     .snapToTickMarks(true)
     .setLabelVisible(false)
     .setNumberOfTickMarks(21)
     .setDecimalPrecision(1)
     .setColorForeground(#bd93f9)
     .setColorBackground(#282a36)
     .setColorActive(#50fa7b)
     ;    
     
     //MelodyKnobs
     int knobcount = 30;
     for(int i = 0; i < 16; i++){
       cp5.addKnob("M" + i)
          .setRange(0,127)
          .setValue(0)
          .setSize(40,50)
          .setPosition(knobcount, 560)
          .setDecimalPrecision(1)
          .setColorForeground(#50fa7b)
          .setColorBackground(#282a36)
          .setColorActive(#8be9fd)
          ;
          knobcount = knobcount + 60;
     }
    
    //SlicerWave
    slicerWave = cp5.addRadioButton("Wave")
              .setPosition(1025,620)
              .setSize(20,20)
              .setColorForeground(#50fa7b)
              .setColorBackground(#44475a)
              .setColorActive(#8be9fd)
              .setItemsPerRow(4)
              .setSpacingColumn(35)
              .addItem("Saw",0)
              .addItem("Pul",1)
              .addItem("Tri",2)
              .addItem("Sin",3)
              ;
    slicerToogle = cp5.addToggle("Slicer")
       .setPosition(width-115,680)
       .setSize(50,20)
       .setColorForeground(#50fa7b)
       .setColorBackground(#44475a)
       .setColorActive(#8be9fd)
       .setMode(ControlP5.SWITCH)
       .setValue(false)
       ;
  
  //OSC initialize
  oscP5 = new OscP5(this,4560);
  myRemoteLocation = new NetAddress("127.0.0.1",4560);
  
  //initialize all ButtonLists
  rects = new ArrayList();
  hiht = new ArrayList();
  snare = new ArrayList();
  perc = new ArrayList();
  mute = new ArrayList();
  mldy = new ArrayList();
  
  //Clear all Button
  clear = new ButtonRec(width - 250, height - 60, 100, 40);
  //Pause Button
  pause = new ButtonRec(width - 370, height - 60, 100, 40);
  
  clear.c = #ff5555;
  pause.c = #ffb86c;
  
  //Add all Recs to RecLists
  int pos = 30;
  for(int i = 0; i < 16; i++) { 
    rects.add(new Rec(pos, 80, 40, 60));
    hiht.add(new Rec(pos, 200, 40, 60));
    snare.add(new Rec(pos, 320, 40, 60));
    perc.add(new Rec(pos, 440, 40, 60));
    mldy.add(new Rec(pos, 650, 40, 60));
    pos = pos + 60;
  }
  //Initialize and draw Lines
  int linepos = 260;
  for(int i = 0; i < 3; i++){
    strokeWeight(1);
    stroke(#6272a4);
    line(linepos, 80, linepos, 140);
    line(linepos, 200, linepos, 260);
    line(linepos, 320, linepos, 380);
    line(linepos, 440, linepos, 500);
    line(linepos, 650, linepos, 710);
    linepos = linepos + 240;
  }
  //Add all Mutebuttons to MuteList
  int mutepos = 52;
  int val = 1;
  for(int i = 0; i < 5; i++) {
    mute.add(new ButtonRec(30, mutepos, 40, 20, val));
    val++;
    mutepos = mutepos + 120;
  }
  
}

  int count = 0;
  int fontcount = 0;
  
  
  
  
void draw() {
  
  //Draw Icon
  icon.resize(60, 60);
  image(icon, (width/2) - 20, height - 85);
  textSize(13);
  fill(#6272a4);
  text("JUMBOTUNE by Adrian Somesan", (width/2) -80, height - 15); 
  //Draw Single BUttons
  clear.draw();
  pause.draw();
  
  //Draw Texts
  textSize(24);
  fill(#282a36);
  rect(30,height- 110, 200, 40 );
  rect(width - 120,height- 110, 200, 40 );
  fill(#ffffff);
  String realbpm = String.format("%.0f",(fps*60)/2);
  String realvol = String.format("%.0f",volumeValue * 100);
  text("BPM: " + realbpm, 30, height - 80);
  text("VOL: " + realvol + "%", width - 130, height - 80);
  fill(#ffffff);
  text(pValue, width - 360, height - 31);
  text("CLEAR", width - 240, height - 31);
  if(fontcount == 0) {
    fill(#6272a4);
    text("BASE", 90, 70); 
    text("HIHAT", 90, 190); 
    text("SNARE", 90, 310); 
    text("PERCS", 90, 430);
    text("MELODY", 90, 550);
    text("SLICER CONTROL", width - 275, 585);

  }
  
  fontcount++;
  //Draw all PlayRecs
  for(int i = 0; i < rects.size(); i++) {
    Rec aRec = (Rec) rects.get(i);
    aRec.draw();
    Rec aHiht = (Rec) hiht.get(i);
    aHiht.draw();
    Rec aSnare = (Rec) snare.get(i);
    aSnare.draw(); 
    Rec aPerc = (Rec) perc.get(i);
    aPerc.draw();
    Rec aMldy = (Rec) mldy.get(i);
    aMldy.draw();
  }
  //Draw all MuteButtons
  for(int i = 0; i < mute.size(); i++) {
    ButtonRec aMute = (ButtonRec) mute.get(i);
    aMute.draw();
  }
  
  

  if(millis() > timer) {
    print(millis() + "\n");
    print(timer + "\n");
    print(bpmm);
      //init previous PlayRecs
      Rec prevRec = (Rec) rects.get(1);
      Rec prevHiht = (Rec) hiht.get(1);
      Rec prevSnare = (Rec) snare.get(1);
      Rec prevPerc = (Rec) perc.get(1);
      Rec prevMldy = (Rec) mldy.get(1);
      if(count != 0) {
        prevRec = (Rec) rects.get(count-1);
        prevHiht = (Rec) hiht.get(count-1);
        prevSnare = (Rec) snare.get(count-1);
        prevPerc = (Rec) perc.get(count-1);
        prevMldy = (Rec) mldy.get(count-1);
      }
      else {
        prevRec = (Rec) rects.get(rects.size()-1);
        prevHiht = (Rec) hiht.get(hiht.size()-1);  
        prevSnare = (Rec) snare.get(snare.size()-1);
        prevPerc = (Rec) perc.get(perc.size()-1);
        prevMldy = (Rec) mldy.get(mldy.size()-1);
      }
      
      //Blink previous Recs for every Iteration
      prevRec.time = false;
      prevHiht.time = false;
      prevSnare.time = false;
      prevPerc.time = false;
      prevMldy.time = false;
      
      prevRec.blink();
      prevHiht.blink();
      prevSnare.blink();
      prevPerc.blink();
      prevMldy.blink();
      
      
      //Blink Current Recs for every iteration
      Rec aRec = (Rec) rects.get(count);
      Rec aHiht = (Rec) hiht.get(count);
      Rec aSnare = (Rec) snare.get(count);
      Rec aPerc = (Rec) perc.get(count);
      Rec aMldy = (Rec) mldy.get(count);
      
      aRec.time = true;
      aHiht.time = true;
      aSnare.time = true;
      aPerc.time = true;
      aMldy.time = true;
      
      aRec.blink();
      aHiht.blink();
      aSnare.blink();
      aPerc.blink();
      aMldy.blink();
      
    
      
      OscMessage baseMessage = new OscMessage("/sec");
      //give Base value for every iteration
      
      if(aRec.b && aRec.mute != true) baseMessage.add(1);
      else baseMessage.add(0);
      
      //give Hiht value for every iteration
      if(aHiht.b && aHiht.mute != true) baseMessage.add(1);
      else baseMessage.add(0);
      
      //give Snare value for every iteration
      if(aSnare.b && aSnare.mute != true) baseMessage.add(1);
      else baseMessage.add(0);
      
      //give Percussion value for every iteration
      if(aPerc.b && aPerc.mute != true) baseMessage.add(1);
      else baseMessage.add(0);
      
      //give Melody value for every iteration
      if(aMldy.b && aMldy.mute != true) baseMessage.add(1);
      else baseMessage.add(0);
      
      //Send Instrument Booleans
      oscP5.send(baseMessage, myRemoteLocation);
      
      //Send Amplitude over OSC
      OscMessage ampMessage = new OscMessage("/amp");
      ampMessage.add(volumeValue);
      oscP5.send(ampMessage, myRemoteLocation);
      
      //Send Rate over OSC
      OscMessage rateMessage = new OscMessage("/rate");
      rateMessage.add(baseRateValue);
      rateMessage.add(hihtRateValue);
      rateMessage.add(snareRateValue);
      rateMessage.add(percRateValue);
      oscP5.send(rateMessage, myRemoteLocation);
      
      //Send Attack over OSC
      OscMessage attkMessage = new OscMessage("/attk");
      attkMessage.add(baseAttackValue);
      attkMessage.add(hihtAttackValue);
      attkMessage.add(snareAttackValue);
      attkMessage.add(percAttackValue);
      attkMessage.add(mldyAttackValue);
      oscP5.send(attkMessage, myRemoteLocation);
      
      //Send Release over OSC
      OscMessage RelMessage = new OscMessage("/rel");
      RelMessage.add(baseReleaseValue);
      RelMessage.add(hihtReleaseValue);
      RelMessage.add(snareReleaseValue);
      RelMessage.add(percReleaseValue);
      RelMessage.add(mldyReleaseValue);
      oscP5.send(RelMessage, myRemoteLocation);
      
      //Send Melody Note over OSC
      OscMessage MldyMessage = new OscMessage("/mldy");
      MldyMessage.add(m[count]);
      oscP5.send(MldyMessage, myRemoteLocation);
      
      //Send Slicer Details over OSC
      OscMessage SliceMessage = new OscMessage("/slice");
      SliceMessage.add(slicerWaveValue);
      SliceMessage.add(slicerBool);
      oscP5.send(SliceMessage, myRemoteLocation);
      
      //Send BPM
      OscMessage bpmMessage = new OscMessage("/bpm");
      float bpm = 1/fps;
      bpmMessage.add(bpm);
      oscP5.send(bpmMessage, myRemoteLocation);
      
      //counter
      count++;
      //restart counter after 16 iterations
      if(count == 16) count = 0;
      
      timer = timer + bpmm;
  }

}

void Volume(float theValue) {
  volumeValue = theValue;
}

void BRate(float theValue) {
  baseRateValue = theValue;
  
}

void HRate(float theValue) {
  hihtRateValue = theValue;
  
}

void SRate(float theValue) {
  snareRateValue = theValue;
  
}

void PRate(float theValue) {
  percRateValue = theValue;
  
}

void BAttk(float theValue) {
  baseAttackValue = theValue;
  
}

void HAttk(float theValue) {
  hihtAttackValue = theValue;
  
}

void SAttk(float theValue) {
  snareAttackValue = theValue;
  
}

void PAttk(float theValue) {
  percAttackValue = theValue;
  
}

void MAttk(float theValue) {
  mldyAttackValue = theValue;
  
}

void BRel(float theValue) {
  baseReleaseValue = theValue;
  
}

void HRel(float theValue) {
  hihtReleaseValue = theValue;
  
}

void SRel(float theValue) {
  snareReleaseValue = theValue;
  
}

void PRel(float theValue) {
  percReleaseValue = theValue;
  
}

void MRel(float theValue) {
  mldyReleaseValue = theValue;
  
}

void BPM(int theValue) { 
  float tmp = theValue * 10;
  fps = tmp / 60;
  bps = fps;
  bpmm = 1/bps*1000;
  print(bpmm + "\n");
}

void M0(int theValue) {
  m[0] = theValue;
}

void M1(int theValue) {
  m[1] = theValue;
}
void M2(int theValue) {
  m[2] = theValue;
}
void M3(int theValue) {
  m[3] = theValue;
}
void M4(int theValue) {
  m[4] = theValue;
}
void M5(int theValue) {
  m[5] = theValue;
}
void M6(int theValue) {
  m[6] = theValue;
}
void M7(int theValue) {
  m[7] = theValue;
}
void M8(int theValue) {
  m[8] = theValue;
}
void M9(int theValue) {
  m[9] = theValue;
}
void M10(int theValue) {
  m[10] = theValue;
}
void M11(int theValue) {
  m[11] = theValue;
}
void M12(int theValue) {
  m[12] = theValue;
}
void M13(int theValue) {
  m[13] = theValue;
}
void M14(int theValue) {
  m[14] = theValue;
}
void M15(int theValue) {
  m[15] = theValue;
}

void Wave(int a){
  if(a == -1) slicerWaveValue = 0;
  else slicerWaveValue = a;
}

void Slicer(boolean theFlag) {
  if(theFlag) slicerBool = 1;
  else slicerBool = 0;
}
















void mouseClicked(){
    //Iterate over every Rec and check if clicked
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
    //check if percRec was clicked
    Rec aPerc = (Rec) perc.get(i);
    aPerc.clickCheck(mouseX, mouseY);
    //check if mldyRec was clicked
    Rec aMldy = (Rec) mldy.get(i);
    aMldy.clickCheck(mouseX, mouseY);
    

}
    //check click on clear button
    clear.clickCheck(mouseX, mouseY);
    
    //check click on pause button
    pause.pauseCheck(mouseX, mouseY);
    
    //check click on Mute Buttons
    for(int i = 0; i < 5; i++) {
      ButtonRec aMute = (ButtonRec) mute.get(i);
      aMute.muteCheck(mouseX, mouseY);
    }

}

//Rec Class
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
        Rec aPerc = (Rec) perc.get(i);
        Rec aMldy = (Rec) mldy.get(i);
        aRec.b = false;
        aHiht.b = false;
        aSnare.b = false;
        aPerc.b = false;
        aMldy.b = false;
        aRec.blink();
        aHiht.blink();
        aSnare.blink();
        aPerc.blink();
        aMldy.blink();
      }
      baseRateKnob.setValue(1.0);
      hihtRateKnob.setValue(1.0);
      snareRateKnob.setValue(1.0);
      percRateKnob.setValue(1.0);
      baseAttackKnob.setValue(0);
      hihtAttackKnob.setValue(0);
      snareAttackKnob.setValue(0);
      percAttackKnob.setValue(0);
      mldyAttackKnob.setValue(0);
      baseReleaseKnob.setValue(0);
      hihtReleaseKnob.setValue(0);
      snareReleaseKnob.setValue(0);
      percReleaseKnob.setValue(0);
      mldyReleaseKnob.setValue(0);
      slicerToogle.setValue(false);
    }
    
  }
  
  void pauseCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      if(check) {
        bpmm = 1/bps*1000;
        timer = millis();
        timer = 0;
        check = false;
        c = #ffb86c;
        pause.draw();
        pValue = "PAUSE";
        
      } else {
        
        c = #ff5555;
        
        bpmm = 9999999999999999999999999999999999.9;
        check = true;
        OscMessage baseMessage = new OscMessage("/sec");
        baseMessage.add(0);
        baseMessage.add(0);
        baseMessage.add(0);
        baseMessage.add(0);
        baseMessage.add(0);
        oscP5.send(baseMessage, myRemoteLocation);
        pValue = "PLAY";
        
        
      }
     
    }
  }
  
  void muteCheck( int _x, int _y ) {
   if( _x > x && _y > y && _x < x+w && _y < y+h ){
     
     if(check == false){
       
       if(val == 5) {
         check = true;
        
         for(int i = 0; i < mldy.size(); i++){
           Rec aMldy = (Rec) mldy.get(i);
           aMldy.mute = true;
         }
         c = #ff5555;
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();         
       }
       
       else if(val == 4) {
         check = true;
        
         for(int i = 0; i < perc.size(); i++){
           Rec aPerc = (Rec) perc.get(i);
           aPerc.mute = true;
         }
         c = #ff5555;
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();         
       }
       
       else if(val == 3) {
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
       
       if(val == 5) {
         check = false;
         c = #ffb86c;
         
         for(int i = 0; i < mldy.size(); i++){
           Rec aMldy = (Rec) mldy.get(i);
           aMldy.mute = false;
         }
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();
         redraw();
       }
       
       else if(val == 4) {
         check = false;
         c = #ffb86c;
         
         for(int i = 0; i < perc.size(); i++){
           Rec aPerc = (Rec) perc.get(i);
           aPerc.mute = false;
         }
         ButtonRec aMute = (ButtonRec) mute.get(0);
         aMute.draw();
         redraw();
       }
       
       else if(val == 3) {
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

class Amp{
  float amp;
  color c;
  int _x;
  int _y;
  int _w;
  int _h;
  
  Amp(int w, int h, int x, int y){
    amp = 1;
    c = #bd93f9;
    _x = x;
    _y = y;
    _w = w;
    _h = h;
  }
  
  void draw() {
    noStroke();
    fill(c);
    rect(_x, _y, _w, _h);
    up = new AmpControl(_x, _y+22, _w, _h/5, 0, #50fa7b);
    down = new AmpControl(_x, _y-6, _w, _h/5, 1, #ff5555);
    up.draw();
    down.draw();
    fill(#ffffff);
    String ampformat = String.format("%.1f", amp);
    text("VOL: " + ampformat, _x + _w/12, _y + _h/1.5);
  }
  
  
}

class AmpControl{
  color c;
  int x;
  int y;
  int w;
  int h;
  int val;
  
  AmpControl(int _x, int _y, int _w, int _h, int v, color co) {
    c = co;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    val = v;
  }
  
  void draw() {
  noStroke();
  fill(c);
  rect(x, y, w, h);
}

  void AmpControlCheck( int _x, int _y ) {
   if( _x > x && _y > y && _x < x+w && _y < y+h ){
     
     if(val == 1) {
       amp.amp = amp.amp + 0.1;
       amp.draw();
     } else{
       amp.amp = amp.amp - 0.1;
       amp.draw();
     }
     
   }
  }
  
  
}
