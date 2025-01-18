#include <stdint.h>

//stack pointer
extern uint32_t _estack;

int main();
void Reset_Handler();

 __attribute__((section(".vectors"))) 
const uint32_t vectors[] = {
  (uint32_t) &_estack,
  (uint32_t) Reset_Handler
};


void Reset_Handler() {
    main();
    while (true) {
    }
}

int main() {
  while (true){

  }
 return 0;
}
