#include "alt_types.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "unistd.h"
#include "stdio.h"

#define led (char *) LED_BASE
#define bp (char *) BP_BASE

#define freq (int *)VER_COMPONENT_0_BASE
#define duty (int *)(VER_COMPONENT_0_BASE + 4)
#define butee_g (int *)(VER_COMPONENT_0_BASE + 8)
#define butee_d (int *)(VER_COMPONENT_0_BASE + 12)
#define config (int *)(VER_COMPONENT_0_BASE + 16)
#define angle_barre (int *)(VER_COMPONENT_0_BASE + 20)

int main()
{
 unsigned int a,c,d;
 unsigned char b;

 printf("Hello from Nios II!\n");
 *butee_d=1320;
 *butee_g=410;
 *freq= 2000;
 *duty=1500;
 //*config=1; // circuit gestion_verin actif, sortie pwm inactive

 while (1)
 {
 //test bp en mode manuel seul
 b=*bp;
 printf("code_fonction= %d\n", b);
 switch(b)
 {
 case 1: *config=1;break;
 case 0: *config=0;break;
 //case 2: *config=3;break;
 default:*config=1;
 }

 c=*freq;
 printf("freq= %d\n", c);
 d=*duty;
 printf("duty= %d\n", d);
 c=*butee_d;
 printf("butee_d= %d\n", c);
 d=*butee_g;
 printf("butee_g= %d\n", d);
 c=*config;
 printf("config= %d\n", c);
 d=*angle_barre;
 printf("angle_barre= %d\n", d);
 usleep(100000);

 }
 return 0;
}
