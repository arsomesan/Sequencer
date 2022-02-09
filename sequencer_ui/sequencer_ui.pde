
import oscP5.*;
import netP5.*;
import controlP5.*;
import javax.swing.ImageIcon;

//loadJsonObject
//loadJsonArray

OscP5 oscP5;
ControlP5 cp5;

NetAddress myRemoteLocation;


float _bpm;
float bps;
float bpmm = (1/(120/60))*1000;
float timer = 0;
String pValue = "PAUSE";

//initialite Controllers

Knob baseAmpKnob;
float baseAmpValue;

Knob hihtAmpKnob;
float hihtAmpValue;

Knob snareAmpKnob;
float snareAmpValue;

Knob percAmpKnob;
float percAmpValue;

Knob mldyAmpKnob;
float mldyAmpValue;

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
ArrayList random;
ArrayList singleClear;
ArrayList singleClearText;

//initialize single Buttons
ButtonRec clear;
ButtonRec pause;
ButtonRec save;
ButtonRec load;

PImage icon;
float fps;

PFont roboto;

JSONArray data;
void setup() {
  //Font
  roboto = loadFont("RobotoCondensed-Regular-48.vlw");
  textFont(roboto);
  ControlFont font = new ControlFont(roboto, 15);
  
  //Programm Icon
  icon = loadImage("loop.png");
  //ImageIcon barIcon = new ImageIcon(loadBytes("loop.png"));
  //frame.setIconImage(barIcon.getImage());
  //frame.setTitle("JUMBOTUNE");
  surface.setIcon(icon);
  surface.setTitle("JUMBOTUNE");
  
  background(#282a36);
  size(1400,900);
  frameRate(60);
  pixelDensity(2);
  
  cp5 = new ControlP5(this);
  
  

  
  //cp5.setControlFont(font);
  
  //Amp Knobs
  
  baseAmpKnob = cp5.addKnob("BAmp")
                 .setRange(0.1,10)
                 .setValue(1)
                 .setPosition(width - 360, 75)
                 .setRadius(10)
                 .setHeight(30)
                 .setSize(60,60)
                 .setColorForeground(#8be9fd)
                 .setColorBackground(#282a36)
                 .setColorActive(#50fa7b)
                 ;
                 
  hihtAmpKnob = cp5.addKnob("HAmp")
               .setRange(0,10)
               .setValue(1)
               .setPosition(width - 360, 195)
               .setRadius(10)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;

  snareAmpKnob = cp5.addKnob("SAmp")
               .setRange(0,10)
               .setValue(1)
               .setPosition(width - 360, 315)
               .setRadius(10)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;     
     
  percAmpKnob = cp5.addKnob("PAmp")
               .setRange(0,10)
               .setValue(1)
               .setPosition(width - 360, 435)
               .setRadius(10)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ;
  mldyAmpKnob = cp5.addKnob("MAmp")
               .setRange(0,10)
               .setValue(1)
               .setPosition(width - 360, 650)
               .setRadius(10)
               .setHeight(30)
               .setSize(60,60)
               .setColorForeground(#8be9fd)
               .setColorBackground(#282a36)
               .setColorActive(#50fa7b)
               ; 
               
  
  //Rate Knobs       
  baseRateKnob = cp5.addKnob("BRate")
                 .setRange(0.1,10)
                 .setValue(1)
                 .setPosition(width - 120, 75)
                 .setRadius(10)
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
     .setRange(1,250)
     .setValue(120)
     .setDecimalPrecision(0)
     .setNumberOfTickMarks(250)
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
     .setNumberOfTickMarks(101)
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
              .setValue(0)
              .setPosition(width - 360,620)
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
       .setPosition(width-100,620)
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
  random = new ArrayList();
  singleClear = new ArrayList();
  singleClearText = new ArrayList();
  
  //Clear all Button
  clear = new ButtonRec(width - 250, height - 60, 100, 40);
  //Pause Button
  pause = new ButtonRec(width - 370, height - 60, 100, 40);
  
  save = new ButtonRec(width - 440, height - 60, 50, 40);
  
  load = new ButtonRec(width - 500, height - 60, 50, 40);
  
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
    mute.add(new ButtonRec(30, mutepos, 30, 20, val));
    singleClear.add(new ButtonRec(100, mutepos, 30, 20, val));
    textSize(15);
    ButtonRec aSiCl = (ButtonRec) singleClear.get(i);
    aSiCl.c = #ff5555;
    val++;
    mutepos = mutepos + 120;
  }
  
  int rdmpos = 52;
  int rdmval = 1;
  for(int i = 0; i < 5; i++) {
    random.add(new ButtonRec(65, rdmpos, 30, 20,#ff79c6, rdmval));
    rdmval++;
    rdmpos += 120;
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
  save.draw();
  load.draw();
  
  //Draw Texts
  textSize(24);
  fill(#282a36);
  rect(30,height- 110, 200, 40 );
  rect(width - 120,height- 110, 200, 40 );
  fill(#ffffff);
  String realbpm = String.format("%.0f",_bpm);
  String realvol = String.format("%.0f",volumeValue * 100);
  text("BPM: " + realbpm, 30, height - 80);
  text("VOL: " + realvol + "%", width - 130, height - 80);
  fill(#ffffff);
  text(pValue, width - 360, height - 31);
  text("CLEAR", width - 240, height - 31);
  if(fontcount == 0) {
    fill(#6272a4);
    text("KICK", 140, 70); 
    text("HIHAT", 140, 190); 
    text("SNARE", 140, 310); 
    text("PERCS", 140, 430);
    text("MELODY", 140, 550);
    text("SLICER CONTROL", width - 360, 585);
    textSize(15);
    text("ON", width - 125, 635);
    text("OFF", width - 40, 635);
    
    textSize(15);
    fill(#ffb86c);
    rect(320, height - 90, 20, 20);
    fill(#ff79c6);
    rect(320, height - 65, 20, 20);
    fill(#6272a4);
    fill(#ff5555);
    rect(320, height - 40, 20, 20);
    fill(#6272a4);
    text("MUTE", 350, height - 75);
    text("RANDOMIZER", 350, height - 50);
    text("CLEAR", 350, height - 25);
    
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
    ButtonRec aRdm = (ButtonRec) random.get(i);
    aRdm.draw();
    ButtonRec aSiCl = (ButtonRec) singleClear.get(i);
    aSiCl.draw();
  }


  if(millis() > timer) {
    
    
    
    
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
      

      
      
      //Blink Current Recs for every iteration
      Rec aRec = (Rec) rects.get(count);
      Rec aHiht = (Rec) hiht.get(count);
      Rec aSnare = (Rec) snare.get(count);
      Rec aPerc = (Rec) perc.get(count);
      Rec aMldy = (Rec) mldy.get(count);
      
      
           
      //Send BPM
      OscMessage bpmMessage = new OscMessage("/bpm");
      float tmp = bps * 2;
      float bpm = 1/tmp;
      bpmMessage.add(bpm);
      oscP5.send(bpmMessage, myRemoteLocation);
      
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
      ampMessage.add(baseAmpValue);
      ampMessage.add(hihtAmpValue);
      ampMessage.add(snareAmpValue);
      ampMessage.add(percAmpValue);
      ampMessage.add(mldyAmpValue);
      oscP5.send(ampMessage, myRemoteLocation);
      
      //Send Specific Amplitude over OSC
      
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

void BAmp(float theValue) {
  baseAmpValue = theValue;
}

void HAmp(float theValue) {
  hihtAmpValue = theValue;
}

void SAmp(float theValue) {
  snareAmpValue = theValue;
}

void PAmp(float theValue) {
  percAmpValue = theValue;
}

void MAmp(float theValue) {
  mldyAmpValue = theValue;
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
  float tmp = theValue;
  print(tmp + "\n");
  _bpm = tmp;
  bps = tmp / 60;
  float temp = bps * 2;
  bpmm = 1/temp*1000;
  timer = millis();
  print(bpmm);
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
    
    //check click on save button
    save.saveCheck(mouseX, mouseY);
    
    //check click on load button
    load.loadCheck(mouseX, mouseY);
    
    //check click on Mute and Random Buttons
    for(int i = 0; i < 5; i++) {
      ButtonRec aMute = (ButtonRec) mute.get(i);
      aMute.muteCheck(mouseX, mouseY);
      ButtonRec aRdm = (ButtonRec) random.get(i);
      aRdm.mldyRandomCheck(mouseX, mouseY);
      ButtonRec aSiCl = (ButtonRec) singleClear.get(i);
      aSiCl.clearCheck(mouseX, mouseY);
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
  
  ButtonRec(int _x, int _y, int _w, int _h, color _c, int v) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    check = false;
    val = v;
  }
  
  
  void draw(){
    noStroke();
    fill(c);
    rect(x,y,w,h);
    fill(#ffffff);
  }
  
  void saveCheck(int _x, int _y) {
   if( _x > x && _y > y && _x < x+w && _y < y+h ){
     //Save
     data = new JSONArray();
     for (int i = 0; i < 16; i++) {
        JSONObject patterns = new JSONObject();
        
        //Save Kick
        int kickTmp = 0;
        Rec aKick = (Rec) rects.get(i);
        if(aKick.b == false) kickTmp = 0;
        if(aKick.b == true) kickTmp = 1;
        patterns.setInt("aKick"+i, kickTmp);

        //Save Hiht
        int hihtTmp = 0;
        Rec aHiht = (Rec) hiht.get(i);
        if(aHiht.b == false) hihtTmp = 0;
        if(aHiht.b == true) hihtTmp = 1;
        patterns.setInt("aHiht" + i, hihtTmp);
        
        //Save Snare
        int snareTmp = 0;
        Rec aSnare = (Rec) snare.get(i);
        if(aSnare.b == false) snareTmp = 0;
        if(aSnare.b == true) snareTmp = 1;
        patterns.setInt("aSnare" + i, snareTmp);
        
        //Save Perc
        int percTmp = 0;
        Rec aPerc = (Rec) perc.get(i);
        if(aPerc.b == false) percTmp = 0;
        if(aPerc.b == true) percTmp = 1;
        patterns.setInt("aPerc" + i, percTmp);
        
        //Save Melody
        int mldyTmp = 0;
        Rec aMldy = (Rec) mldy.get(i);
        if(aMldy.b == false) mldyTmp = 0;
        if(aMldy.b == true) mldyTmp = 1;
        patterns.setInt("aMldy" + i, mldyTmp);
        
        //Save Melody Notes
        patterns.setInt("aMldyNote"+i, m[i]);
        data.setJSONObject(i, patterns);
  }
    JSONObject ampValues = new JSONObject();
    ampValues.setFloat("Bamp", baseAmpValue);
    ampValues.setFloat("Hamp", hihtAmpValue);
    ampValues.setFloat("Samp", snareAmpValue);
    ampValues.setFloat("Pamp", percAmpValue);
    ampValues.setFloat("Mamp", mldyAmpValue);
    data.setJSONObject(16, ampValues);
    
    JSONObject relValues = new JSONObject();
    relValues.setFloat("Brel", baseReleaseValue);
    relValues.setFloat("Hrel", hihtReleaseValue);
    relValues.setFloat("Srel", snareReleaseValue);
    relValues.setFloat("Prel", percReleaseValue);
    relValues.setFloat("Mrel", mldyReleaseValue);
    data.setJSONObject(17, relValues);
    
    JSONObject attValues = new JSONObject();
    attValues.setFloat("Batt", baseAttackValue);
    attValues.setFloat("Hatt", hihtAttackValue);
    attValues.setFloat("Satt", snareAttackValue);
    attValues.setFloat("Patt", percAttackValue);
    attValues.setFloat("Matt", mldyAttackValue);
    data.setJSONObject(18, attValues);
    
    JSONObject rateValues = new JSONObject();
    rateValues.setFloat("Brate", baseRateValue);
    rateValues.setFloat("Hrate", hihtRateValue);
    rateValues.setFloat("Srate", snareRateValue);
    rateValues.setFloat("Prate", percRateValue);
    data.setJSONObject(19, rateValues);
    
    JSONObject waveValue = new JSONObject();
    waveValue.setInt("Wave", slicerWaveValue);
    data.setJSONObject(20, waveValue);
    
    JSONObject bpmValue = new JSONObject();
    bpmValue.setFloat("Bpm", _bpm);
    data.setJSONObject(21, bpmValue);
    
    saveJSONArray(data, "data/new.json");
   }
  }
  
   void loadCheck(int _x, int _y) {
   if( _x > x && _y > y && _x < x+w && _y < y+h ){
      data = loadJSONArray("/data/new.json");
      for(int i = 0; i < 16; i++) {
        JSONObject patterns = data.getJSONObject(i);
        //Load Kick pattern

        Rec aKick = (Rec) rects.get(i);
        if(patterns.getInt("aKick"+i) == 0) aKick.b = false;
        else aKick.b = true;
        aKick.blink();
        
        //Load Perc pattern
        Rec aHiht = (Rec) hiht.get(i);
        if(patterns.getInt("aHiht"+i) == 0) aHiht.b = false;
        else aHiht.b = true;
        aHiht.blink();
        
        //Load Snare pattern
        Rec aSnare = (Rec) snare.get(i);
        if(patterns.getInt("aSnare"+i) == 0) aSnare.b = false;
        else aSnare.b = true;
        aSnare.blink();
        
        //Load Perc pattern
        Rec aPerc = (Rec) perc.get(i);
        if(patterns.getInt("aPerc"+i) == 0) aPerc.b = false;
        else aPerc.b = true;
        aPerc.blink();
        
        //Load Mldy pattern
        Rec aMldy = (Rec) mldy.get(i);
        if(patterns.getInt("aMldy"+i) == 0) aMldy.b = false;
        else aMldy.b = true;
        aMldy.blink();
        
        //Load Mldy Notes 
        m[i] = patterns.getInt("aMldyNote" + i);
        cp5.getController("M"+i).setValue(m[i]);
        
        
        
      }
        //Load Amp Values
        JSONObject ampValues = data.getJSONObject(16);
        baseAmpValue = ampValues.getFloat("Bamp");
        baseAmpKnob.setValue(baseAmpValue);
        hihtAmpValue = ampValues.getFloat("Hamp");
        hihtAmpKnob.setValue(hihtAmpValue);
        snareAmpValue = ampValues.getFloat("Samp");
        snareAmpKnob.setValue(snareAmpValue);
        percAmpValue = ampValues.getFloat("Pamp");
        percAmpKnob.setValue(percAmpValue);
        mldyAmpValue = ampValues.getFloat("Mamp");
        mldyAmpKnob.setValue(mldyAmpValue);
        
        //Load Release Values
        JSONObject relValues = data.getJSONObject(17);
        baseReleaseValue = relValues.getFloat("Brel");
        baseReleaseKnob.setValue(baseReleaseValue);
        hihtReleaseValue = relValues.getFloat("Hrel");
        hihtReleaseKnob.setValue(hihtReleaseValue);
        snareReleaseValue = relValues.getFloat("Srel");
        snareReleaseKnob.setValue(snareReleaseValue);
        percReleaseValue = relValues.getFloat("Prel");
        percReleaseKnob.setValue(percReleaseValue);
        mldyReleaseValue = relValues.getFloat("Mrel");
        mldyReleaseKnob.setValue(mldyReleaseValue);
        
        //Load Attack Values
        JSONObject attValues = data.getJSONObject(18);
        baseAttackValue = attValues.getFloat("Batt");
        baseAttackKnob.setValue(baseAttackValue);
        hihtAttackValue = attValues.getFloat("Hatt");
        hihtAttackKnob.setValue(hihtAttackValue);
        snareAttackValue = attValues.getFloat("Satt");
        snareAttackKnob.setValue(snareAttackValue);
        percAttackValue = attValues.getFloat("Patt");
        percAttackKnob.setValue(percAttackValue);
        mldyAttackValue = attValues.getFloat("Matt");
        mldyAttackKnob.setValue(mldyAttackValue);
        
        //Load Rate Values
        JSONObject rateValues = data.getJSONObject(19);
        baseRateValue = rateValues.getFloat("Brate");
        baseRateKnob.setValue(baseRateValue);
        hihtRateValue = rateValues.getFloat("Hrate");
        hihtRateKnob.setValue(hihtRateValue);
        snareRateValue = rateValues.getFloat("Srate");
        snareRateKnob.setValue(snareRateValue);
        percRateValue = rateValues.getFloat("Prate");
        percRateKnob.setValue(percRateValue);
        
        //Load Slicer Wave Value
        JSONObject waveValue = data.getJSONObject(20);
        slicerWaveValue = waveValue.getInt("Wave");
        slicerWave.setValue(slicerWaveValue);
        
        JSONObject bpmValue = data.getJSONObject(21);
        _bpm = bpmValue.getFloat("Bpm");
        bps = _bpm/60;
        float temp = bps*2;
        bpmm = 1/temp*1000;
        cp5.getController("BPM").setValue(_bpm);
        timer = millis();
   }
  }
    
  void clickCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      for(int i = 0; i < 16; i++) {
        Rec aRec = (Rec) rects.get(i);
        Rec aHiht = (Rec) hiht.get(i);
        Rec aSnare = (Rec) snare.get(i);
        Rec aPerc = (Rec) perc.get(i);
        Rec aMldy = (Rec) mldy.get(i);
        cp5.getController("M"+i).setValue(0);
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
        
        aRec.mute = false;
        aHiht.mute = false;
        aSnare.mute = false;
        aPerc.mute = false;
        aMldy.mute = false;
        
      }
      
      for(int i = 0; i < mute.size(); i++) {
        ButtonRec aMute = (ButtonRec) mute.get(i);
        aMute.check = false;
        aMute.c = #ffb86c;
        aMute.draw();
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
      baseAmpKnob.setValue(1);
      hihtAmpKnob.setValue(1);
      snareAmpKnob.setValue(1);
      percAmpKnob.setValue(1);
      mldyAmpKnob.setValue(1);
      
    }
    
  }
  
  void clearCheck( int _x, int _y) {
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      if(val == 5) {
          for(int i = 0; i < mldy.size(); i++){
           Rec aMldy = (Rec) mldy.get(i);
           aMldy.b = false;
           aMldy.blink();
      }
    }
    else if(val == 4) {
          for(int i = 0; i < perc.size(); i++){
           Rec aPerc = (Rec) perc.get(i);
           aPerc.b = false;
           aPerc.blink();
      }
    }
    else if(val == 3) {
          for(int i = 0; i < snare.size(); i++){
           Rec aSnare = (Rec) snare.get(i);
           aSnare.b = false;
           aSnare.blink();
      }
    }
    else if(val == 2) {
          for(int i = 0; i < hiht.size(); i++){
           Rec aHiht = (Rec) hiht.get(i);
           aHiht.b = false;
           aHiht.blink();
      }
    }
    else {
          for(int i = 0; i < rects.size(); i++){
           Rec aRec = (Rec) rects.get(i);
           aRec.b = false;
           aRec.blink();
      }
    }
    
  }
  }
  
  void pauseCheck( int _x, int _y ){
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      if(check) {
        timer = millis();
        check = false;
        c = #ffb86c;
        pause.draw();
        pValue = "PAUSE";
        
      } else {
        
        c = #ff5555;  
        timer = Float.MAX_VALUE;     
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
  
  void mldyRandomCheck(int _x, int _y) {
    if( _x > x && _y > y && _x < x+w && _y < y+h ){
      
      if(val == 5) {
        for(int i = 0; i < 16; i++) {
          cp5.getController("M"+i).setValue(random(127));
          Rec aMldy = (Rec) mldy.get(i);
          int tmp = Math.round(random(1));
          if(tmp == 1) aMldy.b = true;
          else aMldy.b = false;
          aMldy.blink();
        }
      }
        
      else if(val == 4) {
        for(int i = 0; i < perc.size(); i++) {
          Rec aPerc = (Rec) perc.get(i);
          int tmp = Math.round(random(1));
          if(tmp == 1) aPerc.b = true;
          else aPerc.b = false;
          aPerc.blink();
        } 
      }
     else if(val == 3) {
        for(int i = 0; i < snare.size(); i++) {
          Rec aSnare = (Rec) snare.get(i);
          int tmp = Math.round(random(1));
          if(tmp == 1) aSnare.b = true;
          else aSnare.b = false;
          aSnare.blink();
        }
      }
     else if(val == 2) {
        for(int i = 0; i < hiht.size(); i++) {
          Rec aHiht = (Rec) hiht.get(i);
          int tmp = Math.round(random(1));
          if(tmp == 1) aHiht.b = true;
          else aHiht.b = false;
          aHiht.blink();
        }
      }
      
     else {
        for(int i = 0; i < rects.size(); i++) {
          Rec aRec = (Rec) rects.get(i);
          int tmp = Math.round(random(1));
          if(tmp == 1) aRec.b = true;
          else aRec.b = false;
          aRec.blink();
        }
      }
      
      
    }
  }

}
