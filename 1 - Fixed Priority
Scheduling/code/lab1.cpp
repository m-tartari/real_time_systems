#include "tpl_os.h"

/*
 * A LiquidCrystalFast object is instantiated.
 * Pin numbers are per Teensyduino specification
 */
LiquidCrystalFast lcd(18,17,16,15,14,19);


DeclareEvent(ev_1);
DeclareEvent(ev_2);
DeclareEvent(ev_3);
DeclareTask(server);

/* Main */

#define APP_Task_server_START_SEC_CODE
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
  //lcd.println("Trampoline v2.1.21");
  
  /* Start the OS */
  StartOS(OSDEFAULTAPPMODE);
  
  /* Never reach this line, StartOS does not return */
  return 0;
}

/* Application */

TASK(t1)
{
    lcd.print("s1  ");
    digitalWrite(4,LOW);
    digitalWrite(5,LOW);
    digitalWrite(6,LOW);
    digitalWrite(3,HIGH);
    SetEvent(server, ev_1);
    lcd.print("f1 ");
    TerminateTask();
}

TASK(t2)
{
    lcd.print("s2  ");
    digitalWrite(3,LOW);
    digitalWrite(5,LOW);
    digitalWrite(6,LOW);
    digitalWrite(4,HIGH);
    SetEvent(server, ev_2);
    lcd.print("f2 ");
    TerminateTask();
}

TASK(t3)
{
    lcd.print("s3  ");
    digitalWrite(4,LOW);
    digitalWrite(3,LOW);
    digitalWrite(6,LOW);
    digitalWrite(5,HIGH);
    SetEvent(server, ev_3);
    lcd.print("f3 ");
    TerminateTask();
}


TASK(server)
{
    /* Q6
    while (TRUE) {
    
    //lcd.println("Ready, ");
    ActivateTask( t1 );
    ActivateTask( t2 );
    ActivateTask( t3 );
    //lcd.println("Waiting evt_1, ");
    lcd.print("received ev_1, ");
    digitalWrite(6,HIGH);*/
    
    while (TRUE) {
        
        //lcd.println("Ready, ");
        ActivateTask( t1 );
        ActivateTask( t2 );
        ActivateTask( t3 );
        //lcd.println("Waiting evt_1, ");
        //lcd.print("received ev_1, ");
        digitalWrite(6,HIGH);

        EventMaskType event_got, x;
       
        WaitEvent(ev_1 | ev_2 | ev_3);
        GetEvent(server, &event_got);
        x = event_got;
        ClearEvent(x);
        if (event_got & ev_1) {
            ActivateTask( t1 );
        }
        if (event_got & ev_2) {
            ActivateTask( t2 );
        }
        if (event_got & ev_3) {
            ActivateTask( t3 );
        }
//
    }
    TerminateTask();
}



#define APP_Task_server_STOP_SEC_CODE
#include "tpl_memmap.h"

