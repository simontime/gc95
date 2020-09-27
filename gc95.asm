    title   Windows CD Key Generator
    type    8521

    NLIST
    include equates.inc
    include memory.inc
    LIST

    program
    
    db      04h
    db      40h
    dw      Entry
    db      00000011b
    dm      'TigerDMGC'
    db      21h
    db      85
    db      44
    dm      'W95KeyGen'
    dw      0000h
    db      00h
    db      0
    dw      0

Entry:
    clr     r0
    cmp     r2,#ini_game
    br      eq,RetStub
    cmp     r2,#exe_game
    jmp     eq,GameExe
    cmp     r2,#close_game
    br      eq,RetStub
    cmp     r2,#reset_game
    br      eq,RetStub
    mov     r0,#0ffh
    ret
    
RetStub:
    ret
    
GameExe:
    ; draw windows 95 screensaver
    mov     r8,#0
    mov     r9,#0
    mov     r10,#0
    mov     r11,#0
    mov     r12,#200
    mov     r13,#160
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph
    
    ; play sound
    mov     r1,#8
    movw    rr2,#2000h
    call    SND_ADDR
    mov     r0,#5
    call    CTRL_SP
    
    ; delay for 2 seconds
    mov     r2,#10
delay_loop:
    call    Delay200ms
    dec     r2
    br      nz,delay_loop
    
    ; stop speech
    call    Speech_Stop
    
    ; clear screen
    call    Cls_scn
    
    ; draw title
    mov     r8,#38
    mov     r9,#16
    mov     r10,#0
    mov     r11,#160
    mov     r12,#123
    mov     r13,#30
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph
    
    ; draw button
    mov     r8,#68
    mov     r9,#116
    mov     r10,#123
    mov     r11,#160
    mov     r12,#64
    mov     r13,#24
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph
    
    ; draw dash
    mov     r8,#60
    mov     r9,#78
    mov     r10,#8
    mov     r11,#3
    mov     r12,#4
    clr     r13
    call    Draw_line_h
    
    ; draw blank license
    clr     r9
    clr     r10
    clr     r11
    call    DrawLicA
    
    clr     r9
    clr     r10
    clr     r11
    clr     r12
    clr     r13
    clr     r14
    clr     r15
    call    DrawLicB
    
    movw    rr2,#0
main_loop:
    incw    rr2
    
    call    SCAN_KEY
    
    ; touched button
    cmp     r0,#13*7+5
    br      eq,generate
    cmp     r0,#13*7+6
    br      eq,generate
    cmp     r0,#13*7+7
    br      eq,generate
    cmp     r0,#13*7+8
    br      eq,generate
    cmp     r0,#13*7+9
    br      eq,generate
    cmp     r0,#13*8+5
    br      eq,generate
    cmp     r0,#13*8+6
    br      eq,generate
    cmp     r0,#13*8+7
    br      eq,generate
    cmp     r0,#13*8+8
    br      eq,generate
    cmp     r0,#13*8+9
    br      eq,generate
    
    jmp     main_loop

generate:
    ; draw pressed button
    mov     r8,#68
    mov     r9,#116
    mov     r10,#187
    mov     r11,#160
    mov     r12,#64
    mov     r13,#24
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; play click
    call    Short_Beep
    
    ; seed the rng
    call    SeedRng
    
    ; generate and draw license
    call    GenLicA
    call    DrawLicA
    call    GenLicB
    call    DrawLicB
    
    ; draw regular button
    mov     r8,#68
    mov     r9,#116
    mov     r10,#123
    mov     r11,#160
    mov     r12,#64
    mov     r13,#24
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph
    
    jmp     main_loop

    ret

DrawLicA:
    push    r11
    push    r10
    push    r9
    
    ; 1st digit
    mov     r8,#4
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph
    
    ; 2nd digit
    mov     r8,#22
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; 3rd digit
    mov     r8,#40
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ret

DrawLicB:
    push    r15
    push    r14
    push    r13
    push    r12
    push    r11
    push    r10
    push    r9
    
    ; 1st digit
    mov     r8,#72
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph
    
    ; 2nd digit
    mov     r8,#90
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; 3rd digit
    mov     r8,#108
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; 4th digit
    mov     r8,#126
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; 5th digit
    mov     r8,#144
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; 6th digit
    mov     r8,#162
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ; 7th digit
    mov     r8,#180
    mov     r9,#72
    mov     r10,#200
    pop     r11
    swap    r11
    mov     r12,#16
    mov     r13,#16
    mov     r14,#21h
    mov     r15,#0
    call    Fi_graph

    ret

; seeds rng with counter
SeedRng:
    movw    rr0,state01
    addw    state23,rr0
    addw    state01,rr2
    
    ret

; returns 8-bit pseudorandom value in r8
RandNum:
    push    r9
    pushw   rr10
    pushw   rr12
    pushw   rr14

    ; retrieve state from memory
    movw    rr10,state01
    movw    rr12,state23

    ; r8 = state0 ^ (state0 << 4)
    mov     r9,r10
    mov     r8,r10
    and     r9,#0fh
    swap    r9
    xor     r8,r9
    
    ; state0 = state1, state1 = state2, state2 = state3
    mov     r10,r11
    mov     r11,r12
    mov     r12,r13
    
    ; r8 = r8 ^ state3 ^ (state3 >> 1) ^ (r8 << 1) 
    mov     r14,r12
    mov     r15,r8
    srl     r14
    sll     r15
    xor     r8,r12
    xor     r8,r14
    xor     r8,r15
    
    ; state3 = r8
    mov     r13,r8
    
    ; store state to memory
    movw    state01,rr10
    movw    state23,rr12
    
    popw    rr14
    popw    rr12
    popw    rr10
    pop     r9
    
    ret

; generates 1st part of license key
GenLicA:
    ; 1st digit
    call    RandNum
    mov     r9,r8
    and     r9,#0fh
    cmp     r9,#10
    br      lt,adig2
    sub     r9,#6

adig2:
    ; 2nd digit
    call    RandNum
    mov     r10,r8
    and     r10,#0fh
    cmp     r10,#10
    br      lt,adig3
    sub     r10,#6

adig3:
    ; 3rd digit
    call    RandNum
    mov     r11,r8
    and     r11,#0fh
    cmp     r11,#10
    br      lt,mul_check
    sub     r11,#6
    
mul_check:
    ; increment/decrement if all numbers equal
    cmp     r9,r10
    br      ne,gen_done
    cmp     r10,r11
    br      ne,gen_done
    cmp     r11,#9
    br      eq,decrem
    inc     r11
    br      gen_done
decrem:
    dec     r11
    
gen_done:
    ret

; generates 2nd part of license key
GenLicB:
    ; 1st digit
    call    RandNum
    mov     r9,r8
    and     r9,#0fh
    cmp     r9,#10
    br      lt,bdig2
    sub     r9,#6

bdig2:
    ; 2nd digit
    call    RandNum
    mov     r10,r8
    and     r10,#0fh
    cmp     r10,#10
    br      lt,bdig3
    sub     r10,#6

bdig3:
    ; 3rd digit
    call    RandNum
    mov     r11,r8
    and     r11,#0fh
    cmp     r11,#10
    br      lt,bdig4
    sub     r11,#6

bdig4:
    ; 4th digit
    call    RandNum
    mov     r12,r8
    and     r12,#0fh
    cmp     r12,#10
    br      lt,bdig5
    sub     r12,#6

bdig5:
    ; 5th digit
    call    RandNum
    mov     r13,r8
    and     r13,#0fh
    cmp     r13,#10
    br      lt,bdig6
    sub     r13,#6

bdig6:
    ; 6th digit
    call    RandNum
    mov     r14,r8
    and     r14,#0fh
    cmp     r14,#10
    br      lt,bdig7
    sub     r14,#6

bdig7:
    ; 7th digit
    call    RandNum
    mov     r15,r8
    and     r15,#7
    inc     r15
    cmp     r15,#8
    br      ne,check_acc
    dec     r15
    
check_acc:
    ; add up license key digits
    movw    rr4,#0
    add     r4,r9
    add     r4,r10
    add     r4,r11
    add     r4,r12
    add     r4,r13
    add     r4,r14
    add     r4,r15
    
    ; check mod 7
    movw    rr6,#7
    div     rr4,rr6
    cmp     r6,#0
    jmp     ne,GenLicB
    
    ret
    
Delay200ms:
    movw    rr0,#0f000h
d200_loop:
    decw    rr0
    br      nz,d200_loop

    ret
    
    end