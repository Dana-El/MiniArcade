 #ifndef Ultrasonic
 #define Ultrasonic
#include "shared.h"
#include "lcdFinal.h"
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
    //CCP1CON=0x00;// Disable CCP. Capture on rising for the first time.  Capture on Rising: 0x05, Capture on Falling: 0x04
    CurrentLevel=1;
    UltrasonicScore = 40;
    T1counts=0;
    T1time=0;
    Distance=0;
    TMR1H=0;
    TMR1L=0;
    TRISA &= 0b1111101; //RA1 for trigger output
    TRISA |= 0b00000100;//RA2 for echo input
    ADCON1= 0xCE; // RA0 analog the rest are digital, Fosc/16=500KHz, right justify
    T1CON=0x18;//TMR1 OFF,  Fosc/4 (inc 1uS) with 1:2 prescaler (TMR1 overflow after 0xFFFF counts ==65536)==> 65.536ms
}
void read_sonar(void){
delay_ms(100);
//no need for overflow since Distance needed will be 10cm or less
    CurrentLevel++;
    TMR1H=0;
    TMR1L=0;
    PORTA |= 0x02;//Trigger the ultrasonic sensor (RA1 connected to trigger)
    usDelay(10);//keep trigger for 10uS
    PORTA &= 0b11111101;//Remove trigger
    while(!(PORTA&0x04)); //stuck here
    T1CON=0x19;//TMR1 ON,  Fosc/4 (inc 1uS) with 1:2 prescaler (TMR1 overflow after 0xFFFF counts ==65536)==> 65.536ms
    while(PORTA&0x04);
    T1CON=0x18;//TMR1 OFF,  Fosc/4 (inc 1uS) with 1:1 prescaler (TMR1 overflow after 0xFFFF counts ==65536)==> 65.536ms
    T1counts=((TMR1H<<8)|TMR1L);
   T1time=T1counts;//in microseconds
   Distance=((T1time*34)/(1000))/2; //in cm, shift left twice to divide by 2
   //range=high level time(usec)*velocity(340m/sec)/2 >> range=(time*0.034cm/usec)/2
   //time is in usec and distance is in cm so 340m/sec >> 0.034cm/usec
   //divide by 2 since the travelled distance is twice that of the range from the object leaving the sensor then returning when hitting an object)
   if( Distance > RequiredDistance[CurrentLevel])
   UltrasonicScore -= (Distance - RequiredDistance[CurrentLevel]);
   else  UltrasonicScore -= (RequiredDistance[CurrentLevel] - Distance);

}

 #endif

