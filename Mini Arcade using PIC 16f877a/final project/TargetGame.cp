#line 1 "D:/aaaapsut/embedded/projects/final project/TargetGame.c"






void rotate_90();
void rotate_180();
void rotate_0();
void checkLDR();
unsigned int reading;
unsigned int reading_before;
void ADC_init(void);
void StartTarget();
unsigned int ADC_read(void);
unsigned char i;
unsigned char cnt =0;

void StartTarget(){
 trisb = trisb & 0x7f;
 trisb = trisb & 0xfe;

 while(1){

 rotate_90();
 reading_before = ADC_read();
 delay_ms(600);
 checkLDR();
 rotate_180();
 delay_ms(600);
 rotate_90();
 reading_before = ADC_read();
 delay_ms(600);
 checkLDR();
 rotate_0();
 delay_ms(600);
 }
}
void turnON(unsigned char cnt){
 if(cnt>0) return;
  PORTB = PORTB | 0x01 ;
 delay_ms(600);
  PORTB = PORTB & 0xfe ;

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
 for(i=0;i<150;i++){

 portb = portb| 0x80;
 delay_us(1300);

 portb = portb & 0x7f;
 delay_us(8700);

 }
}
void rotate_180(){
 for(i=0;i<150;i++){

 portb = portb| 0x80;
 delay_us(2100);

 portb = portb & 0x7f;
 delay_us(7900);

 }
}
void rotate_0(){
 for(i=0;i<150;i++){

 portb = portb| 0x80;
 delay_us(400);

 portb = portb & 0x7f;
 delay_us(9600);

 }
}
