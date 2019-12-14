/*
 * <INIT_POLICY> 
 * - NO_INIT, used for variables that are never cleared and never initialized.
 * - CLEARED, used for variables that are cleared to zero after every reset.
 * - POWER_ON_CLEARED, used for variables that are cleared to zero only after power on reset.
 * - INIT, used for variables that are initialized with values after every reset.
 * - POWER_ON_INIT, used for variables that are initialized with values only after power on reset.
 */
 
/* Entry Point */
ENTRY(tpl_reset_handler)

/* Generate a link error if heap and stack don't fit into RAM */
_Min_Heap_Size = 0;      /* required amount of heap  */
_Min_Stack_Size = 0x400; /* required amount of stack */

/* Specify the memory areas of mk20dx256 */
MEMORY
{
  VECTOR (rx)      : ORIGIN = 0x00000000, LENGTH = 0x400
  FLASHCONFIG (rx) : ORIGIN = 0x00000400, LENGTH = 16
  FLASH (rx)       : ORIGIN = 0x00000410, LENGTH = 256K - 0x410
  RAM  (rwx)       : ORIGIN = 0x1FFF8000, LENGTH = 64K
}


/* Define output sections */
SECTIONS
{
  /* The startup code goes first into FLASH */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector)) /* Startup code */
    . = ALIGN(4);
  } >VECTOR

  /*
   * code and consts of the operating system (Trampoline).
   * this section is not accessible from an untrusted process
   */
  . = ALIGN(4);
  ostext : {
    *(.SC_handler)
    *(.EI_handler)
    /*--- Initialisation des objets globaux C++ */
    . = ALIGN (4) ;
    __constructor_array_start = . ;
    KEEP (*(.init_array)) ;
    . = ALIGN (4) ;
    __constructor_array_end = . ;
    KEEP(*(.osCode))
    *(.appCommonCode) 
  } >FLASH

  . = ALIGN(4);
  osconst : {
    KEEP(*(.osConst))
  } >FLASH

  /*
   * code and consts of the processes of the applications
   */
  . = ALIGN(4);
  apptext : {
    __PROGCONST_SECTION_START = .;
    __SEG_START_APP_CODE_CONST_RGN = .;
  . = ALIGN(4);
    *(.osApiConst)  /* API constants    */
    *(.rodata)      /* litteral strings (constants, strings, etc.) */
    *(.rodata*)     /* litteral strings (constants, strings, etc.) */
    . = ALIGN(4);
    *(.osApiCode)   /* API functions    */
    /* Sections for code of tasks and ISR */
    *(.Task_serverCode)

    *(.Task_t1Code)

    *(.Task_t2Code)

    *(.Task_t3Code)

  } >FLASH

  . = ALIGN(4);
  appconst : {
     /* Sections for application const */  

  } >FLASH

  . = ALIGN(4);
  procconst : {
    /* Sections for const of tasks and ISR */
      *(.Task_server_SEC_CONST_32BIT)
      *(.Task_server_SEC_CALIB_32BIT)
      *(.Task_server_SEC_CARTO_32BIT)
      *(.Task_server_SEC_CONFIG_DATA_32BIT)
      *(.Task_server_SEC_CONST_16BIT)
      *(.Task_server_SEC_CALIB_16BIT)
      *(.Task_server_SEC_CARTO_16BIT)
      *(.Task_server_SEC_CONFIG_DATA_16BIT)
      *(.Task_server_SEC_CONST_8BIT)
      *(.Task_server_SEC_CALIB_8BIT)
      *(.Task_server_SEC_CARTO_8BIT)
      *(.Task_server_SEC_CONFIG_DATA_8BIT)
      *(.Task_server_SEC_CONST_BOOLEAN)
      *(.Task_server_SEC_CALIB_BOOLEAN)
      *(.Task_server_SEC_CARTO_BOOLEAN)
      *(.Task_server_SEC_CONFIG_DATA_BOOLEAN)
      *(.Task_server_SEC_CONST_UNSPECIFIED)
      *(.Task_server_SEC_CALIB_UNSPECIFIED)
      *(.Task_server_SEC_CARTO_UNSPECIFIED)
      *(.Task_server_SEC_CONFIG_DATA_UNSPECIFIED)
      *(.Task_t1_SEC_CONST_32BIT)
      *(.Task_t1_SEC_CALIB_32BIT)
      *(.Task_t1_SEC_CARTO_32BIT)
      *(.Task_t1_SEC_CONFIG_DATA_32BIT)
      *(.Task_t1_SEC_CONST_16BIT)
      *(.Task_t1_SEC_CALIB_16BIT)
      *(.Task_t1_SEC_CARTO_16BIT)
      *(.Task_t1_SEC_CONFIG_DATA_16BIT)
      *(.Task_t1_SEC_CONST_8BIT)
      *(.Task_t1_SEC_CALIB_8BIT)
      *(.Task_t1_SEC_CARTO_8BIT)
      *(.Task_t1_SEC_CONFIG_DATA_8BIT)
      *(.Task_t1_SEC_CONST_BOOLEAN)
      *(.Task_t1_SEC_CALIB_BOOLEAN)
      *(.Task_t1_SEC_CARTO_BOOLEAN)
      *(.Task_t1_SEC_CONFIG_DATA_BOOLEAN)
      *(.Task_t1_SEC_CONST_UNSPECIFIED)
      *(.Task_t1_SEC_CALIB_UNSPECIFIED)
      *(.Task_t1_SEC_CARTO_UNSPECIFIED)
      *(.Task_t1_SEC_CONFIG_DATA_UNSPECIFIED)
      *(.Task_t2_SEC_CONST_32BIT)
      *(.Task_t2_SEC_CALIB_32BIT)
      *(.Task_t2_SEC_CARTO_32BIT)
      *(.Task_t2_SEC_CONFIG_DATA_32BIT)
      *(.Task_t2_SEC_CONST_16BIT)
      *(.Task_t2_SEC_CALIB_16BIT)
      *(.Task_t2_SEC_CARTO_16BIT)
      *(.Task_t2_SEC_CONFIG_DATA_16BIT)
      *(.Task_t2_SEC_CONST_8BIT)
      *(.Task_t2_SEC_CALIB_8BIT)
      *(.Task_t2_SEC_CARTO_8BIT)
      *(.Task_t2_SEC_CONFIG_DATA_8BIT)
      *(.Task_t2_SEC_CONST_BOOLEAN)
      *(.Task_t2_SEC_CALIB_BOOLEAN)
      *(.Task_t2_SEC_CARTO_BOOLEAN)
      *(.Task_t2_SEC_CONFIG_DATA_BOOLEAN)
      *(.Task_t2_SEC_CONST_UNSPECIFIED)
      *(.Task_t2_SEC_CALIB_UNSPECIFIED)
      *(.Task_t2_SEC_CARTO_UNSPECIFIED)
      *(.Task_t2_SEC_CONFIG_DATA_UNSPECIFIED)
      *(.Task_t3_SEC_CONST_32BIT)
      *(.Task_t3_SEC_CALIB_32BIT)
      *(.Task_t3_SEC_CARTO_32BIT)
      *(.Task_t3_SEC_CONFIG_DATA_32BIT)
      *(.Task_t3_SEC_CONST_16BIT)
      *(.Task_t3_SEC_CALIB_16BIT)
      *(.Task_t3_SEC_CARTO_16BIT)
      *(.Task_t3_SEC_CONFIG_DATA_16BIT)
      *(.Task_t3_SEC_CONST_8BIT)
      *(.Task_t3_SEC_CALIB_8BIT)
      *(.Task_t3_SEC_CARTO_8BIT)
      *(.Task_t3_SEC_CONFIG_DATA_8BIT)
      *(.Task_t3_SEC_CONST_BOOLEAN)
      *(.Task_t3_SEC_CALIB_BOOLEAN)
      *(.Task_t3_SEC_CARTO_BOOLEAN)
      *(.Task_t3_SEC_CONFIG_DATA_BOOLEAN)
      *(.Task_t3_SEC_CONST_UNSPECIFIED)
      *(.Task_t3_SEC_CALIB_UNSPECIFIED)
      *(.Task_t3_SEC_CARTO_UNSPECIFIED)
      *(.Task_t3_SEC_CONFIG_DATA_UNSPECIFIED)
    
    . = ALIGN(4);
    __SEG_STOP_APP_CODE_CONST_RGN = . - 1;
    __PROGCONST_SECTION_STOP = . - 1;
  } >FLASH

  /* remaining .text (ie no section given) */
  .text :
  {
    . = ALIGN(4);
    *(.text)           /* .text sections (code) */
    *(.text*)          /* .text* sections (code) */
    *(.glue_7)         /* glue arm to thumb code */
    *(.glue_7t)        /* glue thumb to arm code */
 *(.eh_frame)

    KEEP (*(.init))
    KEEP (*(.fini))

    . = ALIGN(4);
    _etext = .;        /* define a global symbols at end of code */
    _exit = .;
  } >FLASH


   .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH
    .ARM : {
    __exidx_start = .;
      *(.ARM.exidx*)
      __exidx_end = .;
    } >FLASH

  .preinit_array     :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array*))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } >FLASH
  .init_array :
  {
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    PROVIDE_HIDDEN (__init_array_end = .);
  } >FLASH
  .fini_array :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(.fini_array*))
    KEEP (*(SORT(.fini_array.*)))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } >FLASH
  
  _etext = .;

/*----------------------------------------------------------------------------*/
/*                                                                            */
/*                          Data (initialized data)                           */
/*                                                                            */
/*----------------------------------------------------------------------------*/

  .data : {
    FILL (0xFF)
    . = ALIGN (4) ;
    __data_start = . ;
    * (.data.*init*) ;
    * (.data*) ;
    KEEP(*(.osVar)) ;

/* Initialized variables section of Task server */
    *(.Task_server_SEC_VAR_POWER_ON_INIT_32BIT)
    *(.Task_server_SEC_VAR_POWER_ON_INIT_16BIT)
    *(.Task_server_SEC_VAR_POWER_ON_INIT_8BIT)
    *(.Task_server_SEC_VAR_POWER_ON_INIT_BOOLEAN)
    *(.Task_server_SEC_VAR_POWER_ON_INIT_UNSPECIFIED)

/* Initialized variables section of Task t1 */
    *(.Task_t1_SEC_VAR_POWER_ON_INIT_32BIT)
    *(.Task_t1_SEC_VAR_POWER_ON_INIT_16BIT)
    *(.Task_t1_SEC_VAR_POWER_ON_INIT_8BIT)
    *(.Task_t1_SEC_VAR_POWER_ON_INIT_BOOLEAN)
    *(.Task_t1_SEC_VAR_POWER_ON_INIT_UNSPECIFIED)

/* Initialized variables section of Task t2 */
    *(.Task_t2_SEC_VAR_POWER_ON_INIT_32BIT)
    *(.Task_t2_SEC_VAR_POWER_ON_INIT_16BIT)
    *(.Task_t2_SEC_VAR_POWER_ON_INIT_8BIT)
    *(.Task_t2_SEC_VAR_POWER_ON_INIT_BOOLEAN)
    *(.Task_t2_SEC_VAR_POWER_ON_INIT_UNSPECIFIED)

/* Initialized variables section of Task t3 */
    *(.Task_t3_SEC_VAR_POWER_ON_INIT_32BIT)
    *(.Task_t3_SEC_VAR_POWER_ON_INIT_16BIT)
    *(.Task_t3_SEC_VAR_POWER_ON_INIT_8BIT)
    *(.Task_t3_SEC_VAR_POWER_ON_INIT_BOOLEAN)
    *(.Task_t3_SEC_VAR_POWER_ON_INIT_UNSPECIFIED)

    . = ALIGN (4) ;
    __data_end = . ;
  } > RAM AT > FLASH

/*----------------------------------------------------------------------------*/

__data_load_start = LOADADDR (.data) ;
__data_load_end   = LOADADDR (.data) + SIZEOF (.data) ;

  /*
   * private data of processes
   */
  .Task_server_SEC_VAR : {
    . = ALIGN(__SEG_ALIGN_Task_server_VAR_RGN);
    __SEG_START_Task_server_VAR_RGN = .;
/* Initialized variables section of Task server */
    *(.Task_server_SEC_VAR_NOINIT_32BIT)
    *(.Task_server_SEC_VAR_FAST_32BIT)
    *(.Task_server_SEC_VAR_32BIT)
    *(.Task_server_SEC_VAR_NOINIT_16BIT)
    *(.Task_server_SEC_VAR_FAST_16BIT)
    *(.Task_server_SEC_VAR_16BIT)
    *(.Task_server_SEC_VAR_NOINIT_8BIT)
    *(.Task_server_SEC_VAR_FAST_8BIT)
    *(.Task_server_SEC_VAR_8BIT)
    *(.Task_server_SEC_VAR_NOINIT_BOOLEAN)
    *(.Task_server_SEC_VAR_FAST_BOOLEAN)
    *(.Task_server_SEC_VAR_BOOLEAN)
    *(.Task_server_SEC_VAR_NOINIT_UNSPECIFIED)
    *(.Task_server_SEC_VAR_FAST_UNSPECIFIED)
    *(.Task_server_SEC_VAR_UNSPECIFIED)
     __SEG_END_Task_server_VAR_RGN = .;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 4K ? 4K : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 1K ? 1K : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 512 ? 512 : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 256 ? 256 : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 128 ? 128 : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 64 ? 64 : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_SIZE_Task_server_VAR_RGN = (__SEG_END_Task_server_VAR_RGN - __SEG_START_Task_server_VAR_RGN) < 32 ? 32 : __SEG_SIZE_Task_server_VAR_RGN;
     __SEG_ALIGN_Task_server_VAR_RGN = __SEG_SIZE_Task_server_VAR_RGN;
  } >RAM
  .Task_t1_SEC_VAR : {
    . = ALIGN(__SEG_ALIGN_Task_t1_VAR_RGN);
    __SEG_START_Task_t1_VAR_RGN = .;
/* Initialized variables section of Task t1 */
    *(.Task_t1_SEC_VAR_NOINIT_32BIT)
    *(.Task_t1_SEC_VAR_FAST_32BIT)
    *(.Task_t1_SEC_VAR_32BIT)
    *(.Task_t1_SEC_VAR_NOINIT_16BIT)
    *(.Task_t1_SEC_VAR_FAST_16BIT)
    *(.Task_t1_SEC_VAR_16BIT)
    *(.Task_t1_SEC_VAR_NOINIT_8BIT)
    *(.Task_t1_SEC_VAR_FAST_8BIT)
    *(.Task_t1_SEC_VAR_8BIT)
    *(.Task_t1_SEC_VAR_NOINIT_BOOLEAN)
    *(.Task_t1_SEC_VAR_FAST_BOOLEAN)
    *(.Task_t1_SEC_VAR_BOOLEAN)
    *(.Task_t1_SEC_VAR_NOINIT_UNSPECIFIED)
    *(.Task_t1_SEC_VAR_FAST_UNSPECIFIED)
    *(.Task_t1_SEC_VAR_UNSPECIFIED)
     __SEG_END_Task_t1_VAR_RGN = .;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 4K ? 4K : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 1K ? 1K : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 512 ? 512 : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 256 ? 256 : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 128 ? 128 : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 64 ? 64 : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_SIZE_Task_t1_VAR_RGN = (__SEG_END_Task_t1_VAR_RGN - __SEG_START_Task_t1_VAR_RGN) < 32 ? 32 : __SEG_SIZE_Task_t1_VAR_RGN;
     __SEG_ALIGN_Task_t1_VAR_RGN = __SEG_SIZE_Task_t1_VAR_RGN;
  } >RAM
  .Task_t2_SEC_VAR : {
    . = ALIGN(__SEG_ALIGN_Task_t2_VAR_RGN);
    __SEG_START_Task_t2_VAR_RGN = .;
/* Initialized variables section of Task t2 */
    *(.Task_t2_SEC_VAR_NOINIT_32BIT)
    *(.Task_t2_SEC_VAR_FAST_32BIT)
    *(.Task_t2_SEC_VAR_32BIT)
    *(.Task_t2_SEC_VAR_NOINIT_16BIT)
    *(.Task_t2_SEC_VAR_FAST_16BIT)
    *(.Task_t2_SEC_VAR_16BIT)
    *(.Task_t2_SEC_VAR_NOINIT_8BIT)
    *(.Task_t2_SEC_VAR_FAST_8BIT)
    *(.Task_t2_SEC_VAR_8BIT)
    *(.Task_t2_SEC_VAR_NOINIT_BOOLEAN)
    *(.Task_t2_SEC_VAR_FAST_BOOLEAN)
    *(.Task_t2_SEC_VAR_BOOLEAN)
    *(.Task_t2_SEC_VAR_NOINIT_UNSPECIFIED)
    *(.Task_t2_SEC_VAR_FAST_UNSPECIFIED)
    *(.Task_t2_SEC_VAR_UNSPECIFIED)
     __SEG_END_Task_t2_VAR_RGN = .;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 4K ? 4K : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 1K ? 1K : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 512 ? 512 : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 256 ? 256 : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 128 ? 128 : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 64 ? 64 : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_SIZE_Task_t2_VAR_RGN = (__SEG_END_Task_t2_VAR_RGN - __SEG_START_Task_t2_VAR_RGN) < 32 ? 32 : __SEG_SIZE_Task_t2_VAR_RGN;
     __SEG_ALIGN_Task_t2_VAR_RGN = __SEG_SIZE_Task_t2_VAR_RGN;
  } >RAM
  .Task_t3_SEC_VAR : {
    . = ALIGN(__SEG_ALIGN_Task_t3_VAR_RGN);
    __SEG_START_Task_t3_VAR_RGN = .;
/* Initialized variables section of Task t3 */
    *(.Task_t3_SEC_VAR_NOINIT_32BIT)
    *(.Task_t3_SEC_VAR_FAST_32BIT)
    *(.Task_t3_SEC_VAR_32BIT)
    *(.Task_t3_SEC_VAR_NOINIT_16BIT)
    *(.Task_t3_SEC_VAR_FAST_16BIT)
    *(.Task_t3_SEC_VAR_16BIT)
    *(.Task_t3_SEC_VAR_NOINIT_8BIT)
    *(.Task_t3_SEC_VAR_FAST_8BIT)
    *(.Task_t3_SEC_VAR_8BIT)
    *(.Task_t3_SEC_VAR_NOINIT_BOOLEAN)
    *(.Task_t3_SEC_VAR_FAST_BOOLEAN)
    *(.Task_t3_SEC_VAR_BOOLEAN)
    *(.Task_t3_SEC_VAR_NOINIT_UNSPECIFIED)
    *(.Task_t3_SEC_VAR_FAST_UNSPECIFIED)
    *(.Task_t3_SEC_VAR_UNSPECIFIED)
     __SEG_END_Task_t3_VAR_RGN = .;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 4K ? 4K : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 1K ? 1K : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 512 ? 512 : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 256 ? 256 : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 128 ? 128 : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 64 ? 64 : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_SIZE_Task_t3_VAR_RGN = (__SEG_END_Task_t3_VAR_RGN - __SEG_START_Task_t3_VAR_RGN) < 32 ? 32 : __SEG_SIZE_Task_t3_VAR_RGN;
     __SEG_ALIGN_Task_t3_VAR_RGN = __SEG_SIZE_Task_t3_VAR_RGN;
  } >RAM

  
  /*
   * stack of processes
   */

  /* Section of stack of Task server  */
  .Task_server_SEC_STACK : {
    . = ALIGN(__SEG_ALIGN_Task_server_STACK_RGN);
    __SEG_START_Task_server_STACK_RGN = .;
    *(.Task_serverStack)
    . = ALIGN(4);
    __SEG_END_Task_server_STACK_RGN = .;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 4K ? 4K : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 1K ? 1K : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 512 ? 512 : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 256 ? 256 : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 128 ? 128 : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 64 ? 64 : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_SIZE_Task_server_STACK_RGN = (__SEG_END_Task_server_STACK_RGN - __SEG_START_Task_server_STACK_RGN) < 32 ? 32 : __SEG_SIZE_Task_server_STACK_RGN;
    __SEG_ALIGN_Task_server_STACK_RGN = __SEG_SIZE_Task_server_STACK_RGN;
  } >RAM

  /* Section of stack of Task t1  */
  .Task_t1_SEC_STACK : {
    . = ALIGN(__SEG_ALIGN_Task_t1_STACK_RGN);
    __SEG_START_Task_t1_STACK_RGN = .;
    *(.Task_t1Stack)
    . = ALIGN(4);
    __SEG_END_Task_t1_STACK_RGN = .;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 4K ? 4K : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 1K ? 1K : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 512 ? 512 : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 256 ? 256 : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 128 ? 128 : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 64 ? 64 : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_SIZE_Task_t1_STACK_RGN = (__SEG_END_Task_t1_STACK_RGN - __SEG_START_Task_t1_STACK_RGN) < 32 ? 32 : __SEG_SIZE_Task_t1_STACK_RGN;
    __SEG_ALIGN_Task_t1_STACK_RGN = __SEG_SIZE_Task_t1_STACK_RGN;
  } >RAM

  /* Section of stack of Task t2  */
  .Task_t2_SEC_STACK : {
    . = ALIGN(__SEG_ALIGN_Task_t2_STACK_RGN);
    __SEG_START_Task_t2_STACK_RGN = .;
    *(.Task_t2Stack)
    . = ALIGN(4);
    __SEG_END_Task_t2_STACK_RGN = .;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 4K ? 4K : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 1K ? 1K : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 512 ? 512 : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 256 ? 256 : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 128 ? 128 : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 64 ? 64 : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_SIZE_Task_t2_STACK_RGN = (__SEG_END_Task_t2_STACK_RGN - __SEG_START_Task_t2_STACK_RGN) < 32 ? 32 : __SEG_SIZE_Task_t2_STACK_RGN;
    __SEG_ALIGN_Task_t2_STACK_RGN = __SEG_SIZE_Task_t2_STACK_RGN;
  } >RAM

  /* Section of stack of Task t3  */
  .Task_t3_SEC_STACK : {
    . = ALIGN(__SEG_ALIGN_Task_t3_STACK_RGN);
    __SEG_START_Task_t3_STACK_RGN = .;
    *(.Task_t3Stack)
    . = ALIGN(4);
    __SEG_END_Task_t3_STACK_RGN = .;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 4K ? 4K : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 1K ? 1K : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 512 ? 512 : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 256 ? 256 : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 128 ? 128 : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 64 ? 64 : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_SIZE_Task_t3_STACK_RGN = (__SEG_END_Task_t3_STACK_RGN - __SEG_START_Task_t3_STACK_RGN) < 32 ? 32 : __SEG_SIZE_Task_t3_STACK_RGN;
    __SEG_ALIGN_Task_t3_STACK_RGN = __SEG_SIZE_Task_t3_STACK_RGN;
  } >RAM


  /*
   * os application data
   */
   appvars : {
 
  } >RAM

  /* Uninitialized data section */
  . = ALIGN(4);
  .bss :
  {
    /* This is used by the startup in order to initialize the .bss secion */
    _sbss = .;         /* define a global symbol at bss start */
    __bss_start = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)

    . = ALIGN(4);
    _ebss = .;         /* define a global symbol at bss end */
    __bss_end = _ebss;
  } >RAM

  /* User_heap_stack section, used to check that there is enough RAM left */
  ._user_heap_stack :
  {
    . = ALIGN(4);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(4);
  } >RAM

/*----------------------------------------------------------------------------*/
/*                                                                            */
/*                                System stack                                */
/*                                                                            */
/*----------------------------------------------------------------------------*/

  .system_stack :{
    . = ALIGN (4) ;
    __system_stack_start = . ;
    . += 2k ;
    . = ALIGN (4) ;
    __system_stack_end = . ;
    _estack = . ;
  } > RAM

  /* Flash configuration; */
  .flashConfiguration :  {
    KEEP(*(.flashconfig*))
  } >FLASHCONFIG

  /* Remove information from the standard libraries */
  /DISCARD/ :
  {
    libc.a ( * )
    libm.a ( * )
    libgcc.a ( * )
  }

  .ARM.attributes 0 : { *(.ARM.attributes) }
}
