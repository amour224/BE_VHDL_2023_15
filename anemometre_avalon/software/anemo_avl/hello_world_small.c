#include "sys/alt_stdio.h"
#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h"
//#include "unistd.h"

#define leds (unsigned int *) LEDS_BASE
#define button (unsigned char *) BP_BASE


#define config (unsigned int *) (AVALON_ANEMOMETRE_0_BASE)
#define code (unsigned int *) (AVALON_ANEMOMETRE_0_BASE + 4) //01

unsigned int a,b,c,d;

int main()
{ 
  alt_putstr("Hello from Nios II!\n");

  *config = 0x0003;

  printf("config = %d\n", *config);


  /* Event loop never exits. */
  while (1){

	  *config = 0x0003;
	  printf("config = %d\n", *config);
	  if (button != 3 ){
		  *leds = 300;
		  *config = 0x0002;
		  printf("config = %d\n", *config);
	  }


	  printf("inside while \n");
	 // printf("config = %d\n", *config);
	  printf("data = %d\n", *code);

	  *leds = *code - 512;

	  printf("data_anemometre = %d\n", *leds);
	  if (*leds < 512) {
		  printf("data_valid = %d\n", 0);
	  }
	  else 	  printf("data_valid = %d\n", 1);

  }
}
