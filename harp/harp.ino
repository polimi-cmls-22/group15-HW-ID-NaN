
#include "MIDIUSB.h"
#define trig 24
#define echo 25

#define trig_trem 28
#define echo_trem 29


void noteOn(byte channel, byte pitch, byte velocity) {
  midiEventPacket_t noteOn = {0x09, 0x90 | channel, pitch, velocity};
  MidiUSB.sendMIDI(noteOn);
}

void noteOff(byte channel, byte pitch, byte velocity) {
  midiEventPacket_t noteOff = {0x08, 0x80 | channel, pitch, velocity};
  MidiUSB.sendMIDI(noteOff);
}

void noteBend(byte cmd, byte data1, byte  data2) {
  midiEventPacket_t midiMsg = {cmd >> 4, cmd, data1, data2};
  MidiUSB.sendMIDI(midiMsg);
}

void controlChange(byte channel, byte control, byte value) {
  midiEventPacket_t event = {0x0B, 0xB0 | channel, control, value};
  MidiUSB.sendMIDI(event);

}

int pitchBend = 8192;
int shiftedValue;
byte msb;
byte lsb;
int trem_value = 0;

int DO = A11;
int RE = A9;
int MI = A7;
int FA = A5;
int SOL = A3; 
int LA = A1;
int SI = A0;

int doL = 0;
int reL = 0;
int miL = 0;
int faL = 0;
int solL = 0;
int laL = 0;
int siL = 0;

float dur,dis;
float dur_trem, dis_trem;

void setup() {
  Serial.begin(115200);
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(trig_trem, OUTPUT);
  pinMode(echo_trem, INPUT);

}

void loop() {

  //pitch
  digitalWrite(trig, LOW);
  delayMicroseconds(2);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);
  dur = pulseIn(echo, HIGH);
  dis = (dur/2) * 0.0343;
  
  ////tremolo
  digitalWrite(trig_trem, LOW);
  delayMicroseconds(2);
  digitalWrite(trig_trem, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig_trem, LOW);
  dur_trem = pulseIn(echo_trem, HIGH);
  dis_trem = (dur_trem/2) * 0.0343;

  delay(3); 

  ////////////PITCH////////////////////////////////////////
  
  if (dis <= 25 && dis >= 2){
        pitchBend = map(dis, 2, 40, 0, 16383);
        shiftedValue = pitchBend << 1;        // shift so top bit of lsb is in msb
        msb = highByte(shiftedValue);        // get the high bits
        lsb = lowByte(shiftedValue) >> 1;    // get the low 7 bits and shift right
        noteBend(0xE0, lsb, msb);
        MidiUSB.flush();
      }

////////////////TREMOLO///////////////////////////////////
  
  if (dis_trem <= 25 && dis_trem >= 2){
        trem_value = map(dis_trem, 40, 2, 0, 127);
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
  else{
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
    }

////////////////////////NOTES///////////////////////////////    

  delay(10);

  if (analogRead(DO)<500 && doL==0)
    {
        noteOn(0, 60, 127);
        MidiUSB.flush();
        doL=1;
    }
  if (analogRead(DO)>=500 && doL==1)
    {
      noteOff(0, 60, 127);
      MidiUSB.flush();

      if (dis_trem> 25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      
      doL=0;
    }

    
  if (analogRead(RE)<=500  && reL==0)
    {
      noteOn(0, 62, 127);
      MidiUSB.flush();
      reL=1;
    }
  if (analogRead(RE)>500 && reL==1)
    {
      noteOff(0, 62, 127);
      MidiUSB.flush();

      if (dis_trem>25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      reL=0;
    }


  if (analogRead(MI)<=500 && miL==0)
    {
      noteOn(0, 64, 127);
      MidiUSB.flush();
      miL=1;
    }
  if (analogRead(MI)>500 && miL==1)
    {
      noteOff(0, 64, 127);
      MidiUSB.flush();
      if (dis_trem> 25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      miL=0;
    }

    
  if (analogRead(FA)<=500 && faL==0)
    {
      noteOn(0, 65, 127);
      MidiUSB.flush();
      faL=1;
    }
  if (analogRead(FA)>500 && faL==1)
    {
      noteOff(0, 65, 127);
      MidiUSB.flush();

      if (dis_trem> 25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      faL=0;
    }

    
  if (analogRead(SOL)<=500 && solL==0)
    {
      noteOn(0, 67, 127);
      MidiUSB.flush();
      solL=1;
    }
  if (analogRead(SOL)>500 && solL==1)
    {
      noteOff(0, 67, 127);
      MidiUSB.flush();
      
      if (dis_trem> 25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      solL=0;
    }

    
  if (analogRead(LA)<=500 && laL==0)
    {
      noteOn(0, 69, 127);
      MidiUSB.flush();
      laL=1;
    }
  if (analogRead(LA)>500 && laL==1)
    {
      noteOff(0, 69, 127);
      MidiUSB.flush();
      if (dis_trem>25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      laL=0;
    }

    
     if (analogRead(SI)<=500 && siL==0)
    {
      noteOn(0, 71, 127);
      MidiUSB.flush();
      siL=1;
    }
  if (analogRead(SI)>500 && siL==1)
    {
      noteOff(0, 71, 127);
      MidiUSB.flush();
      if (dis_trem>25){
        trem_value=0;
        controlChange(0, 10, trem_value);
        MidiUSB.flush();
        }
      siL=0;
    }
 
}
