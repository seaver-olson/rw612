

#include <stdint.h>

int main();
void Reset_Handler();

extern uint32_t _estack;
 __attribute__((section(".vectors"))) const uint32_t vectors[] = {
&_estack,
Reset_Handler};


void Reset_Handler() {
    main();
    for(;;);
}

int main() {
  for(;;);
}
