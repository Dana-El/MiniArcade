#include "simonSays.h"
#include "TargetGame.h"
#include "Ultrasonic.h"
#include "shared.h"
void startGame();
void main() {
   TRISB = TRISB & 0x38; //correct and incorrect , grb leds
   PORTB &= 0X38;
   PORTC &= 0b11000011;
   TRISC |= 0b00111100; //push buttons
   startSimonSays();
   startTarget();
   startUltrasonic();

}
void startGame(){
INTCON = 0X00;
ADCON1 &= 0x06;//PORTA Digital


}