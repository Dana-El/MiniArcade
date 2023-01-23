
_StartTarget:

;TargetGame.c,19 :: 		void StartTarget(){
;TargetGame.c,20 :: 		trisb = trisb & 0x7f; // choose RB7 as output
	MOVLW      127
	ANDWF      TRISB+0, 1
;TargetGame.c,21 :: 		trisb = trisb & 0xfe; //set rb0 output correct led)
	MOVLW      254
	ANDWF      TRISB+0, 1
;TargetGame.c,23 :: 		while(1){
L_StartTarget0:
;TargetGame.c,25 :: 		rotate_90();  //rotate the motor to 90 degrees
	CALL       _rotate_90+0
;TargetGame.c,26 :: 		reading_before = ADC_read();//check before to measure ambient light intensity without laser
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _reading_before+0
	MOVF       R0+1, 0
	MOVWF      _reading_before+1
;TargetGame.c,27 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_StartTarget2:
	DECFSZ     R13+0, 1
	GOTO       L_StartTarget2
	DECFSZ     R12+0, 1
	GOTO       L_StartTarget2
	DECFSZ     R11+0, 1
	GOTO       L_StartTarget2
	NOP
;TargetGame.c,28 :: 		checkLDR();   //check LDR if the value is higher (laser pointed at it) and if so set an led
	CALL       _checkLDR+0
;TargetGame.c,29 :: 		rotate_180();
	CALL       _rotate_180+0
;TargetGame.c,30 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_StartTarget3:
	DECFSZ     R13+0, 1
	GOTO       L_StartTarget3
	DECFSZ     R12+0, 1
	GOTO       L_StartTarget3
	DECFSZ     R11+0, 1
	GOTO       L_StartTarget3
	NOP
;TargetGame.c,31 :: 		rotate_90();
	CALL       _rotate_90+0
;TargetGame.c,32 :: 		reading_before = ADC_read();//check before to measure ambient light intensity without laser
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _reading_before+0
	MOVF       R0+1, 0
	MOVWF      _reading_before+1
;TargetGame.c,33 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_StartTarget4:
	DECFSZ     R13+0, 1
	GOTO       L_StartTarget4
	DECFSZ     R12+0, 1
	GOTO       L_StartTarget4
	DECFSZ     R11+0, 1
	GOTO       L_StartTarget4
	NOP
;TargetGame.c,34 :: 		checkLDR(); //check LDR if the value is higher (laser pointed at it) and if so set an led
	CALL       _checkLDR+0
;TargetGame.c,35 :: 		rotate_0();
	CALL       _rotate_0+0
;TargetGame.c,36 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_StartTarget5:
	DECFSZ     R13+0, 1
	GOTO       L_StartTarget5
	DECFSZ     R12+0, 1
	GOTO       L_StartTarget5
	DECFSZ     R11+0, 1
	GOTO       L_StartTarget5
	NOP
;TargetGame.c,37 :: 		}
	GOTO       L_StartTarget0
;TargetGame.c,38 :: 		}
L_end_StartTarget:
	RETURN
; end of _StartTarget

_turnON:

;TargetGame.c,39 :: 		void turnON(unsigned char cnt){
;TargetGame.c,40 :: 		if(cnt>0) return;
	MOVF       FARG_turnON_cnt+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_turnON6
	GOTO       L_end_turnON
L_turnON6:
;TargetGame.c,41 :: 		setCorrectLed;
	BSF        PORTB+0, 0
;TargetGame.c,42 :: 		delay_ms(600);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      23
	MOVWF      R12+0
	MOVLW      106
	MOVWF      R13+0
L_turnON7:
	DECFSZ     R13+0, 1
	GOTO       L_turnON7
	DECFSZ     R12+0, 1
	GOTO       L_turnON7
	DECFSZ     R11+0, 1
	GOTO       L_turnON7
	NOP
;TargetGame.c,43 :: 		clearCorrectLed;
	MOVLW      254
	ANDWF      PORTB+0, 1
;TargetGame.c,45 :: 		}
L_end_turnON:
	RETURN
; end of _turnON

_checkLDR:

;TargetGame.c,46 :: 		void checkLDR(){
;TargetGame.c,48 :: 		ADC_init();
	CALL       _ADC_init+0
;TargetGame.c,49 :: 		reading = ADC_read();
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _reading+0
	MOVF       R0+1, 0
	MOVWF      _reading+1
;TargetGame.c,51 :: 		cnt=0;
	CLRF       _cnt+0
;TargetGame.c,52 :: 		if(reading-100 >reading_before){//if reading has increased above a certain threshold then laser is pointed (target is hit)
	MOVLW      100
	SUBWF      R0+0, 0
	MOVWF      R2+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+1, 0
	SUBWF      _reading_before+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__checkLDR29
	MOVF       R2+0, 0
	SUBWF      _reading_before+0, 0
L__checkLDR29:
	BTFSC      STATUS+0, 0
	GOTO       L_checkLDR8
;TargetGame.c,54 :: 		turnON(cnt);
	MOVF       _cnt+0, 0
	MOVWF      FARG_turnON_cnt+0
	CALL       _turnON+0
;TargetGame.c,55 :: 		cnt++;
	INCF       _cnt+0, 1
;TargetGame.c,56 :: 		}
L_checkLDR8:
;TargetGame.c,57 :: 		}
L_end_checkLDR:
	RETURN
; end of _checkLDR

_ADC_init:

;TargetGame.c,60 :: 		void ADC_init(void){
;TargetGame.c,61 :: 		ADCON0 = 0x41;//  channel 0 (RA0), choose Fosc/16 = 500 Khz, do not go,  turn atd on
	MOVLW      65
	MOVWF      ADCON0+0
;TargetGame.c,62 :: 		ADCON1= 0xCE; // RA0 analog the rest are digital, Fosc/16=500KHz, right justify
	MOVLW      206
	MOVWF      ADCON1+0
;TargetGame.c,63 :: 		TRISA= 0x01;
	MOVLW      1
	MOVWF      TRISA+0
;TargetGame.c,65 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_ADC_read:

;TargetGame.c,66 :: 		unsigned int ADC_read(void){
;TargetGame.c,67 :: 		ADCON0 = ADCON0 | 0x04; //go , and start measuring
	BSF        ADCON0+0, 2
;TargetGame.c,68 :: 		while(ADCON0 & 0x04);    //do nothing while reading is happenning
L_ADC_read9:
	BTFSS      ADCON0+0, 2
	GOTO       L_ADC_read10
	GOTO       L_ADC_read9
L_ADC_read10:
;TargetGame.c,69 :: 		return (ADRESH<<8)|ADRESL; //when you finish reading return reading
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;TargetGame.c,71 :: 		}
L_end_ADC_read:
	RETURN
; end of _ADC_read

_rotate_90:

;TargetGame.c,73 :: 		void rotate_90(){
;TargetGame.c,74 :: 		for(i=0;i<150;i++){
	CLRF       _i+0
L_rotate_9011:
	MOVLW      150
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_rotate_9012
;TargetGame.c,76 :: 		portb = portb| 0x80; //set rb7 for 2 ms = 2000micro second
	BSF        PORTB+0, 7
;TargetGame.c,77 :: 		delay_us(1300);
	MOVLW      4
	MOVWF      R12+0
	MOVLW      95
	MOVWF      R13+0
L_rotate_9014:
	DECFSZ     R13+0, 1
	GOTO       L_rotate_9014
	DECFSZ     R12+0, 1
	GOTO       L_rotate_9014
;TargetGame.c,79 :: 		portb = portb & 0x7f;//reset for 8ms = 8000micro second
	MOVLW      127
	ANDWF      PORTB+0, 1
;TargetGame.c,80 :: 		delay_us(8700);
	MOVLW      23
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_rotate_9015:
	DECFSZ     R13+0, 1
	GOTO       L_rotate_9015
	DECFSZ     R12+0, 1
	GOTO       L_rotate_9015
	NOP
	NOP
;TargetGame.c,74 :: 		for(i=0;i<150;i++){
	INCF       _i+0, 1
;TargetGame.c,82 :: 		}
	GOTO       L_rotate_9011
L_rotate_9012:
;TargetGame.c,83 :: 		}
L_end_rotate_90:
	RETURN
; end of _rotate_90

_rotate_180:

;TargetGame.c,84 :: 		void rotate_180(){
;TargetGame.c,85 :: 		for(i=0;i<150;i++){
	CLRF       _i+0
L_rotate_18016:
	MOVLW      150
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_rotate_18017
;TargetGame.c,87 :: 		portb = portb| 0x80; //set rb7 for 2 ms = 2000micro second
	BSF        PORTB+0, 7
;TargetGame.c,88 :: 		delay_us(2100);
	MOVLW      6
	MOVWF      R12+0
	MOVLW      115
	MOVWF      R13+0
L_rotate_18019:
	DECFSZ     R13+0, 1
	GOTO       L_rotate_18019
	DECFSZ     R12+0, 1
	GOTO       L_rotate_18019
;TargetGame.c,90 :: 		portb = portb & 0x7f;//reset for 8ms = 8000micro second
	MOVLW      127
	ANDWF      PORTB+0, 1
;TargetGame.c,91 :: 		delay_us(7900);
	MOVLW      21
	MOVWF      R12+0
	MOVLW      131
	MOVWF      R13+0
L_rotate_18020:
	DECFSZ     R13+0, 1
	GOTO       L_rotate_18020
	DECFSZ     R12+0, 1
	GOTO       L_rotate_18020
	NOP
	NOP
;TargetGame.c,85 :: 		for(i=0;i<150;i++){
	INCF       _i+0, 1
;TargetGame.c,93 :: 		}
	GOTO       L_rotate_18016
L_rotate_18017:
;TargetGame.c,94 :: 		}
L_end_rotate_180:
	RETURN
; end of _rotate_180

_rotate_0:

;TargetGame.c,95 :: 		void rotate_0(){
;TargetGame.c,96 :: 		for(i=0;i<150;i++){
	CLRF       _i+0
L_rotate_021:
	MOVLW      150
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_rotate_022
;TargetGame.c,98 :: 		portb = portb| 0x80; //set rb7 for 2 ms = 2000micro second
	BSF        PORTB+0, 7
;TargetGame.c,99 :: 		delay_us(400);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      8
	MOVWF      R13+0
L_rotate_024:
	DECFSZ     R13+0, 1
	GOTO       L_rotate_024
	DECFSZ     R12+0, 1
	GOTO       L_rotate_024
	NOP
;TargetGame.c,101 :: 		portb = portb & 0x7f;//reset for 8ms = 8000micro second
	MOVLW      127
	ANDWF      PORTB+0, 1
;TargetGame.c,102 :: 		delay_us(9600);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_rotate_025:
	DECFSZ     R13+0, 1
	GOTO       L_rotate_025
	DECFSZ     R12+0, 1
	GOTO       L_rotate_025
	NOP
;TargetGame.c,96 :: 		for(i=0;i<150;i++){
	INCF       _i+0, 1
;TargetGame.c,104 :: 		}
	GOTO       L_rotate_021
L_rotate_022:
;TargetGame.c,105 :: 		}
L_end_rotate_0:
	RETURN
; end of _rotate_0
