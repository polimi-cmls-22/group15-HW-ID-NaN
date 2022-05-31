import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

import netP5.*;
import oscP5.*;
import controlP5.*;

OscP5 osc;

VerletPhysics2D physics;

int pitch, pitchColor1 = #FF5722, pitchColor2 = #FFEB3B, pitchColor3 = #4CAF50, pitchColor4 = #03A9F4, pitchColor5 = #3F51B5, pitchColor6 = #9C27B0, pitchColor7 = #E91E63;
int startSizeCaosPoint = 5;
int sizeCaos = startSizeCaosPoint, sizeTrem;

color colorW = #830A05;
color colorS = #830A05;
color colorC = #830A05;

color[] orangeV = {#FFCCBC, #FFAB91, #FF8A65, #FF7043, #FF5722,  #F4511E, #E64A19, #D84315, #BF360C};
color[] yellowV = {#FFF9C4, #FFF59D, #FFF176, #FFEE58, #FFEB3B, #FDD835, #FBC02D, #F9A825, #F57F17};
color[] greenV = {#DCEDC8, #C5E1A5, #81C784, #66BB6A, #4CAF50, #43A047, #388E3C, #2E7D32, #1B5E20};
color[] lightBlueV = {#B3E5FC, #81D4FA, #4FC3F7, #29B6F6, #03A9F4, #039BE5, #0288D1, #0277BD, #01579B};
color[] blueV = {#C5CAE9, #9FA8DA, #7986CB, #5C6BC0, #3F51B5, #3949AB, #303F9F, #283593, #1A237E};
color[] purpleV = {#E1BEE7, #CE93D8, #BA68C8, #AB47BC, #9C27B0, #8E24AA, #7B1FA2, #6A1B9A, #4A148C};
color[] fucsiaV = {#F8BBD0, #F48FB1, #F06292, #EC407A, #E91E63, #D81B60, #C2185B, #AD1457, #880E4F};

boolean DOtrig = false;
boolean REtrig = false;
boolean MItrig = false;
boolean FAtrig = false;
boolean SOLtrig = false;
boolean LAtrig = false;
boolean SItrig = false;

Chain chain;
Chain chain2;
Chain chain3;
Chain chain4;
Chain chain5;
Chain chain6;
Chain chain7;

Wave[] waveFirst= new Wave[7];
Wave[] waveSecond= new Wave[7];
Wave[] waveThird= new Wave[7];
Wave[] waveFourth= new Wave[7];
Wave[] waveFifth= new Wave[7];
Wave[] waveSixth= new Wave[7];
Wave[] waveSeventh= new Wave[7];

Caos caos1;
Caos caos2;
Caos caos3;
Caos caos4;
Caos caos5;
Caos caos6;
Caos caos7;

void setup() {
  
  osc = new OscP5(this, 1201);
  
  fullScreen();
  
 physics = new VerletPhysics2D();
 physics.setWorldBounds(new Rect(0,0,width,height));
 
 chain = new Chain(height+18,20,1.6,width/8, colorS);
 chain2 = new Chain(height+18,20,1.6,(width*2)/8, colorS);
 chain3 = new Chain(height+18,20,1.6,(width*3)/8, colorS);
 chain4 = new Chain(height+18,20,1.6,(width*4)/8, colorS);
 chain5 = new Chain(height+18,20,1.6,(width*5)/8, colorS);
 chain6 = new Chain(height+18,20,1.6,(width*6)/8, colorS);
 chain7 = new Chain(height+18,20,1.6,(width*7)/8, colorS);
 
 waveFirst[0] = new Wave(16, 20, 120, 0.26, width/8, colorW);
 waveFirst[1] = new Wave(20, 20, 120, 0.26, (width/8)-3, colorW);
 waveFirst[2] = new Wave(24, 20, 120, 0.26, (width/8)-6, colorW);
 waveFirst[3] = new Wave(28, 20, 120, 0.26, (width/8)-9, colorW);
 waveFirst[4] = new Wave(32, 20, 120, 0.26, (width/8)+3, colorW);
 waveFirst[5] = new Wave(36, 20, 120, 0.26, (width/8)+6, colorW);
 waveFirst[6] = new Wave(39, 20, 120, 0.26, (width/8)+9, colorW);
 
 waveSecond[0] = new Wave(16, 20, 120, 0.24, width*2/8, colorW);
 waveSecond[1] = new Wave(20, 20, 120, 0.24, (width*2/8)-3, colorW);
 waveSecond[2] = new Wave(24, 20, 120, 0.24, (width*2/8)-6, colorW);
 waveSecond[3] = new Wave(28, 20, 120, 0.24, (width*2/8)-9, colorW);
 waveSecond[4] = new Wave(32, 20, 120, 0.24, (width*2/8)+3, colorW);
 waveSecond[5] = new Wave(36, 20, 120, 0.24, (width*2/8)+6, colorW);
 waveSecond[6] = new Wave(39, 20, 120, 0.24, (width*2/8)+9, colorW);
 
 waveThird[0] = new Wave(16, 20, 120, 0.22, width*3/8, colorW);
 waveThird[1] = new Wave(20, 20, 120, 0.22, (width*3/8)-3, colorW);
 waveThird[2] = new Wave(24, 20, 120, 0.22, (width*3/8)-6, colorW);
 waveThird[3] = new Wave(28, 20, 120, 0.22, (width*3/8)-9, colorW);
 waveThird[4] = new Wave(32, 20, 120, 0.22, (width*3/8)+3, colorW);
 waveThird[5] = new Wave(36, 20, 120, 0.22, (width*3/8)+6, colorW);
 waveThird[6] = new Wave(39, 20, 120, 0.22, (width*3/8)+9, colorW);
 
 waveFourth[0] = new Wave(16, 20, 120, 0.19, width*4/8, colorW);
 waveFourth[1] = new Wave(20, 20, 120, 0.19, (width*4/8)-3, colorW);
 waveFourth[2] = new Wave(24, 20, 120, 0.19, (width*4/8)-6, colorW);
 waveFourth[3] = new Wave(28, 20, 120, 0.19, (width*4/8)-9, colorW);
 waveFourth[4] = new Wave(32, 20, 120, 0.19, (width*4/8)+3, colorW);
 waveFourth[5] = new Wave(36, 20, 120, 0.19, (width*4/8)+6, colorW);
 waveFourth[6] = new Wave(39, 20, 120, 0.19, (width*4/8)+9, colorW);
 
 waveFifth[0] = new Wave(16, 20, 120, 0.17, width*5/8, colorW);
 waveFifth[1] = new Wave(20, 20, 120, 0.17, (width*5/8)-3, colorW);
 waveFifth[2] = new Wave(24, 20, 120, 0.17, (width*5/8)-6, colorW);
 waveFifth[3] = new Wave(28, 20, 120, 0.17, (width*5/8)-9, colorW);
 waveFifth[4] = new Wave(32, 20, 120, 0.17, (width*5/8)+3, colorW);
 waveFifth[5] = new Wave(36, 20, 120, 0.17, (width*5/8)+6, colorW);
 waveFifth[6] = new Wave(39, 20, 120, 0.17, (width*5/8)+9, colorW);
 
 waveSixth[0] = new Wave(16, 20, 120, 0.16, width*6/8, colorW);
 waveSixth[1] = new Wave(20, 20, 120, 0.16, (width*6/8)-3, colorW);
 waveSixth[2] = new Wave(24, 20, 120, 0.16, (width*6/8)-6, colorW);
 waveSixth[3] = new Wave(28, 20, 120, 0.16, (width*6/8)-9, colorW);
 waveSixth[4] = new Wave(32, 20, 120, 0.16, (width*6/8)+3, colorW);
 waveSixth[5] = new Wave(36, 20, 120, 0.16, (width*6/8)+6, colorW);
 waveSixth[6] = new Wave(39, 20, 120, 0.16, (width*6/8)+9, colorW);
 
 waveSeventh[0] = new Wave(16, 20, 120, 0.14, width*7/8, colorW);
 waveSeventh[1] = new Wave(20, 20, 120, 0.14, (width*7/8)-3, colorW);
 waveSeventh[2] = new Wave(24, 20, 120, 0.14, (width*7/8)-6, colorW);
 waveSeventh[3] = new Wave(28, 20, 120, 0.14, (width*7/8)-9, colorW);
 waveSeventh[4] = new Wave(32, 20, 120, 0.14, (width*7/8)+3, colorW);
 waveSeventh[5] = new Wave(36, 20, 120, 0.14, (width*7/8)+6, colorW);
 waveSeventh[6] = new Wave(39, 20, 120, 0.14, (width*7/8)+9, colorW);
 
 caos1 = new Caos(200, width/8, colorC, sizeCaos);
 caos2 = new Caos(200, (width*2)/8, colorC, sizeCaos);
 caos3 = new Caos(200, (width*3)/8, colorC, sizeCaos);
 caos4 = new Caos(200, (width*4)/8, colorC, sizeCaos);
 caos5 = new Caos(200, (width*5)/8, colorC, sizeCaos);
 caos6 = new Caos(200, (width*6)/8, colorC, sizeCaos);
 caos7 = new Caos(200, (width*7)/8, colorC, sizeCaos);
}

void draw() { 
  
  background(#000000);
  
  physics.update();
  
  chain.display();
  chain2.display();
  chain3.display();
  chain4.display();
  chain5.display();
  chain6.display();
  chain7.display();
  
  if(DOtrig){
     for(int i=0; i<7; i++){
      waveFirst[i].display();
      waveFirst[i].waveColor=pitchColor1;
     }
     caos1.caosColor=pitchColor1;
     chain.stringColor=pitchColor1;
     caos1.sizePoint = sizeTrem;
  }
  
  if(REtrig){
     for(int i=0; i<7; i++){
      waveSecond[i].display();
      waveSecond[i].waveColor=pitchColor2;
     }
     caos2.caosColor=pitchColor2;
     chain2.stringColor=pitchColor2;
     caos2.sizePoint = sizeTrem;
  }
  
  if(MItrig){
    for(int i=0; i<7; i++){
      waveThird[i].display();
      waveThird[i].waveColor=pitchColor3;
     }
     caos3.caosColor=pitchColor3;
     chain3.stringColor=pitchColor3;
     caos3.sizePoint = sizeTrem;
  }
  
  if(FAtrig){
     for(int i=0; i<7; i++){
      waveFourth[i].display();
      waveFourth[i].waveColor=pitchColor4;
     }
     caos4.caosColor=pitchColor4;
     chain4.stringColor=pitchColor4;
     caos4.sizePoint = sizeTrem;
  }
  
  if(SOLtrig){
     for(int i=0; i<7; i++){
      waveFifth[i].display();
      waveFifth[i].waveColor=pitchColor5;
     }
     caos5.caosColor=pitchColor5;
     chain5.stringColor=pitchColor5;
     caos5.sizePoint = sizeTrem;
  }
  
  if(LAtrig){
     for(int i=0; i<7; i++){
      waveSixth[i].display();
      waveSixth[i].waveColor=pitchColor6;
     }
     caos6.caosColor=pitchColor6;
     chain6.stringColor=pitchColor6;
     caos6.sizePoint = sizeTrem;
  }
  
  if(SItrig){
      for(int i=0; i<7; i++){
      waveSeventh[i].display();
      waveSeventh[i].waveColor=pitchColor7;
     }
     caos7.caosColor=pitchColor7;
     chain7.stringColor=pitchColor7;
     caos7.sizePoint = sizeTrem;
  }

  caos1.drawCaos();
  caos2.drawCaos();
  caos3.drawCaos();
  caos4.drawCaos();
  caos5.drawCaos();
  caos6.drawCaos();
  caos7.drawCaos();  

}

void oscEvent(OscMessage theOscMessage) {
  
  if (theOscMessage.checkAddrPattern("/noteOn")){
    
    //////////////////DO////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==60){
      DOtrig = true;
      chain.contains(width/8+50, height/2);
      chain.updateMiddle( width/8, height/2);   
    }

  //////////////////RE////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==62){
      REtrig = true;
      chain2.contains(width/8*2+50, height/2);
      chain2.updateMiddle( width*2/8, height/2);
    }
  
  
   //////////////////MI////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==64){
      MItrig = true;
      chain3.contains(width/8*3+50, height/2);
      chain3.updateMiddle( width*3/8, height/2);
    }
    
   //////////////////FA////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==65){
      FAtrig = true;
      chain4.contains(width/8*4+50, height/2);
      chain4.updateMiddle( width*4/8, height/2);
    } 
  
   //////////////////SOL////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==67){
      SOLtrig = true;
      chain5.contains(width/8*5+50, height/2);
      chain5.updateMiddle( width*5/8, height/2);
    }
  
  //////////////////LA////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==69){
      LAtrig = true;
      chain6.contains(width/8*6+50, height/2);
      chain6.updateMiddle( width*6/8, height/2);
    
    }
    
   //////////////////SI////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==71){
      SItrig = true;
      chain7.contains(width/8*7+50, height/2);
      chain7.updateMiddle( width*7/8, height/2);
    }
  
  }
  /////////////////////////PITCHCOLOR/////////////////////////////
       if (theOscMessage.checkAddrPattern("/pitch")){
         if(DOtrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor1 = orangeV[i];
       }
           if(REtrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor2 = yellowV[i];
       }
           if(MItrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor3 = greenV[i];
       }
           if(FAtrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor4 = lightBlueV[i];
       }
           if(SOLtrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor5 = blueV[i];
       }
           if(LAtrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor6 = purpleV[i];
       }
           if(SItrig){
           pitch = theOscMessage.get(0).intValue();
           int i = round(map(pitch, 0, 16383, 0, 8));
           pitchColor7 = fucsiaV[i];
       }
     }
/////////////////////////////TREMOLO////////////////////////////////
      if (theOscMessage.checkAddrPattern("/trem")){
           sizeTrem = theOscMessage.get(0).intValue();
           sizeTrem = round(map(sizeTrem, 0, 127, 3, 20));
      }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////NOTE-OFF////////////////////////////////////////////////////////////////

  if (theOscMessage.checkAddrPattern("/noteOff")){
    
    //////////////////DO////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==60){
    
      caos1.totalPts = 200;
      DOtrig = false;
      chain.stringColor=#830A05;
      caos1.caosColor=#830A05;
      caos1.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveFirst[i].waveColor=#830A05;
      }
    
    }

  //////////////////RE////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==62){
    
      caos2.totalPts = 200;
      REtrig = false;
      chain2.stringColor=#830A05;
      caos2.caosColor=#830A05;
      caos2.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveSecond[i].waveColor=#830A05;
      }
   
    }
  
  
   //////////////////MI////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==64){
    
      caos3.totalPts = 200;
      MItrig = false;
      chain3.stringColor=#830A05;
      caos3.caosColor=#830A05;
      caos3.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveThird[i].waveColor=#830A05;
      }
    
    }
    
   //////////////////FA////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==65){
    
      caos4.totalPts = 200;
      FAtrig = false;
      chain4.stringColor=#830A05;
      caos4.caosColor=#830A05;
      caos4.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveFourth[i].waveColor=#830A05;
      }
    
    } 
  
   //////////////////SOL////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==67){
    
      caos5.totalPts = 200;
      SOLtrig = false;
      chain5.stringColor=#830A05;
      caos5.caosColor=#830A05;
      caos5.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveFifth[i].waveColor=#830A05;
      }
    
    }
  
  //////////////////LA////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==69){
    
      caos6.totalPts = 200;
      LAtrig = false;
      chain6.stringColor=#830A05;
      caos6.caosColor=#830A05;
      caos6.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveSixth[i].waveColor=#830A05;
      }
    
    }
    
   //////////////////SI////////////////////////////////////////
    if(theOscMessage.get(0).intValue()==71){
    
      caos7.totalPts = 200;
      SItrig = false;
      chain7.stringColor=#830A05;
      caos7.caosColor=#830A05;
      caos7.sizePoint = startSizeCaosPoint;
      for(int i=0; i<7; i++){
        waveSeventh[i].waveColor=#830A05;
      }
   
    }
  
  
  }
 
 
}
