#include "tpl_os.h"

/*
 * A LiquidCrystalFast object is instantiated.
 * Pin numbers are per Teensyduino specification
 */
LiquidCrystalFast lcd(18,17,16,15,14,19);

DeclareEvent(evt_0);
DeclareEvent(evt_1);

/* Main */

#define APP_Task_a_task_START_SEC_CODE
#include "tpl_memmap.h"
FUNC(int, OS_APPL_CODE) main(void)
{ 
  /* All 5 LEDs pins are set as output */
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  
  /* Init the LCD */
  lcd.begin(20, 4);
  
  /* Print the version of Trampoline */
  lcd.println("Trampoline v2.1.21");
  
  /* Start the OS */
  StartOS(OSDEFAULTAPPMODE);
  
  /* Never reach this line, StartOS does not return */
  return 0;
}

/* Application */


TASK(task_0)
{
    lcd.print("a0 ");
    WaitEvent(evt_0);
    lcd.print("b0 ");
    
    /* 3,3 */
    // lcd.println("I'm 0");


    /* Terminate the task */
    TerminateTask();
}

TASK(task_1)
{
    lcd.print("a1 ");
    WaitEvent(evt_1);
    lcd.print("b1 ");
    
    /* 3,3 */
   // lcd.println("I'm 1");
    
    
    /* Terminate the task */
    TerminateTask();
}

TASK(a_task)
{
    /*Q1
    ActivateTask(task_0);
    ActivateTask(task_1);
    TerminateTask();
     */

    /*Q2
    ActivateTask(task_0);
    ActivateTask(task_1);
    ChainTask(task_1); */
    
    /* 3,4 Q5*/
    lcd.print("c ");
    ActivateTask(task_0);
    lcd.print("d0 ");
    ActivateTask(task_1);
    lcd.print("d1 ");
    
    SetEvent(task_0, evt_0);
    lcd.print("e0 ");
    SetEvent(task_1, evt_1);
    lcd.print("e1 ");
    
    ChainTask(task_1);
}



#define APP_Task_a_task_STOP_SEC_CODE
#include "tpl_memmap.h"
