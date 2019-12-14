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
    //lcd.print("Trampoline v2.1.21");

  /* Start the OS */
  StartOS(OSDEFAULTAPPMODE);

  /* Never reach this line, StartOS does not return */
  return 0;
}
#define OS_STOP_SEC_CODE
#include "tpl_memmap.h"

/* Application */

volatile int val=0;
volatile int activationCount=0;

typedef enum { BUTTON_OFF, BUTTON_PUSH, BUTTON_ON, BUTTON_RELEASE } ButtonState;

#define APP_Task_bgTask_START_SEC_CODE
#include "tpl_memmap.h"

/*FUNC(ButtonState, OS_APPL_CODE) readButton()
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

FUNC(ButtonState, OS_APPL_CODE) readButton2()
{
    static ButtonState state = BUTTON_OFF;
    uint8 button = digitalRead(9);
    
    switch (state)
    {
        case BUTTON_OFF:     if (button == LOW) state = BUTTON_PUSH; break;
        case BUTTON_PUSH:    state = BUTTON_ON; break;
        case BUTTON_ON:      if (button == HIGH) state = BUTTON_RELEASE; break;
        case BUTTON_RELEASE: state = BUTTON_OFF; break;
    }
    
    return state;
}*/

/*TASK(button_scanner)
 {
 ButtonState button = readButton();
 
 if (button == BUTTON_PUSH) {
 var++;
 digitalWrite(3, HIGH);
 ActivateTask(t_process);
 }
 else if (button == BUTTON_RELEASE) {
 digitalWrite(3, LOW);
 
 }
 
 TerminateTask();
 }*/

/*DeclareTask(buttonScanner);
DeclareTask(mainTask);
DeclareAlarm(runt2);
DeclareAlarm(runt3);
DeclareEvent(init);
DeclareEvent(body);
DeclareEvent(fin);*/
DeclareResource(S1);

TASK(bgTask)
{
    while(1){
        GetResource(S1);
        val++;
        val--;
        ReleaseResource(S1);
    }
    TerminateTask();
}

TASK(periodicTask)
{
    GetResource(S1);
    ++activationCount;
    if(activationCount%2)
        val++;
    else
        val--;
    TerminateTask();
    ReleaseResource(S1);
}

TASK(displayTask)
{
    GetResource(S1);
    lcd.print("actCount= ");
    lcd.println(activationCount);
    lcd.print("val= ");
    lcd.println(val);
    ReleaseResource(S1);
    
    TerminateTask();
}

#define APP_Task_bgTask_STOP_SEC_CODE
#include "tpl_memmap.h"

