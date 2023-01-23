
_myDelay:

;shared.h,29 :: 		void myDelay(){
;shared.h,32 :: 		for(k=0;k<50;k++){
	CLRF       R1+0
L_myDelay0:
	MOVLW      50
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay1
;shared.h,33 :: 		for(j=0;j<2000;j++){
	CLRF       R2+0
	CLRF       R2+1
L_myDelay3:
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      7
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay69
	MOVLW      208
	SUBWF      R2+0, 0
L__myDelay69:
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay4
;shared.h,34 :: 		k=k; j=j;
;shared.h,33 :: 		for(j=0;j<2000;j++){
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
;shared.h,35 :: 		}
	GOTO       L_myDelay3
L_myDelay4:
;shared.h,32 :: 		for(k=0;k<50;k++){
	INCF       R1+0, 1
;shared.h,36 :: 		}
	GOTO       L_myDelay0
L_myDelay1:
;shared.h,37 :: 		}
L_end_myDelay:
	RETURN
; end of _myDelay

_usDelay:

;shared.h,38 :: 		void usDelay(unsigned int usCnt){
;shared.h,39 :: 		unsigned int us=0;
	CLRF       usDelay_us_L0+0
	CLRF       usDelay_us_L0+1
;shared.h,41 :: 		for(us=0;us<usCnt;us++){
	CLRF       usDelay_us_L0+0
	CLRF       usDelay_us_L0+1
L_usDelay6:
	MOVF       FARG_usDelay_usCnt+1, 0
	SUBWF      usDelay_us_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__usDelay71
	MOVF       FARG_usDelay_usCnt+0, 0
	SUBWF      usDelay_us_L0+0, 0
L__usDelay71:
	BTFSC      STATUS+0, 0
	GOTO       L_usDelay7
;shared.h,42 :: 		asm NOP;//0.5 uS
	NOP
;shared.h,43 :: 		asm NOP;//0.5uS
	NOP
;shared.h,41 :: 		for(us=0;us<usCnt;us++){
	INCF       usDelay_us_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       usDelay_us_L0+1, 1
;shared.h,44 :: 		}
	GOTO       L_usDelay6
L_usDelay7:
;shared.h,46 :: 		}
L_end_usDelay:
	RETURN
; end of _usDelay

_msDelay:

;shared.h,47 :: 		void msDelay(unsigned int msCnt){
;shared.h,48 :: 		unsigned int ms=0;
	CLRF       msDelay_ms_L0+0
	CLRF       msDelay_ms_L0+1
	CLRF       msDelay_cc_L0+0
	CLRF       msDelay_cc_L0+1
;shared.h,50 :: 		for(ms=0;ms<(msCnt);ms++){
	CLRF       msDelay_ms_L0+0
	CLRF       msDelay_ms_L0+1
L_msDelay9:
	MOVF       FARG_msDelay_msCnt+1, 0
	SUBWF      msDelay_ms_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay73
	MOVF       FARG_msDelay_msCnt+0, 0
	SUBWF      msDelay_ms_L0+0, 0
L__msDelay73:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay10
;shared.h,51 :: 		for(cc=0;cc<155;cc++);//1ms
	CLRF       msDelay_cc_L0+0
	CLRF       msDelay_cc_L0+1
L_msDelay12:
	MOVLW      0
	SUBWF      msDelay_cc_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__msDelay74
	MOVLW      155
	SUBWF      msDelay_cc_L0+0, 0
L__msDelay74:
	BTFSC      STATUS+0, 0
	GOTO       L_msDelay13
	INCF       msDelay_cc_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       msDelay_cc_L0+1, 1
	GOTO       L_msDelay12
L_msDelay13:
;shared.h,50 :: 		for(ms=0;ms<(msCnt);ms++){
	INCF       msDelay_ms_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       msDelay_ms_L0+1, 1
;shared.h,52 :: 		}
	GOTO       L_msDelay9
L_msDelay10:
;shared.h,54 :: 		}
L_end_msDelay:
	RETURN
; end of _msDelay

_startSimonSays:

;simonsays.h,26 :: 		void startSimonSays(){
;simonsays.h,27 :: 		initSimonSays();
	CALL       _initSimonSays+0
;simonsays.h,28 :: 		while(CurrentLevel != 0 && CurrentLevel <= MaxLevel){
L_startSimonSays15:
	MOVF       _CurrentLevel+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_startSimonSays16
	MOVF       _CurrentLevel+0, 0
	SUBWF      _MaxLevel+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_startSimonSays16
L__startSimonSays67:
;simonsays.h,29 :: 		setLedsPerLevel();
	CALL       _setLedsPerLevel+0
;simonsays.h,30 :: 		getSequence();
	CALL       _getSequence+0
;simonsays.h,31 :: 		showSequence();
	CALL       _showSequence+0
;simonsays.h,32 :: 		checkSequence();
	CALL       _checkSequence+0
;simonsays.h,33 :: 		}
	GOTO       L_startSimonSays15
L_startSimonSays16:
;simonsays.h,35 :: 		}
L_end_startSimonSays:
	RETURN
; end of _startSimonSays

_initSimonSays:

;simonsays.h,36 :: 		void initSimonSays(){
;simonsays.h,37 :: 		TRISB = TRISB & 0x38; //correct and incorrect , grb leds
	MOVLW      56
	ANDWF      TRISB+0, 1
;simonsays.h,38 :: 		PORTB &= 0X38;
	MOVLW      56
	ANDWF      PORTB+0, 1
;simonsays.h,39 :: 		PORTC &= 0b11000111;
	MOVLW      199
	ANDWF      PORTC+0, 1
;simonsays.h,40 :: 		TRISC |= 0b00111000; //c543 = 1
	MOVLW      56
	IORWF      TRISC+0, 1
;simonsays.h,41 :: 		MaxLevel=40;
	MOVLW      40
	MOVWF      _MaxLevel+0
;simonsays.h,42 :: 		CurrentLevel = 1;
	MOVLW      1
	MOVWF      _CurrentLevel+0
;simonsays.h,43 :: 		}
L_end_initSimonSays:
	RETURN
; end of _initSimonSays

_setLedsPerLevel:

;simonsays.h,46 :: 		void setLedsPerLevel(){
;simonsays.h,47 :: 		LedsPerLevel = CurrentLevel ;
	MOVF       _CurrentLevel+0, 0
	MOVWF      _LedsPerlevel+0
;simonsays.h,48 :: 		}
L_end_setLedsPerLevel:
	RETURN
; end of _setLedsPerLevel

_getSequence:

;simonsays.h,50 :: 		void getSequence(){
;simonsays.h,51 :: 		for( Temp = 0 ; Temp <= (LedsPerLevel-1)/4 + 1 ; Temp++)
	CLRF       _Temp+0
L_getSequence19:
	MOVLW      1
	SUBWF      _LedsPerlevel+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__getSequence79
	MOVF       _Temp+0, 0
	SUBWF      R2+0, 0
L__getSequence79:
	BTFSS      STATUS+0, 0
	GOTO       L_getSequence20
;simonsays.h,52 :: 		SetSequence[(LedsPerLevel-1)/4] = 0x67;// 0110-0111 // Green Red Green Blue <-
	MOVLW      1
	SUBWF      _LedsPerlevel+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDLW      _SetSequence+0
	MOVWF      FSR
	MOVLW      103
	MOVWF      INDF+0
;simonsays.h,51 :: 		for( Temp = 0 ; Temp <= (LedsPerLevel-1)/4 + 1 ; Temp++)
	INCF       _Temp+0, 1
;simonsays.h,52 :: 		SetSequence[(LedsPerLevel-1)/4] = 0x67;// 0110-0111 // Green Red Green Blue <-
	GOTO       L_getSequence19
L_getSequence20:
;simonsays.h,53 :: 		}
L_end_getSequence:
	RETURN
; end of _getSequence

_showSequence:

;simonsays.h,55 :: 		void showSequence(){
;simonsays.h,56 :: 		for(Temp = 1; Temp <= LedsPerLevel; Temp++){
	MOVLW      1
	MOVWF      _Temp+0
L_showSequence22:
	MOVF       _Temp+0, 0
	SUBWF      _LedsPerlevel+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_showSequence23
;simonsays.h,57 :: 		if(Temp % 4 == 1) {TempSequence = SetSequence[(LedsPerLevel-1)/4]; }
	MOVLW      3
	ANDWF      _Temp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_showSequence25
	MOVLW      1
	SUBWF      _LedsPerlevel+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDLW      _SetSequence+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _TempSequence+0
	GOTO       L_showSequence26
L_showSequence25:
;simonsays.h,58 :: 		else { TempSequence = TempSequence >> 2; }
	RRF        _TempSequence+0, 1
	BCF        _TempSequence+0, 7
	RRF        _TempSequence+0, 1
	BCF        _TempSequence+0, 7
L_showSequence26:
;simonsays.h,59 :: 		LedNumber = TempSequence & 0x03;
	MOVLW      3
	ANDWF      _TempSequence+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _LedNumber+0
;simonsays.h,60 :: 		if(LedNumber == 1) setGreenLed;
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_showSequence27
	BSF        PORTB+0, 0
	GOTO       L_showSequence28
L_showSequence27:
;simonsays.h,61 :: 		else if(LedNumber == 2) setRedLed;
	MOVF       _LedNumber+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_showSequence29
	BSF        PORTB+0, 1
	GOTO       L_showSequence30
L_showSequence29:
;simonsays.h,62 :: 		else if(LedNumber == 3) setBlueLed;
	MOVF       _LedNumber+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_showSequence31
	BSF        PORTB+0, 2
L_showSequence31:
L_showSequence30:
L_showSequence28:
;simonsays.h,63 :: 		myDelay();
	CALL       _myDelay+0
;simonsays.h,64 :: 		clearLeds;
	MOVLW      253
	ANDWF      PORTB+0, 1
	MOVLW      254
	ANDWF      PORTB+0, 1
	MOVLW      251
	ANDWF      PORTB+0, 1
;simonsays.h,65 :: 		myDelay();
	CALL       _myDelay+0
;simonsays.h,56 :: 		for(Temp = 1; Temp <= LedsPerLevel; Temp++){
	INCF       _Temp+0, 1
;simonsays.h,67 :: 		}
	GOTO       L_showSequence22
L_showSequence23:
;simonsays.h,69 :: 		}
L_end_showSequence:
	RETURN
; end of _showSequence

_userInput:

;simonsays.h,70 :: 		unsigned char userInput(){
;simonsays.h,71 :: 		while(1){
L_userInput32:
;simonsays.h,72 :: 		if(pressedGreenLed) {setGreenLed; myDelay(); clearGreenLed; return 0x01;}
	BTFSS      PORTC+0, 3
	GOTO       L_userInput34
	BSF        PORTB+0, 0
	CALL       _myDelay+0
	MOVLW      254
	ANDWF      PORTB+0, 1
	MOVLW      1
	MOVWF      R0+0
	GOTO       L_end_userInput
L_userInput34:
;simonsays.h,73 :: 		if(pressedRedLed) {setRedLed;  myDelay(); clearRedLed; return 0x02;}
	BTFSS      PORTC+0, 4
	GOTO       L_userInput35
	BSF        PORTB+0, 1
	CALL       _myDelay+0
	MOVLW      253
	ANDWF      PORTB+0, 1
	MOVLW      2
	MOVWF      R0+0
	GOTO       L_end_userInput
L_userInput35:
;simonsays.h,74 :: 		if(pressedBlueLed) {setBlueLed;  myDelay(); clearBlueLed; return 0x03; }
	BTFSS      PORTC+0, 5
	GOTO       L_userInput36
	BSF        PORTB+0, 2
	CALL       _myDelay+0
	MOVLW      251
	ANDWF      PORTB+0, 1
	MOVLW      3
	MOVWF      R0+0
	GOTO       L_end_userInput
L_userInput36:
;simonsays.h,76 :: 		}
	GOTO       L_userInput32
;simonsays.h,78 :: 		}
L_end_userInput:
	RETURN
; end of _userInput

_checkSequence:

;simonsays.h,80 :: 		void checkSequence(){
;simonsays.h,81 :: 		unsigned char Correct = 1;    // replace with TempSequence to use less variables
	MOVLW      1
	MOVWF      checkSequence_Correct_L0+0
;simonsays.h,82 :: 		for(Temp = 1; Temp <= LedsPerLevel; Temp++){
	MOVLW      1
	MOVWF      _Temp+0
L_checkSequence37:
	MOVF       _Temp+0, 0
	SUBWF      _LedsPerlevel+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_checkSequence38
;simonsays.h,83 :: 		if(Temp % 4 == 1) TempSequence = SetSequence[(LedsPerLevel-1)/4];
	MOVLW      3
	ANDWF      _Temp+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_checkSequence40
	MOVLW      1
	SUBWF      _LedsPerlevel+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDLW      _SetSequence+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      _TempSequence+0
	GOTO       L_checkSequence41
L_checkSequence40:
;simonsays.h,84 :: 		else TempSequence = TempSequence >> 2;
	RRF        _TempSequence+0, 1
	BCF        _TempSequence+0, 7
	RRF        _TempSequence+0, 1
	BCF        _TempSequence+0, 7
L_checkSequence41:
;simonsays.h,85 :: 		UserSequence = userInput();
	CALL       _userInput+0
	MOVF       R0+0, 0
	MOVWF      _UserSequence+0
;simonsays.h,86 :: 		LedNumber = TempSequence & 0x03;
	MOVLW      3
	ANDWF      _TempSequence+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      _LedNumber+0
;simonsays.h,87 :: 		if(LedNumber != UserSequence) { Correct = 0 ; break; }
	MOVF       R2+0, 0
	XORWF      R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkSequence42
	CLRF       checkSequence_Correct_L0+0
	GOTO       L_checkSequence38
L_checkSequence42:
;simonsays.h,82 :: 		for(Temp = 1; Temp <= LedsPerLevel; Temp++){
	INCF       _Temp+0, 1
;simonsays.h,90 :: 		}
	GOTO       L_checkSequence37
L_checkSequence38:
;simonsays.h,91 :: 		if(Correct) { correctSequence();}
	MOVF       checkSequence_Correct_L0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_checkSequence43
	CALL       _correctSequence+0
	GOTO       L_checkSequence44
L_checkSequence43:
;simonsays.h,92 :: 		else  {incorrectSequence();}
	CALL       _incorrectSequence+0
L_checkSequence44:
;simonsays.h,93 :: 		}
L_end_checkSequence:
	RETURN
; end of _checkSequence

_correctSequence:

;simonsays.h,94 :: 		void correctSequence(){
;simonsays.h,96 :: 		CurrentLevel++;
	INCF       _CurrentLevel+0, 1
;simonsays.h,97 :: 		setCorrectLed;
	BSF        PORTB+0, 7
;simonsays.h,98 :: 		myDelay();
	CALL       _myDelay+0
;simonsays.h,99 :: 		clearCorrectLed;
	MOVLW      127
	ANDWF      PORTB+0, 1
;simonsays.h,101 :: 		}
L_end_correctSequence:
	RETURN
; end of _correctSequence

_incorrectSequence:

;simonsays.h,102 :: 		void incorrectSequence(){
;simonsays.h,103 :: 		setIncorrectLed;
	BSF        PORTB+0, 6
;simonsays.h,104 :: 		myDelay();
	CALL       _myDelay+0
;simonsays.h,105 :: 		clearIncorrectLed;
	MOVLW      191
	ANDWF      PORTB+0, 1
;simonsays.h,106 :: 		CurrentLevel = 0;
	CLRF       _CurrentLevel+0
;simonsays.h,107 :: 		}
L_end_incorrectSequence:
	RETURN
; end of _incorrectSequence

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;targetgame.h,20 :: 		void interrupt(void){
;targetgame.h,22 :: 		if(PIR2&0x01){//CCP2 interrupt
	BTFSS      PIR2+0, 0
	GOTO       L_interrupt45
;targetgame.h,23 :: 		if(HL){ //high
	MOVF       _HL+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt46
;targetgame.h,24 :: 		CCPR2H= angle >>8;
	MOVF       _angle+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      CCPR2H+0
;targetgame.h,25 :: 		CCPR2L= angle;
	MOVF       _angle+0, 0
	MOVWF      CCPR2L+0
;targetgame.h,26 :: 		HL=0;//next time low
	CLRF       _HL+0
;targetgame.h,27 :: 		CCP2CON=0x09;//next time Falling edge
	MOVLW      9
	MOVWF      CCP2CON+0
;targetgame.h,28 :: 		TMR1H=0;
	CLRF       TMR1H+0
;targetgame.h,29 :: 		TMR1L=0;
	CLRF       TMR1L+0
;targetgame.h,30 :: 		}
	GOTO       L_interrupt47
L_interrupt46:
;targetgame.h,32 :: 		CCPR2H= (40000 - angle) >>8;
	MOVF       _angle+0, 0
	SUBLW      64
	MOVWF      R3+0
	MOVF       _angle+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBLW      156
	MOVWF      R3+1
	MOVF       R3+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	MOVWF      CCPR2H+0
;targetgame.h,33 :: 		CCPR2L= (40000 - angle);
	MOVF       R3+0, 0
	MOVWF      CCPR2L+0
;targetgame.h,34 :: 		CCP2CON=0x08; //next time rising edge
	MOVLW      8
	MOVWF      CCP2CON+0
;targetgame.h,35 :: 		HL=1; //next time High
	MOVLW      1
	MOVWF      _HL+0
;targetgame.h,36 :: 		TMR1H=0;
	CLRF       TMR1H+0
;targetgame.h,37 :: 		TMR1L=0;
	CLRF       TMR1L+0
;targetgame.h,39 :: 		}
L_interrupt47:
;targetgame.h,41 :: 		PIR2=PIR2&0B11111110;
	MOVLW      254
	ANDWF      PIR2+0, 1
;targetgame.h,42 :: 		}
L_interrupt45:
;targetgame.h,44 :: 		}
L_end_interrupt:
L__interrupt86:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_startTarget:

;targetgame.h,46 :: 		void startTarget() {
;targetgame.h,49 :: 		trisb = trisb & 0x7f; // choose RB7 as output
	MOVLW      127
	ANDWF      TRISB+0, 1
;targetgame.h,51 :: 		trisc = trisc &0B11111101;
	MOVLW      253
	ANDWF      TRISC+0, 1
;targetgame.h,52 :: 		trisb = trisb |0x01;
	BSF        TRISB+0, 0
;targetgame.h,53 :: 		TMR1H=0;
	CLRF       TMR1H+0
;targetgame.h,54 :: 		TMR1L=0;
	CLRF       TMR1L+0
;targetgame.h,55 :: 		HL=1; //start high
	MOVLW      1
	MOVWF      _HL+0
;targetgame.h,56 :: 		CCP2CON=0x08;//
	MOVLW      8
	MOVWF      CCP2CON+0
;targetgame.h,57 :: 		T1CON=0x01;//TMR1 On Fosc/4 (inc 0.5uS) with 0 prescaler (TMR1 overflow after 0xFFFF counts ==65535)==> 32.767ms
	MOVLW      1
	MOVWF      T1CON+0
;targetgame.h,58 :: 		INTCON=0b11000000;
	MOVLW      192
	MOVWF      INTCON+0
;targetgame.h,59 :: 		PIE2=PIE2|0x01;// Enable CCP2 interrupts
	BSF        PIE2+0, 0
;targetgame.h,60 :: 		CCPR2H=2000>>8;
	MOVLW      7
	MOVWF      CCPR2H+0
;targetgame.h,61 :: 		CCPR2L=2000;
	MOVLW      208
	MOVWF      CCPR2L+0
;targetgame.h,62 :: 		portb = portb & 0x7f;
	MOVLW      127
	ANDWF      PORTB+0, 1
;targetgame.h,64 :: 		score =0;
	CLRF       _score+0
;targetgame.h,65 :: 		k=10;
	MOVLW      10
	MOVWF      startTarget_k_L0+0
;targetgame.h,66 :: 		while(k--){
L_startTarget48:
	MOVF       startTarget_k_L0+0, 0
	MOVWF      R0+0
	DECF       startTarget_k_L0+0, 1
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_startTarget49
;targetgame.h,69 :: 		rotate_90();  //rotate the motor to 90 degrees
	CALL       _rotate_90+0
;targetgame.h,70 :: 		reading_before = ADC_read();//check before to measure ambient light intensity without laser
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _reading_before+0
	MOVF       R0+1, 0
	MOVWF      _reading_before+1
;targetgame.h,71 :: 		msDelay(600);
	MOVLW      88
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      2
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;targetgame.h,72 :: 		checkLDR();   //check LDR if the value is higher (laser pointed at it) and if so set an led
	CALL       _checkLDR+0
;targetgame.h,73 :: 		rotate_180();
	CALL       _rotate_180+0
;targetgame.h,74 :: 		msDelay(600);
	MOVLW      88
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      2
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;targetgame.h,81 :: 		}
	GOTO       L_startTarget48
L_startTarget49:
;targetgame.h,82 :: 		score = score -10;
	MOVLW      10
	SUBWF      _score+0, 1
;targetgame.h,84 :: 		}
L_end_startTarget:
	RETURN
; end of _startTarget

_turnON:

;targetgame.h,85 :: 		void turnON(unsigned char cnt){
;targetgame.h,86 :: 		if(cnt>0) return;
	MOVF       FARG_turnON_cnt+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_turnON50
	GOTO       L_end_turnON
L_turnON50:
;targetgame.h,87 :: 		setCorrectLed;
	BSF        PORTB+0, 7
;targetgame.h,88 :: 		msDelay(600);
	MOVLW      88
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      2
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;targetgame.h,89 :: 		clearCorrectLed;
	MOVLW      127
	ANDWF      PORTB+0, 1
;targetgame.h,90 :: 		score=score+10;
	MOVLW      10
	ADDWF      _score+0, 1
;targetgame.h,92 :: 		}
L_end_turnON:
	RETURN
; end of _turnON

_checkLDR:

;targetgame.h,93 :: 		void checkLDR(){
;targetgame.h,96 :: 		ADC_init();
	CALL       _ADC_init+0
;targetgame.h,97 :: 		reading = ADC_read();
	CALL       _ADC_read+0
	MOVF       R0+0, 0
	MOVWF      _reading+0
	MOVF       R0+1, 0
	MOVWF      _reading+1
;targetgame.h,99 :: 		cnt=0;
	CLRF       _cnt+0
;targetgame.h,102 :: 		if(reading-100 >reading_before){//if reading has increased above a certain threshold then laser is pointed (target is hit)
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
	GOTO       L__checkLDR90
	MOVF       R2+0, 0
	SUBWF      _reading_before+0, 0
L__checkLDR90:
	BTFSC      STATUS+0, 0
	GOTO       L_checkLDR51
;targetgame.h,104 :: 		turnON(cnt);
	MOVF       _cnt+0, 0
	MOVWF      FARG_turnON_cnt+0
	CALL       _turnON+0
;targetgame.h,105 :: 		cnt++;
	INCF       _cnt+0, 1
;targetgame.h,106 :: 		}
L_checkLDR51:
;targetgame.h,110 :: 		}
L_end_checkLDR:
	RETURN
; end of _checkLDR

_ADC_init:

;targetgame.h,113 :: 		void ADC_init(void){
;targetgame.h,114 :: 		ADCON0 = 0x41;//  channel 0 (RA0), choose Fosc/16 = 500 Khz, do not go,  turn atd on
	MOVLW      65
	MOVWF      ADCON0+0
;targetgame.h,115 :: 		ADCON1= 0xCE; // RA0 analog the rest are digital, Fosc/16=500KHz, right justify
	MOVLW      206
	MOVWF      ADCON1+0
;targetgame.h,116 :: 		TRISA= 0x01;
	MOVLW      1
	MOVWF      TRISA+0
;targetgame.h,118 :: 		}
L_end_ADC_init:
	RETURN
; end of _ADC_init

_ADC_read:

;targetgame.h,119 :: 		unsigned int ADC_read(void){
;targetgame.h,120 :: 		ADCON0 = ADCON0 | 0x04; //go , and start measuring
	BSF        ADCON0+0, 2
;targetgame.h,121 :: 		while(ADCON0 & 0x04);    //do nothing while reading is happenning
L_ADC_read52:
	BTFSS      ADCON0+0, 2
	GOTO       L_ADC_read53
	GOTO       L_ADC_read52
L_ADC_read53:
;targetgame.h,122 :: 		return (ADRESH<<8)|ADRESL; //when you finish reading return reading
	MOVF       ADRESH+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       ADRESL+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
;targetgame.h,124 :: 		}
L_end_ADC_read:
	RETURN
; end of _ADC_read

_rotate_90:

;targetgame.h,126 :: 		void rotate_90(){
;targetgame.h,140 :: 		angle=2000;
	MOVLW      208
	MOVWF      _angle+0
	MOVLW      7
	MOVWF      _angle+1
;targetgame.h,141 :: 		msDelay(2000);
	MOVLW      208
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      7
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;targetgame.h,143 :: 		}
L_end_rotate_90:
	RETURN
; end of _rotate_90

_rotate_180:

;targetgame.h,144 :: 		void rotate_180(){
;targetgame.h,156 :: 		angle=3700;
	MOVLW      116
	MOVWF      _angle+0
	MOVLW      14
	MOVWF      _angle+1
;targetgame.h,157 :: 		msDelay(2000);
	MOVLW      208
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      7
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;targetgame.h,159 :: 		}
L_end_rotate_180:
	RETURN
; end of _rotate_180

_rotate_0:

;targetgame.h,160 :: 		void rotate_0(){
;targetgame.h,171 :: 		angle=490;
	MOVLW      234
	MOVWF      _angle+0
	MOVLW      1
	MOVWF      _angle+1
;targetgame.h,172 :: 		msDelay(2000);
	MOVLW      208
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      7
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;targetgame.h,173 :: 		}
L_end_rotate_0:
	RETURN
; end of _rotate_0

_cmd:

;lcdfinal.h,14 :: 		void cmd(unsigned char a)
;lcdfinal.h,16 :: 		clearRsLcd;
	MOVLW      239
	ANDWF      PORTB+0, 1
;lcdfinal.h,17 :: 		LcdDataBus = a;
	MOVF       FARG_cmd_a+0, 0
	MOVWF      PORTD+0
;lcdfinal.h,18 :: 		setEnLcd;
	BSF        PORTB+0, 5
;lcdfinal.h,19 :: 		msDelay(5);
	MOVLW      5
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;lcdfinal.h,20 :: 		clearEnLcd;
	MOVLW      223
	ANDWF      PORTB+0, 1
;lcdfinal.h,21 :: 		usDelay(100);
	MOVLW      100
	MOVWF      FARG_usDelay_usCnt+0
	MOVLW      0
	MOVWF      FARG_usDelay_usCnt+1
	CALL       _usDelay+0
;lcdfinal.h,22 :: 		return;
;lcdfinal.h,23 :: 		}
L_end_cmd:
	RETURN
; end of _cmd

_lcd_init:

;lcdfinal.h,25 :: 		void lcd_init()
;lcdfinal.h,27 :: 		msDelay(20);
	MOVLW      20
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;lcdfinal.h,28 :: 		LcdControlBusDirection &= 0xcf;  //rb4 -> rs | rb5 -> en
	MOVLW      207
	ANDWF      TRISB+0, 1
;lcdfinal.h,29 :: 		LcdDataBusDirection = 0x00;
	CLRF       TRISD+0
;lcdfinal.h,30 :: 		clearRsLcd;
	MOVLW      239
	ANDWF      PORTB+0, 1
;lcdfinal.h,31 :: 		clearEnLcd;
	MOVLW      223
	ANDWF      PORTB+0, 1
;lcdfinal.h,33 :: 		cmd(0x38);//function set: 8 bit mode
	MOVLW      56
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;lcdfinal.h,34 :: 		cmd(0x0c);//display on/off:
	MOVLW      12
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;lcdfinal.h,35 :: 		cmd(0x01);//clear
	MOVLW      1
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;lcdfinal.h,36 :: 		cmd(0x06);//entry mode set: display does not shift, cursor moves to the right
	MOVLW      6
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;lcdfinal.h,37 :: 		}
L_end_lcd_init:
	RETURN
; end of _lcd_init

_send_data:

;lcdfinal.h,38 :: 		void send_data(unsigned char b)
;lcdfinal.h,40 :: 		setRsLcd;
	BSF        PORTB+0, 4
;lcdfinal.h,41 :: 		LcdDataBus = b ;
	MOVF       FARG_send_data_b+0, 0
	MOVWF      PORTD+0
;lcdfinal.h,42 :: 		setEnLcd;
	BSF        PORTB+0, 5
;lcdfinal.h,43 :: 		msDelay(5);
	MOVLW      5
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      0
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;lcdfinal.h,44 :: 		clearEnLcd;
	MOVLW      223
	ANDWF      PORTB+0, 1
;lcdfinal.h,45 :: 		usDelay(100);
	MOVLW      100
	MOVWF      FARG_usDelay_usCnt+0
	MOVLW      0
	MOVWF      FARG_usDelay_usCnt+1
	CALL       _usDelay+0
;lcdfinal.h,46 :: 		}
L_end_send_data:
	RETURN
; end of _send_data

_print_string:

;lcdfinal.h,47 :: 		void print_string(unsigned char str[]){
;lcdfinal.h,48 :: 		unsigned int i=0;
	CLRF       print_string_i_L0+0
	CLRF       print_string_i_L0+1
;lcdfinal.h,49 :: 		while(str[i] != '\0'){
L_print_string54:
	MOVF       print_string_i_L0+0, 0
	ADDWF      FARG_print_string_str+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_print_string55
;lcdfinal.h,50 :: 		if(i==15) cmd(0xc0) ;
	MOVLW      0
	XORWF      print_string_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__print_string100
	MOVLW      15
	XORWF      print_string_i_L0+0, 0
L__print_string100:
	BTFSS      STATUS+0, 2
	GOTO       L_print_string56
	MOVLW      192
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
L_print_string56:
;lcdfinal.h,51 :: 		if(i==29) cmd(0x80);
	MOVLW      0
	XORWF      print_string_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__print_string101
	MOVLW      29
	XORWF      print_string_i_L0+0, 0
L__print_string101:
	BTFSS      STATUS+0, 2
	GOTO       L_print_string57
	MOVLW      128
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
L_print_string57:
;lcdfinal.h,53 :: 		send_data(str[i]);
	MOVF       print_string_i_L0+0, 0
	ADDWF      FARG_print_string_str+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_send_data_b+0
	CALL       _send_data+0
;lcdfinal.h,54 :: 		i++;
	INCF       print_string_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       print_string_i_L0+1, 1
;lcdfinal.h,55 :: 		}
	GOTO       L_print_string54
L_print_string55:
;lcdfinal.h,56 :: 		}
L_end_print_string:
	RETURN
; end of _print_string

_startUltrasonic:

;ultrasonic.h,17 :: 		void startUltrasonic(){
;ultrasonic.h,20 :: 		lcd_init();
	CALL       _lcd_init+0
;ultrasonic.h,21 :: 		cmd(0X01);
	MOVLW      1
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;ultrasonic.h,22 :: 		init_sonar();
	CALL       _init_sonar+0
;ultrasonic.h,24 :: 		while(CurrentLevel <= UltrasonicMaxLevel){
L_startUltrasonic58:
	MOVF       _CurrentLevel+0, 0
	SUBWF      _UltrasonicMaxLevel+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_startUltrasonic59
;ultrasonic.h,25 :: 		cmd(0X01);
	MOVLW      1
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;ultrasonic.h,26 :: 		print_string("Required ");
	MOVLW      ?lstr1_FinalProject+0
	MOVWF      FARG_print_string_str+0
	CALL       _print_string+0
;ultrasonic.h,27 :: 		send_data(0x30 + RequiredDistance[CurrentLevel]);
	MOVF       _CurrentLevel+0, 0
	ADDLW      _RequiredDistance+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      48
	MOVWF      FARG_send_data_b+0
	CALL       _send_data+0
;ultrasonic.h,28 :: 		msDelay(5000);
	MOVLW      136
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      19
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;ultrasonic.h,29 :: 		read_sonar();
	CALL       _read_sonar+0
;ultrasonic.h,30 :: 		cmd(0X01);
	MOVLW      1
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;ultrasonic.h,31 :: 		print_string("Read ");
	MOVLW      ?lstr2_FinalProject+0
	MOVWF      FARG_print_string_str+0
	CALL       _print_string+0
;ultrasonic.h,32 :: 		send_data(0x30 + Distance);
	MOVF       _Distance+0, 0
	ADDLW      48
	MOVWF      FARG_send_data_b+0
	CALL       _send_data+0
;ultrasonic.h,33 :: 		msDelay(1000);
	MOVLW      232
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      3
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;ultrasonic.h,34 :: 		}
	GOTO       L_startUltrasonic58
L_startUltrasonic59:
;ultrasonic.h,35 :: 		cmd(0X01);
	MOVLW      1
	MOVWF      FARG_cmd_a+0
	CALL       _cmd+0
;ultrasonic.h,36 :: 		print_string("Game Completed");
	MOVLW      ?lstr3_FinalProject+0
	MOVWF      FARG_print_string_str+0
	CALL       _print_string+0
;ultrasonic.h,37 :: 		msDelay(300);
	MOVLW      44
	MOVWF      FARG_msDelay_msCnt+0
	MOVLW      1
	MOVWF      FARG_msDelay_msCnt+1
	CALL       _msDelay+0
;ultrasonic.h,38 :: 		}
L_end_startUltrasonic:
	RETURN
; end of _startUltrasonic

_init_sonar:

;ultrasonic.h,39 :: 		void init_sonar(void){
;ultrasonic.h,41 :: 		CurrentLevel=1;
	MOVLW      1
	MOVWF      _CurrentLevel+0
;ultrasonic.h,42 :: 		UltrasonicScore = 40;
	MOVLW      40
	MOVWF      _UltrasonicScore+0
;ultrasonic.h,43 :: 		T1counts=0;
	CLRF       _T1counts+0
	CLRF       _T1counts+1
	CLRF       _T1counts+2
	CLRF       _T1counts+3
;ultrasonic.h,44 :: 		T1time=0;
	CLRF       _T1time+0
	CLRF       _T1time+1
	CLRF       _T1time+2
	CLRF       _T1time+3
;ultrasonic.h,45 :: 		Distance=0;
	CLRF       _Distance+0
	CLRF       _Distance+1
	CLRF       _Distance+2
	CLRF       _Distance+3
;ultrasonic.h,46 :: 		TMR1H=0;
	CLRF       TMR1H+0
;ultrasonic.h,47 :: 		TMR1L=0;
	CLRF       TMR1L+0
;ultrasonic.h,48 :: 		TRISA &= 0b1111101; //RA1 for trigger output
	MOVLW      125
	ANDWF      TRISA+0, 1
;ultrasonic.h,49 :: 		TRISA |= 0b00000100;//RA2 for echo input
	BSF        TRISA+0, 2
;ultrasonic.h,50 :: 		ADCON1= 0xCE; // RA0 analog the rest are digital, Fosc/16=500KHz, right justify
	MOVLW      206
	MOVWF      ADCON1+0
;ultrasonic.h,51 :: 		T1CON=0x18;//TMR1 OFF,  Fosc/4 (inc 1uS) with 1:2 prescaler (TMR1 overflow after 0xFFFF counts ==65536)==> 65.536ms
	MOVLW      24
	MOVWF      T1CON+0
;ultrasonic.h,52 :: 		}
L_end_init_sonar:
	RETURN
; end of _init_sonar

_read_sonar:

;ultrasonic.h,53 :: 		void read_sonar(void){
;ultrasonic.h,54 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_read_sonar60:
	DECFSZ     R13+0, 1
	GOTO       L_read_sonar60
	DECFSZ     R12+0, 1
	GOTO       L_read_sonar60
	DECFSZ     R11+0, 1
	GOTO       L_read_sonar60
	NOP
;ultrasonic.h,56 :: 		CurrentLevel++;
	INCF       _CurrentLevel+0, 1
;ultrasonic.h,57 :: 		TMR1H=0;
	CLRF       TMR1H+0
;ultrasonic.h,58 :: 		TMR1L=0;
	CLRF       TMR1L+0
;ultrasonic.h,59 :: 		PORTA |= 0x02;//Trigger the ultrasonic sensor (RA1 connected to trigger)
	BSF        PORTA+0, 1
;ultrasonic.h,60 :: 		usDelay(10);//keep trigger for 10uS
	MOVLW      10
	MOVWF      FARG_usDelay_usCnt+0
	MOVLW      0
	MOVWF      FARG_usDelay_usCnt+1
	CALL       _usDelay+0
;ultrasonic.h,61 :: 		PORTA &= 0b11111101;//Remove trigger
	MOVLW      253
	ANDWF      PORTA+0, 1
;ultrasonic.h,62 :: 		while(!(PORTA&0x04)); //stuck here
L_read_sonar61:
	BTFSC      PORTA+0, 2
	GOTO       L_read_sonar62
	GOTO       L_read_sonar61
L_read_sonar62:
;ultrasonic.h,63 :: 		T1CON=0x19;//TMR1 ON,  Fosc/4 (inc 1uS) with 1:2 prescaler (TMR1 overflow after 0xFFFF counts ==65536)==> 65.536ms
	MOVLW      25
	MOVWF      T1CON+0
;ultrasonic.h,64 :: 		while(PORTA&0x04);
L_read_sonar63:
	BTFSS      PORTA+0, 2
	GOTO       L_read_sonar64
	GOTO       L_read_sonar63
L_read_sonar64:
;ultrasonic.h,65 :: 		T1CON=0x18;//TMR1 OFF,  Fosc/4 (inc 1uS) with 1:1 prescaler (TMR1 overflow after 0xFFFF counts ==65536)==> 65.536ms
	MOVLW      24
	MOVWF      T1CON+0
;ultrasonic.h,66 :: 		T1counts=((TMR1H<<8)|TMR1L);
	CLRF       _T1counts+3
	MOVF       TMR1H+1, 0
	MOVWF      _T1counts+2
	MOVF       TMR1H+0, 0
	MOVWF      _T1counts+1
	CLRF       _T1counts+0
	MOVF       TMR1L+0, 0
	IORWF      _T1counts+0, 1
	MOVLW      0
	IORWF      _T1counts+1, 1
	MOVLW      0
	MOVWF      _T1counts+2
	MOVWF      _T1counts+3
;ultrasonic.h,67 :: 		T1time=T1counts;//in microseconds
	MOVF       _T1counts+0, 0
	MOVWF      _T1time+0
	MOVF       _T1counts+1, 0
	MOVWF      _T1time+1
	MOVF       _T1counts+2, 0
	MOVWF      _T1time+2
	MOVF       _T1counts+3, 0
	MOVWF      _T1time+3
;ultrasonic.h,68 :: 		Distance=((T1time*34)/(1000))/2; //in cm, shift left twice to divide by 2
	MOVF       _T1counts+0, 0
	MOVWF      R0+0
	MOVF       _T1counts+1, 0
	MOVWF      R0+1
	MOVF       _T1counts+2, 0
	MOVWF      R0+2
	MOVF       _T1counts+3, 0
	MOVWF      R0+3
	MOVLW      34
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      R5+0
	MOVF       R0+1, 0
	MOVWF      R5+1
	MOVF       R0+2, 0
	MOVWF      R5+2
	MOVF       R0+3, 0
	MOVWF      R5+3
	RRF        R5+3, 1
	RRF        R5+2, 1
	RRF        R5+1, 1
	RRF        R5+0, 1
	BCF        R5+3, 7
	MOVF       R5+0, 0
	MOVWF      _Distance+0
	MOVF       R5+1, 0
	MOVWF      _Distance+1
	MOVF       R5+2, 0
	MOVWF      _Distance+2
	MOVF       R5+3, 0
	MOVWF      _Distance+3
;ultrasonic.h,72 :: 		if( Distance > RequiredDistance[CurrentLevel])
	MOVF       _CurrentLevel+0, 0
	ADDLW      _RequiredDistance+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R5+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar105
	MOVF       R5+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar105
	MOVF       R5+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__read_sonar105
	MOVF       R5+0, 0
	SUBWF      R1+0, 0
L__read_sonar105:
	BTFSC      STATUS+0, 0
	GOTO       L_read_sonar65
;ultrasonic.h,73 :: 		UltrasonicScore -= (Distance - RequiredDistance[CurrentLevel]);
	MOVF       _CurrentLevel+0, 0
	ADDLW      _RequiredDistance+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      _Distance+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      _UltrasonicScore+0, 1
	GOTO       L_read_sonar66
L_read_sonar65:
;ultrasonic.h,74 :: 		else  UltrasonicScore -= (RequiredDistance[CurrentLevel] - Distance);
	MOVF       _CurrentLevel+0, 0
	ADDLW      _RequiredDistance+0
	MOVWF      FSR
	MOVF       _Distance+0, 0
	SUBWF      INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	SUBWF      _UltrasonicScore+0, 1
L_read_sonar66:
;ultrasonic.h,76 :: 		}
L_end_read_sonar:
	RETURN
; end of _read_sonar

_main:

;FinalProject.c,6 :: 		void main() {
;FinalProject.c,7 :: 		TRISB = TRISB & 0x38; //correct and incorrect , grb leds
	MOVLW      56
	ANDWF      TRISB+0, 1
;FinalProject.c,8 :: 		PORTB &= 0X38;
	MOVLW      56
	ANDWF      PORTB+0, 1
;FinalProject.c,9 :: 		PORTC &= 0b11000011;
	MOVLW      195
	ANDWF      PORTC+0, 1
;FinalProject.c,10 :: 		TRISC |= 0b00111100; //push buttons
	MOVLW      60
	IORWF      TRISC+0, 1
;FinalProject.c,11 :: 		startSimonSays();
	CALL       _startSimonSays+0
;FinalProject.c,12 :: 		startTarget();
	CALL       _startTarget+0
;FinalProject.c,13 :: 		startUltrasonic();
	CALL       _startUltrasonic+0
;FinalProject.c,15 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_startGame:

;FinalProject.c,16 :: 		void startGame(){
;FinalProject.c,17 :: 		INTCON = 0X00;
	CLRF       INTCON+0
;FinalProject.c,18 :: 		ADCON1 &= 0x06;//PORTA Digital
	MOVLW      6
	ANDWF      ADCON1+0, 1
;FinalProject.c,21 :: 		}
L_end_startGame:
	RETURN
; end of _startGame
