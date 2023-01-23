#ifndef lcdFinal
#define lcdFinal
#include "shared.h"

#define LcdDataBus      PORTD
#define LcdDataBusDirection   TRISD
#define LcdControlBus   PORTB
#define LcdControlBusDirection   TRISB
#define setRsLcd PORTB=PORTB| 0X10
#define clearRsLcd PORTB= PORTB & 0XEF
#define setEnLcd PORTB=PORTB | 0X20
#define clearEnLcd PORTB= PORTB & 0XDF

void cmd(unsigned char a)
{
    clearRsLcd;
    LcdDataBus = a;
    setEnLcd;
    msDelay(5);
    clearEnLcd;
    usDelay(100);
    return;
}

void lcd_init()
{
    msDelay(20);
    LcdControlBusDirection &= 0xcf;  //rb4 -> rs | rb5 -> en
    LcdDataBusDirection = 0x00;
    clearRsLcd;
    clearEnLcd;

    cmd(0x38);//function set: 8 bit mode
    cmd(0x0c);//display on/off:
    cmd(0x01);//clear
    cmd(0x06);//entry mode set: display does not shift, cursor moves to the right
}
void send_data(unsigned char b)
{
    setRsLcd;
    LcdDataBus = b ;
    setEnLcd;
    msDelay(5);
    clearEnLcd;
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
#endif