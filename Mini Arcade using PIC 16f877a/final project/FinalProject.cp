#line 1 "D:/aaaapsut/embedded/projects/final project/FinalProject.c"
#line 1 "d:/aaaapsut/embedded/projects/final project/simonsays.h"
#line 1 "d:/aaaapsut/embedded/projects/final project/shared.h"
#line 23 "d:/aaaapsut/embedded/projects/final project/shared.h"
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
 asm NOP;
 asm NOP;
}

}
void msDelay(unsigned int msCnt){
unsigned int ms=0;
unsigned int cc=0;
for(ms=0;ms<(msCnt);ms++){
for(cc=0;cc<155;cc++);
}

}
#line 8 "d:/aaaapsut/embedded/projects/final project/simonsays.h"
unsigned char MaxLevel=40;
unsigned char LedsPerlevel;
unsigned char SetSequence[10], TempSequence;
unsigned char LedNumber, UserSequence;
unsigned char Temp;


void getSequence();
void setLedsPerLevel();
void showSequence();
void checkSequence();
void correctSequence();
void incorrectSequence();
unsigned char userInput();
void initSimonSays();
void startSimonSays();


void startSimonSays(){
 initSimonSays();
 while(CurrentLevel != 0 && CurrentLevel <= MaxLevel){
 setLedsPerLevel();
 getSequence();
 showSequence();
 checkSequence();
 }

}
void initSimonSays(){
 TRISB = TRISB & 0x38;
 PORTB &= 0X38;
 PORTC &= 0b11000111;
 TRISC |= 0b00111000;
 MaxLevel=40;
 CurrentLevel = 1;
}


void setLedsPerLevel(){
 LedsPerLevel = CurrentLevel ;
}

void getSequence(){
 for( Temp = 0 ; Temp <= (LedsPerLevel-1)/4 + 1 ; Temp++)
 SetSequence[(LedsPerLevel-1)/4] = 0x67;
}

void showSequence(){
 for(Temp = 1; Temp <= LedsPerLevel; Temp++){
 if(Temp % 4 == 1) {TempSequence = SetSequence[(LedsPerLevel-1)/4]; }
 else { TempSequence = TempSequence >> 2; }
 LedNumber = TempSequence & 0x03;
 if(LedNumber == 1)  PORTB = PORTB | 0x01 ;
 else if(LedNumber == 2)  PORTB = PORTB | 0x02 ;
 else if(LedNumber == 3)  PORTB = PORTB | 0x04 ;
 myDelay();
  PORTB = PORTB & 0xfd ; PORTB = PORTB & 0xfe ; PORTB = PORTB & 0xfb ; ;
 myDelay();

 }

}
unsigned char userInput(){
 while(1){
 if( (PORTC & 0x08) ) { PORTB = PORTB | 0x01 ; myDelay();  PORTB = PORTB & 0xfe ; return 0x01;}
 if( (PORTC & 0x10) ) { PORTB = PORTB | 0x02 ; myDelay();  PORTB = PORTB & 0xfd ; return 0x02;}
 if( (PORTC & 0x20) ) { PORTB = PORTB | 0x04 ; myDelay();  PORTB = PORTB & 0xfb ; return 0x03; }

 }
 return 0;
}

void checkSequence(){
 unsigned char Correct = 1;
 for(Temp = 1; Temp <= LedsPerLevel; Temp++){
 if(Temp % 4 == 1) TempSequence = SetSequence[(LedsPerLevel-1)/4];
 else TempSequence = TempSequence >> 2;
 UserSequence = userInput();
 LedNumber = TempSequence & 0x03;
 if(LedNumber != UserSequence) { Correct = 0 ; break; }


 }
 if(Correct) { correctSequence();}
 else {incorrectSequence();}
}
void correctSequence(){

 CurrentLevel++;
  PORTB = PORTB | 0x80 ;
 myDelay();
  PORTB = PORTB & 0x7f ;

}
void incorrectSequence(){
  PORTB = PORTB | 0x40 ;
 myDelay();
  PORTB = PORTB & 0xbf ;
 CurrentLevel = 0;
}
#line 1 "d:/aaaapsut/embedded/projects/final project/targetgame.h"




void rotate_90();
void rotate_180();
void rotate_0();
void checkLDR();
unsigned int reading;
unsigned int reading_before;
void ADC_init(void);
unsigned int ADC_read(void);
unsigned char i;
unsigned char cnt =0;
unsigned char HL;
unsigned int angle;
unsigned char score =0;
void startTarget();

void interrupt(void){

 if(PIR2&0x01){
 if(HL){
 CCPR2H= angle >>8;
 CCPR2L= angle;
 HL=0;
 CCP2CON=0x09;
 TMR1H=0;
 TMR1L=0;
 }
 else{
 CCPR2H= (40000 - angle) >>8;
 CCPR2L= (40000 - angle);
 CCP2CON=0x08;
 HL=1;
 TMR1H=0;
 TMR1L=0;

 }

 PIR2=PIR2&0B11111110;
 }

 }

void startTarget() {

 unsigned char k;
 trisb = trisb & 0x7f;

 trisc = trisc &0B11111101;
 trisb = trisb |0x01;
 TMR1H=0;
 TMR1L=0;
 HL=1;
 CCP2CON=0x08;
 T1CON=0x01;
 INTCON=0b11000000;
 PIE2=PIE2|0x01;
 CCPR2H=2000>>8;
 CCPR2L=2000;
 portb = portb & 0x7f;

 score =0;
 k=10;
 while(k--){


 rotate_90();
 reading_before = ADC_read();
 msDelay(600);
 checkLDR();
 rotate_180();
 msDelay(600);
#line 81 "d:/aaaapsut/embedded/projects/final project/targetgame.h"
 }
 score = score -10;

}
void turnON(unsigned char cnt){
 if(cnt>0) return;
  PORTB = PORTB | 0x80 ;
 msDelay(600);
  PORTB = PORTB & 0x7f ;
 score=score+10;

}
void checkLDR(){
 unsigned char voltage;

 ADC_init();
 reading = ADC_read();
 voltage = (reading*500)/1023;
 cnt=0;


 if(reading-100 >reading_before){

 turnON(cnt);
 cnt++;
 }



}


void ADC_init(void){
 ADCON0 = 0x41;
 ADCON1= 0xCE;
 TRISA= 0x01;

}
unsigned int ADC_read(void){
 ADCON0 = ADCON0 | 0x04;
 while(ADCON0 & 0x04);
 return (ADRESH<<8)|ADRESL;

}

void rotate_90(){
#line 140 "d:/aaaapsut/embedded/projects/final project/targetgame.h"
 angle=2000;
 msDelay(2000);

}
void rotate_180(){
#line 156 "d:/aaaapsut/embedded/projects/final project/targetgame.h"
 angle=3700;
 msDelay(2000);

}
void rotate_0(){
#line 171 "d:/aaaapsut/embedded/projects/final project/targetgame.h"
 angle=490;
 msDelay(2000);
}
#line 1 "d:/aaaapsut/embedded/projects/final project/ultrasonic.h"
#line 1 "d:/aaaapsut/embedded/projects/final project/shared.h"
#line 1 "d:/aaaapsut/embedded/projects/final project/lcdfinal.h"
#line 1 "d:/aaaapsut/embedded/projects/final project/shared.h"
#line 14 "d:/aaaapsut/embedded/projects/final project/lcdfinal.h"
void cmd(unsigned char a)
{
  PORTB= PORTB & 0XEF ;
  PORTD  = a;
  PORTB=PORTB | 0X20 ;
 msDelay(5);
  PORTB= PORTB & 0XDF ;
 usDelay(100);
 return;
}

void lcd_init()
{
 msDelay(20);
  TRISB  &= 0xcf;
  TRISD  = 0x00;
  PORTB= PORTB & 0XEF ;
  PORTB= PORTB & 0XDF ;

 cmd(0x38);
 cmd(0x0c);
 cmd(0x01);
 cmd(0x06);
}
void send_data(unsigned char b)
{
  PORTB=PORTB| 0X10 ;
  PORTD  = b ;
  PORTB=PORTB | 0X20 ;
 msDelay(5);
  PORTB= PORTB & 0XDF ;
 usDelay(100);
}
void print_string(unsigned char str[]){
 unsigned int i=0;
 while(str[i] != '\0'){
 if(i==15) cmd(0xc0) ;
 if(i==29) cmd(0x80);

 send_data(str[i]);
 i++;
 }
}
#line 5 "d:/aaaapsut/embedded/projects/final project/ultrasonic.h"
unsigned long T1counts;
unsigned long T1time;
unsigned long Distance;
unsigned int Dcntr;
unsigned char RequiredDistance[11]={0,3,5,8,6,7,8,4,3,5,4}, UltrasonicScore, UltrasonicMaxLevel=5;

unsigned char cntr=0;


void init_sonar(void);
void read_sonar(void);

void startUltrasonic(){


 lcd_init();
 cmd(0X01);
 init_sonar();

 while(CurrentLevel <= UltrasonicMaxLevel){
 cmd(0X01);
 print_string("Required ");
 send_data(0x30 + RequiredDistance[CurrentLevel]);
 msDelay(5000);
 read_sonar();
 cmd(0X01);
 print_string("Read ");
 send_data(0x30 + Distance);
 msDelay(1000);
 }
 cmd(0X01);
 print_string("Game Completed");
 msDelay(300);
}
void init_sonar(void){

 CurrentLevel=1;
 UltrasonicScore = 40;
 T1counts=0;
 T1time=0;
 Distance=0;
 TMR1H=0;
 TMR1L=0;
 TRISA &= 0b1111101;
 TRISA |= 0b00000100;
 ADCON1= 0xCE;
 T1CON=0x18;
}
void read_sonar(void){
delay_ms(100);

 CurrentLevel++;
 TMR1H=0;
 TMR1L=0;
 PORTA |= 0x02;
 usDelay(10);
 PORTA &= 0b11111101;
 while(!(PORTA&0x04));
 T1CON=0x19;
 while(PORTA&0x04);
 T1CON=0x18;
 T1counts=((TMR1H<<8)|TMR1L);
 T1time=T1counts;
 Distance=((T1time*34)/(1000))/2;



 if( Distance > RequiredDistance[CurrentLevel])
 UltrasonicScore -= (Distance - RequiredDistance[CurrentLevel]);
 else UltrasonicScore -= (RequiredDistance[CurrentLevel] - Distance);

}
#line 1 "d:/aaaapsut/embedded/projects/final project/shared.h"
#line 5 "D:/aaaapsut/embedded/projects/final project/FinalProject.c"
void startGame();
void main() {
 TRISB = TRISB & 0x38;
 PORTB &= 0X38;
 PORTC &= 0b11000011;
 TRISC |= 0b00111100;
 startSimonSays();
 startTarget();
 startUltrasonic();

}
void startGame(){
INTCON = 0X00;
ADCON1 &= 0x06;


}
