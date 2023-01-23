
#ifndef simonSays
#define simonSays
 //macros
#include "shared.h"
//#include "lcdFinal.h"
//variables
unsigned char MaxLevel=40;
unsigned char LedsPerlevel;
unsigned char SetSequence[10], TempSequence; //max level is 40
unsigned char LedNumber, UserSequence;
unsigned char Temp;//TempVariable

//functions
void getSequence();
void setLedsPerLevel();
void showSequence();
void checkSequence();
void correctSequence();
void incorrectSequence();
unsigned char userInput();// char idk
void initSimonSays();
void startSimonSays();
//void myDelay();

void startSimonSays(){
  initSimonSays();
  while(CurrentLevel != 0 && CurrentLevel <= MaxLevel){
  setLedsPerLevel();
  getSequence();
  showSequence();
  checkSequence();
  }
  //print all levels cleared
}
void initSimonSays(){
  TRISB = TRISB & 0x38; //correct and incorrect , grb leds
  PORTB &= 0X38;
  PORTC &= 0b11000111;
  TRISC |= 0b00111000; //c543 = 1
  MaxLevel=40;
  CurrentLevel = 1;
}


void setLedsPerLevel(){
 LedsPerLevel = CurrentLevel ;
}

void getSequence(){
  for( Temp = 0 ; Temp <= (LedsPerLevel-1)/4 + 1 ; Temp++)
  SetSequence[(LedsPerLevel-1)/4] = 0x67;// 0110-0111 // Green Red Green Blue <-
}

void showSequence(){
 for(Temp = 1; Temp <= LedsPerLevel; Temp++){
   if(Temp % 4 == 1) {TempSequence = SetSequence[(LedsPerLevel-1)/4]; }
   else { TempSequence = TempSequence >> 2; }
   LedNumber = TempSequence & 0x03;
   if(LedNumber == 1) setGreenLed;
   else if(LedNumber == 2) setRedLed;
   else if(LedNumber == 3) setBlueLed;
   myDelay();
   clearLeds;
   myDelay();

 }

}
unsigned char userInput(){
 while(1){
 if(pressedGreenLed) {setGreenLed; myDelay(); clearGreenLed; return 0x01;}
 if(pressedRedLed) {setRedLed;  myDelay(); clearRedLed; return 0x02;}
 if(pressedBlueLed) {setBlueLed;  myDelay(); clearBlueLed; return 0x03; }

 }
 return 0;//check wdt etc idk
}

void checkSequence(){
  unsigned char Correct = 1;    // replace with TempSequence to use less variables
 for(Temp = 1; Temp <= LedsPerLevel; Temp++){
    if(Temp % 4 == 1) TempSequence = SetSequence[(LedsPerLevel-1)/4];
    else TempSequence = TempSequence >> 2;
    UserSequence = userInput();
    LedNumber = TempSequence & 0x03;
    if(LedNumber != UserSequence) { Correct = 0 ; break; }
    //myDelay(); //imp to add if delays are not added in userInput

 }
   if(Correct) { correctSequence();}
   else  {incorrectSequence();}
}
void correctSequence(){
  //print level up
  CurrentLevel++;
  setCorrectLed;
  myDelay();
  clearCorrectLed;

}
void incorrectSequence(){
  setIncorrectLed;
  myDelay();
  clearIncorrectLed;
  CurrentLevel = 0;
}
#endif