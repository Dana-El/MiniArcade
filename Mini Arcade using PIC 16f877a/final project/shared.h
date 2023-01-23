#ifndef shared
#define shared

#define setGreenLed  PORTB = PORTB | 0x01
#define clearGreenLed  PORTB = PORTB & 0xfe
#define setRedLed  PORTB = PORTB | 0x02
#define clearRedLed  PORTB = PORTB & 0xfd
#define setBlueLed  PORTB = PORTB | 0x04
#define clearBlueLed  PORTB = PORTB & 0xfb

#define setCorrectLed PORTB = PORTB | 0x80
#define clearCorrectLed PORTB = PORTB & 0x7f
#define setIncorrectLed PORTB = PORTB | 0x40
#define clearIncorrectLed PORTB = PORTB & 0xbf

#define pressedGreenLed (PORTC & 0x08)
#define pressedRedLed (PORTC & 0x10)
#define pressedBlueLed (PORTC & 0x20)
#define PressedStartUltrasonic (PORTB & 0x08)

#define setLeds setRedLed; setGreenLed; setBlueLed;
#define clearLeds clearRedLed; clearGreenLed; clearBlueLed;
unsigned char CurrentLevel;

void usDelay(unsigned int);
void msDelay(unsigned int);
void myDelay();

void myDelay(){
unsigned char k;
int j;
for(k=0;k<50;k++){
   for(j=0;j<2000;j++){
      k=k; j=j;
   }
 }
}
void usDelay(unsigned int usCnt){
unsigned int us=0;

for(us=0;us<usCnt;us++){
  asm NOP;//0.5 uS
  asm NOP;//0.5uS
}

}
void msDelay(unsigned int msCnt){
unsigned int ms=0;
unsigned int cc=0;
for(ms=0;ms<(msCnt);ms++){
for(cc=0;cc<155;cc++);//1ms
}

}

#endif
