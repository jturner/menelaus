;; port of usb_keyboard.h

(define key-a 4)
(define key-b 5)
(define key-c 6)
(define key-d 7)
(define key-e 8)
(define key-f 9)
(define key-g 10)
(define key-h 11)
(define key-i 12)
(define key-j 13)
(define key-k 14)
(define key-l 15)
(define key-m 16)
(define key-n 17)
(define key-o 18)
(define key-p 19)
(define key-q 20)
(define key-r 21)
(define key-s 22)
(define key-t 23)
(define key-u 24)
(define key-v 25)
(define key-w 26)
(define key-x 27)
(define key-y 28)
(define key-z 29)

(define key-1 30)
(define key-2 31)
(define key-3 32)
(define key-4 33)
(define key-5 34)
(define key-6 35)
(define key-7 36)
(define key-8 37)
(define key-9 38)
(define key-0 39)

(define key-up 82)
(define key-down 81)
(define key-left 80)
(define key-right 79)

;; Longer keys get shorthand aliases:
(define key-page-up 75) (define key-pgup 75)
(define key-page-down 78) (define key-pgdn 78)
(define key-home 74)
(define key-end 77)
(define key-insert 73) (define key-ins 73)
(define key-delete 76) (define key-del 76)

(define key-semicolon 51)
(define key-comma 54)
(define key-quote 52)
(define key-backslash 49)
(define key-backtick 53)
(define key-left-bracket 47)
(define key-right-bracket 48)

(define key-period 55) (define key-. 55)
(define key-slash 56) (define key-/ 56)
(define key-dash 45) (define key-- 45)
(define key-equal 46) (define key-= 46)

(define key-space 44) (define key-spc 44)
(define key-backspace 42) (define key-bksp 42)
(define key-esc 41)
(define key-tab 43)
(define key-enter 40)

(define key-vol-up 128)
(define key-vol-down 129) (define key-vol-dn 129)

(define key-f1 58)
(define key-f2 59)
(define key-f3 60)
(define key-f4 61)
(define key-f5 62)
(define key-f6 63)
(define key-f7 64)
(define key-f8 65)
(define key-f9 66)
(define key-f10 67)
(define key-f11 68)
(define key-f12 69)

(define key-printscreen 70)
(define key-scroll-lock 71) ; lol
(define key-pause 72)

(define (modifier? keycode) (list? keycode))
(define (modify keycode) (list keycode))
(define (unmodify keycode) (car keycode))

;; currently you can only combo with one modifier and one normal key
(define (combo modifier keycode) (list (car modifier) keycode))
(define (uncombo keycode) (and (= 2 (length keycode)) (car (cdr keycode))))

;; We're treating these a little differently; they are not literal USB values.
(define mod-ctrl (modify 1))
(define mod-shift (modify 2))
(define mod-alt (modify 3))
(define mod-super (modify 4))

(define (sft keycode) (combo mod-shift keycode)) ; shorthand

;; Enter the bootloader in preparation for flashing.
(define (reset _) (call-c-func "reset"))
