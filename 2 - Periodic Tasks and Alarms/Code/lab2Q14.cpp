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
    pinMode(8, INPUT_PULLUP);
    pinMode(9, INPUT_PULLUP);
    
    /* Init the LCD */
    lcd.begin(20, 4);
    
    /* Print the version of Trampoline */
    lcd.println("Tramp. v2.1.21  Q14");
    
    /* Start the OS */
    StartOS(OSDEFAULTAPPMODE);
    
    /* Never reach this line, StartOS does not return */
    return 0;
}
#define OS_STOP_SEC_CODE
#include "tpl_memmap.h"

/* Application */
DeclareAlarm (run_t1);
DeclareEvent (evt);
DeclareEvent (evt_f);

typedef enum { BUTTON_OFF, BUTTON_PUSH, BUTTON_ON, BUTTON_RELEASE } ButtonState;

#define APP_Task_button_scanner_START_SEC_CODE
#include "tpl_memmap.h"
FUNC(ButtonState, OS_APPL_CODE) readButton()
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


TASK(Body)
{
    lcd.println("You have 2s..");
    EventMaskType received;
    TickType left;
    SetRelAlarm ( run_t1, 2000, 0);
    
    // wait for button press or time run out and check which one is it
    WaitEvent(evt | evt_f);
    GetEvent(Body, &received);
    
    if(evt_f & received) { // if button print time
        GetAlarm(run_t1,&left);
        float time= (2000-float(left))/1000;
        lcd.print("You wasted ");
        lcd.print(time);
        lcd.println("s of your life here");
        ClearEvent(evt_f);
        ClearEvent(evt);
    }
    else {
        lcd.println("Toooo slow!");
        ClearEvent(evt);
    }
    
    CancelAlarm ( run_t1 );
    TerminateTask();
}


TASK(button_scanner)
{
    static bool flag=false; //setted true when countdown starts
    ButtonState button = readButton(); // check B8
    if ((button == BUTTON_PUSH) & !flag) {
        flag=true;
        ActivateTask(Body);
    }
    
    ButtonState button9 = readButton9(); // check B9
    if ((button9 == BUTTON_PUSH) & flag){
        SetEvent(Body, evt_f);
        flag=false;
    }

TerminateTask();
}
#define APP_Task_button_scanner_STOP_SEC_CODE
#include "tpl_memmap.h"
