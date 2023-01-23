#ifndef TargetGame
#define TargetGame


void rotate_90();
void rotate_180();
void rotate_0();
void checkLDR();
unsigned int reading;
unsigned int reading_before;
void ADC_init(void);
unsigned int ADC_read(void);
unsigned char i;
unsigned char cnt     =0;
unsigned char HL;//High Low
unsigned int angle;
unsigned char score =0;
void startTarget();

void interrupt(void){

 if(PIR2&0x01){//CCP2 interrupt
   if(HL){ //high
     CCPR2H= angle >>8;
     CCPR2L= angle;
     HL=0;//next time low
     CCP2CON=0x09;//next time Falling edge
     TMR1H=0;
     TMR1L=0;
   }
   else{  //low
     CCPR2H= (40000 - angle) >>8;
     CCPR2L= (40000 - angle);
     CCP2CON=0x08; //next time rising edge
     HL=1; //next time High
     TMR1H=0;
     TMR1L=0;

   }

 PIR2=PIR2&0B11111110;
 }

 }

void startTarget() {

     unsigned char k;
     trisb = trisb & 0x7f; // choose RB7 as output
     //trisb = trisb & 0xfe; //set rb0 output correct led)
     trisc = trisc &0B11111101;
     trisb = trisb |0x01;
     TMR1H=0;
     TMR1L=0;
     HL=1; //start high
     CCP2CON=0x08;//
     T1CON=0x01;//TMR1 On Fosc/4 (inc 0.5uS) with 0 prescaler (TMR1 overflow after 0xFFFF counts ==65535)==> 32.767ms
     INTCON=0b11000000;
     PIE2=PIE2|0x01;// Enable CCP2 interrupts
     CCPR2H=2000>>8;
     CCPR2L=2000;
     portb = portb & 0x7f;

     score =0;
     k=10;
     while(k--){


              rotate_90();  //rotate the motor to 90 degrees
              reading_before = ADC_read();//check before to measure ambient light intensity without laser
              msDelay(600);
              checkLDR();   //check LDR if the value is higher (laser pointed at it) and if so set an led
              rotate_180();
              msDelay(600);
              /*rotate_90();
              reading_before = ADC_read();//check before to measure ambient light intensity without laser
              delay_ms(600);
              checkLDR(); //check LDR if the value is higher (laser pointed at it) and if so set an led
              rotate_0();
              delay_ms(600);   */
     }
     score = score -10;

}
void turnON(unsigned char cnt){
 if(cnt>0) return;
 setCorrectLed;
       msDelay(600);
       clearCorrectLed;
       score=score+10;

}
void checkLDR(){
     unsigned char voltage;

     ADC_init();
     reading = ADC_read();
     voltage = (reading*500)/1023; //get voltage from 0 to 500 (*10^-2 v)
     cnt=0;


     if(reading-100 >reading_before){//if reading has increased above a certain threshold then laser is pointed (target is hit)

       turnON(cnt);
       cnt++;
     }



}


void ADC_init(void){
  ADCON0 = 0x41;//  channel 0 (RA0), choose Fosc/16 = 500 Khz, do not go,  turn atd on
  ADCON1= 0xCE; // RA0 analog the rest are digital, Fosc/16=500KHz, right justify
  TRISA= 0x01;

}
unsigned int ADC_read(void){
  ADCON0 = ADCON0 | 0x04; //go , and start measuring
  while(ADCON0 & 0x04);    //do nothing while reading is happenning
  return (ADRESH<<8)|ADRESL; //when you finish reading return reading

}

void rotate_90(){
     /*
     for(i=0;i<150;i++){
     //generate software pwm for 90 degrees
        portb = portb| 0x80; //set rb7 for 2 ms = 2000micro second
        delay_us(1300);

        portb = portb & 0x7f;//reset for 8ms = 8000micro second
        delay_us(8700);

       }
       */


       angle=2000;
      msDelay(2000);

}
void rotate_180(){
     /*for(i=0;i<150;i++){
     //generate pwm signal for 180 degrees
        portb = portb| 0x80; //set rb7 for 2 ms = 2000micro second
        delay_us(2100);

        portb = portb & 0x7f;//reset for 8ms = 8000micro second
        delay_us(7900);

       }  */


       angle=3700;
      msDelay(2000);

}
void rotate_0(){
     /*for(i=0;i<150;i++){
     //generate pwm signal for 0 degrees
        portb = portb| 0x80; //set rb7 for 2 ms = 2000micro second
        delay_us(400);

        portb = portb & 0x7f;//reset for 8ms = 8000micro second
        delay_us(9600);

       }  */

       angle=490;
      msDelay(2000);
}


#endif