MCU=atmega32u4
F_CPU=16000000

LAYOUT?=qwerty

USB?=/dev/ttyU0

all: $(LAYOUT).hex

upload: $(LAYOUT).hex
	@echo "Put your device in bootloader mode now..."
	@echo "Classic Atreus: press reset key (usually fn+esc -> B)."
	@echo "Keyboardio Atreus: press the button on the underside of the board."
	while [ ! -r $(USB) ]; do sleep 1; done; \
	avrdude -p $(MCU) -c avr109 -U flash:w:$(LAYOUT).hex -P $(USB)

clean: ; -rm -f $(LAYOUT){,.hex} *.o *.elf *.s

$(LAYOUT).hex: $(LAYOUT).elf
	avr-size $(LAYOUT).elf
	avr-objcopy --output-target=ihex $(LAYOUT).elf $(LAYOUT).hex

$(LAYOUT).s: $(LAYOUT).scm menelaus.scm keycodes.scm
	microscheme -m LEO $(LAYOUT).scm

$(LAYOUT).elf: $(LAYOUT).s usb_keyboard.s
	avr-gcc -mmcu=$(MCU) -o $(LAYOUT).elf $(LAYOUT).s usb_keyboard.s

usb_keyboard.s: usb_keyboard.h usb_keyboard.c
	avr-gcc -std=gnu99 -S -D F_CPU=$(F_CPU)UL -mmcu=$(MCU) -c \
	  -o usb_keyboard.s usb_keyboard.c

.PHONY: all upload clean
