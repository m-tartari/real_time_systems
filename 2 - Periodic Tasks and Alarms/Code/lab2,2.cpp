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

  /* Init the LCD */
  lcd.begin(20, 4);

  /* Print the version of Trampoline */
  lcd.println("Trampoline v2.1.2");
    lcd.println("   Q2.2");

  /* Start the OS */
  StartOS(OSDEFAULTAPPMODE);

  /* Never reach this line, StartOS does not return */
  return 0;
}
#define OS_STOP_SEC_CODE
#include "tpl_memmap.h"

/* Application */

typedef enum { BUTTON_OFF, BUTTON_PUSH, BUTTON_ON, BUTTON_RELEASE } ButtonState;

#define APP_Task_t1_START_SEC_CODE
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

TASK(t1)
{
    static int i=0;
    
    i = 1 - i;
    
    if(i)
        digitalWrite(3, HIGH);
    else
        digitalWrite(3, LOW);
    
    TerminateTask();
}

TASK(t2)
{
    static int j=0;
    
    j = 1 - j;
    
    if(j)
        digitalWrite(4, HIGH);
    else
        digitalWrite(4, LOW);
    
    TerminateTask();
}
#define APP_Task_t1_STOP_SEC_CODE
#include "tpl_memmap.h"
