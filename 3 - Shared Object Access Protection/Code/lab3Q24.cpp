#include "tpl_os.h"
#include "tpl_os_task_kernel.h"


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

void displayIdAndCurrentPriority()
{
  TaskType id;
  GetTaskID(&id);
  if (id >= 0)
  {
    tpl_priority prio = (tpl_dyn_proc_table[id]->priority) >> PRIORITY_SHIFT;
		lcd.print("Id=");
    lcd.print(id);
		lcd.print(", Prio=");
    lcd.println(prio);
  }
}

DeclareResource(S1);

TASK(bgTask)
{
        val++;
        val--;
    ChainTask(bgTask);
}

TASK(periodicTask)
{
    digitalWrite(7,!digitalRead(7));
    ++activationCount;
    if(activationCount%2)
        val++;
    else
        val--;
    TerminateTask();
}

TASK(displayTask)
{
    /*lcd.println("displayTask");
    displayIdAndCurrentPriority();*/
     
    lcd.print("actCount= ");
    lcd.println(activationCount);
    lcd.print("val= ");
    lcd.println(val);
    
    /*displayIdAndCurrentPriority();*/
    TerminateTask();
}

#define APP_Task_bgTask_STOP_SEC_CODE
#include "tpl_memmap.h"

