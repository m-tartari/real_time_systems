#include "tpl_os.h"

/*
 * A LiquidCrystalFast object is instantiated.
 * Pin numbers are per Teensyduino specification
 */
LiquidCrystalFast lcd(18,17,16,15,14,19);

/* Main */

#define OS_START_SEC_CODE
#include "tpl_memmap.h"
FUNC(int, OS_APPL_CODE) main(void)
{
    /* All 5 LEDs pins are set as output */
    pinMode(3, OUTPUT);
    pinMode(4, OUTPUT);
    pinMode(5, OUTPUT);
    pinMode(6, OUTPUT);
    pinMode(7, OUTPUT);
    
    /* Button P0_8 as input pullup */
    pinMode( 8, INPUT_PULLUP);
    pinMode( 9, INPUT_PULLUP);
    pinMode(10, INPUT_PULLUP);
    
    /* Init the LCD */
    lcd.begin(20, 4);
    
    /* Print the version of Trampoline */
    lcd.println("Tramp. v2.1.21  Q4.6");
    
    /* Start the OS */
    StartOS(OSDEFAULTAPPMODE);
    
    /* Never reach this line, StartOS does not return */
    return 0;
}
#define OS_STOP_SEC_CODE
#include "tpl_memmap.h"

/* Application */
DeclareAlarm (A_3);
DeclareAlarm (A_4);
DeclareAlarm (A_5);
DeclareAlarm (A_6);

typedef enum { BUTTON_OFF, BUTTON_PUSH, BUTTON_ON, BUTTON_RELEASE } ButtonState;

#define APP_Task_button_scanner_START_SEC_CODE
#include "tpl_memmap.h"
FUNC(ButtonState, OS_APPL_CODE) readButton8()
{
    static ButtonState state = BUTTON_OFF;
    uint8 button = digitalRead(8);
    
    switch (state)
    {
        case BUTTON_OFF:     if (button == LOW) state = BUTTON_PUSH; break;
        case BUTTON_PUSH:    state = BUTTON_ON; break;
        case BUTTON_ON:      if (button == HIGH) state = BUTTON_RELEASE; break;
        case BUTTON_RELEASE: state = BUTTON_OFF; break;
    }
    
    return state;
}

FUNC(ButtonState, OS_APPL_CODE) readButton9()
{
    static ButtonState state9 = BUTTON_OFF;
    uint8 button9 = digitalRead(9);
    
    switch (state9)
    {
        case BUTTON_OFF:     if (button9 == LOW) state9 = BUTTON_PUSH; break;
        case BUTTON_PUSH:    state9 = BUTTON_ON; break;
        case BUTTON_ON:      if (button9 == HIGH) state9 = BUTTON_RELEASE; break;
        case BUTTON_RELEASE: state9 = BUTTON_OFF; break;
    }
    
    return state9;
}

FUNC(ButtonState, OS_APPL_CODE) readButton10()
{
    static ButtonState state10 = BUTTON_OFF;
    uint8 button10 = digitalRead(10);
    
    switch (state10)
    {
        case BUTTON_OFF:     if (button10 == LOW) state10 = BUTTON_PUSH; break;
        case BUTTON_PUSH:    state10 = BUTTON_ON; break;
        case BUTTON_ON:      if (button10 == HIGH) state10 = BUTTON_RELEASE; break;
        case BUTTON_RELEASE: state10 = BUTTON_OFF; break;
    }
    
    return state10;
}


TASK(L_3)
{
    digitalWrite(3,!digitalRead(3));
    TerminateTask();
}

TASK(L_4)
{
    digitalWrite(4,!digitalRead(4));
    TerminateTask();
}

TASK(L_5)
{
    digitalWrite(5,!digitalRead(5));
    TerminateTask();
}

TASK(L_6)
{
    digitalWrite(6,!digitalRead(6));
    TerminateTask();
}


TASK(button_scanner)
{
    int delay=250;
    static bool flag=false; //setted true when countdown starts
    
    //digitalWrite(7,!digitalRead(7));
    
    ButtonState button = readButton10(); // check B10
    if ((button == BUTTON_PUSH) && !flag){
        flag=true;
        SetRelAlarm ( A_3,    delay, 4*delay );
        SetRelAlarm ( A_4, 2*delay, 4*delay );
        SetRelAlarm ( A_5, 3*delay, 4*delay );
        SetRelAlarm ( A_6, 4*delay, 4*delay );
    }
    
    button = readButton9(); // check B9
    if ((button == BUTTON_PUSH) & !flag){
        flag=true;
        SetRelAlarm ( A_6,   delay, 4*delay );
        SetRelAlarm ( A_5, 2*delay, 4*delay );
        SetRelAlarm ( A_4, 3*delay, 4*delay );
        SetRelAlarm ( A_3, 4*delay, 4*delay );
        
    }
    
    button = readButton8(); // check B8
    if ((button == BUTTON_PUSH) & flag) {
        CancelAlarm ( A_3 );
        CancelAlarm ( A_4 );
        CancelAlarm ( A_5 );
        CancelAlarm ( A_6 );
        digitalWrite(3,LOW);
        digitalWrite(4,LOW);
        digitalWrite(5,LOW);
        digitalWrite(6,LOW);
        flag=false;
    }
    
TerminateTask();
}
#define APP_Task_button_scanner_STOP_SEC_CODE
#include "tpl_memmap.h"
