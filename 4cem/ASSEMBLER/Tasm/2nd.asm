model small
.stack 100h
.386
.data
           STRING_A DB 10,13, ' INPUT A: $'
           STRING_B DB ' INPUT B: $'
           STRING_H DB ' INPUT H: $'
           STRING_EPS DB ' INPUT EPS: $'

           STRING_XE DB ' X = $'
           STRING_YE DB ' Y(x) = $'

           STRING_KE DB ' K = $'
           STRING_SE DB ' S(x) = $'
           STRING_ENT DB 10, 13, '$'
           STRING_TAB DB 9, '$'
           STRING_D db 10,13, ' D  = $'
           STRING_CONT db 10,13, ' Continue y/n?    $'
           STRING_NOTKVADR db 10,13, ' Format error. Enter correct format     $'


                                                                                ;������� ����������
            a dd ?
            b dd ?
            h dd ?
            eps dd ?
            s dd ?
            y dd ?
            x dd ?
            tmpx dd ?
            tmpk dd ?
            tmps dd ?
            k dd 0.0
            one dd 1.0
            two dd 2.0
            minusone dd -1.0
            twokplusone dd ?
            fact_twokplusone dd ?
            tmptwokplus dd ?
            ten dd 10.0

.code
        start:
        mov ax, @data                                                           ;������� ������� � �������
        mov ds, ax                                                              ;� ������� ���� DS
        finit
        ;fstp	st(1)          ; ������� st1
        org 100h
        mov  ax,2
        int  10H                                                                ;��������� ����������� 80x25

        lea dx,STRING_A                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A

        call infloat
        fstp a
        lea dx,STRING_B                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A

        call infloat
        fstp b

        lea dx,STRING_H                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A
        call infloat
        fstp h

        lea dx,STRING_EPS                                                       ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A
        call infloat
        fld ten
        fdiv
        fstp eps





        fld a
        fstp x


        xplush:


        lea dx,STRING_XE                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A
        fld x
        call outfloat
        lea dx,STRING_TAB                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A
        lea dx,STRING_YE                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A

        fld x
        call sinFPU

        kplusone:
        ;sum goes here
        fld one
        fld k
        fadd
        fstp k

        fld k

        call sintail            ;st(0) = sintail

        fld s
        fld y                   ;st(0) = sinfpu; st(1) = sintail
        fsub                    ;st(0) = sinfpu-sintail
        fabs                    ;st(0) = ABS(sinfpu-sintail)
        fld eps                 ;st(0) = eps; st(1) =  ABS(sinfpu-sintail)
        fsub
        ftst
        fstsw ax
        sahf
        jnc kplusone

        lea dx,STRING_TAB                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A

        lea dx,STRING_KE                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A
        fld k
        call outfloat
        lea dx,STRING_TAB                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A

        lea dx,STRING_SE                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A
        fld s
        call outfloat
        lea dx,STRING_ENT                                                         ;�����
        mov ah,09h	                                                        ;���������
        int 21h                                                                 ;INPUT A



        fld x
        fld h
        fadd
        fstp x
        fld x
        fld b
        fsub

        ftst
        fstsw ax
        sahf
        fldz
        fstp k  ;�������� k

        jc xplush










        mov ah, 4ch                                                             ;������� � ah ��� ��������� ��� ������ �� ���������
        int 21h                                                                 ;�����������







        sintail proc ;�� ����� ������ K(st0 = k)
        fld k
        fldz ;st0 0 st1 k st2 k
        fxch ;st0 k st1 0 st2 k
        fld x   ;st0 x  st1 k   st2 sum  st3 k            (� st2 ����� ����� st3 ����� �������)

        sumcalculating:

        fstp tmpx
        fstp tmpk
        fstp tmps

        fld tmpk
        fld two
        fmul
        fld1
        fadd
        fstp twokplusone

        fcom minusone
        fstsw ax
        sahf
        je sumcalculatingETX
        fld tmps
        fld tmpk
        fld tmpx

        fld twokplusone                                                         ;st0 twokplusone st1 x st2 sum st3 k
        fxch                                                                    ;st0 x st1 twokplusone st2 sum st3 k
        xpowtwokplusone:
        fxch                                                                    ;st0 twokplusone st1 x
        fcom one
        fstsw ax                                                                ;��������� � ���� ���� �����, �� ������
        sahf
        fxch                                                                    ;st0 x st1 twokplusone st2 sum st3 k
        je xpowtwokplusoneEXT
        fld x                                                                   ;st0 x st1 x st2 twokplusone st3 sum st4 k
        fmul                                                                    ;st0 pow(x) st1 twokplusone st2 sum st3 k
        fxch    ;st0 twokplusone st1 pow(x)
        fst tmptwokplus
        fdiv
        fld tmptwokplus
        fld1
        fsub    ;st0 twokplusone-1 st1 -pow(x)
        fxch    ;st0 -pow(x) st1 twokplusone-1
        jmp xpowtwokplusone
        xpowtwokplusoneEXT:                                                     ;st0 pow(x) st1 0 st2 sum st3 k
        fxch                                                                    ;st0 0 st1 pow(x) st2 sum st3 k
        fstp st(0)

        xminus:
        fxch            ;���� � � ��������� �� ����
        ftst
        fstsw ax         ;��������� � ���� ���� �����, �� ������
        sahf
        je xminusexit   ;if k = 0 then exit
        fxch
        fchs  ;st0 -x st1 k
        fxch    ;st0 k st1 -x
        fld1
        fsub    ;st0 k-1 st1 -x
        fxch    ;st0 -x st1 k-1
        jmp xminus
        xminusexit:                                                             ;st0 x st1 0 st2 sum st3 k
        fstp st(0)                                                              ;st0 x st1 sum st2 k ;������� �����

        fadd                                                                    ;st(0) sum st1 k
        fxch
        fld1
        fsub                                                                    ;st0 k-1 st1 sum
        fst tmpk

        fxch                                                                    ;st0 sum st1 k-1

        fld tmpk                                                                ;st0 k-1 st1 sum st2 k-1
        fld x                                                                   ;st0 x st1 k st2 sum st3 k-1
        jmp sumcalculating                                                      ;st0 x st1 k st2 sum st3 k-1
        sumcalculatingETX:
        fld tmps
        fst s

        ;call outfloat
        ret
        sintail endp










        sinFPU proc

        fsin
        fstp y
        fld y
        call outfloat


        ret
        sinFPU endp

            infloat proc    near
                push    ax                                                      ;���������� �������� ax
                push    dx                                                      ;�������� dx
                push    si                                                      ;�������� si
                                                                                ;���������  ����, ����� ������� ������� � ��� �����-������ �����.
                push    bp                                                      ;�������� bp
                mov     bp, sp                                                  ;�������� � bp ��������� �����
                push    10                                                      ;������� � ����  10
                push    0                                                       ;������� � ����  0
                xor     si, si                                                  ; � SI �������� ����.

                                                                                ; ����� ����������� �����. ������� ��� ����.
                fldz
                mov     ah, 01h                                                 ;������ ������ ������
                int     21h                                                     ;����� ������ ������� 21�� ����������
                cmp     al, '-'                                                 ;���������� �������� �������� � �������� "-"
                jne     short @if1                                              ;���� "-" �� ����������, ���� ��� �� ��������� ��������� �������
                inc     si                                                      ;����������� ����� � �������� si
        @if0:
                mov     ah, 01h                                                 ;������  ������
                int     21h                                                     ;����� ������ ������� 21�� ����������


        @if1:
                cmp     al, '.'                                                 ;���� ������� �����, ��
                je      short @if2                                              ;��������� ������� �����


                cmp     al, 39h                                                 ;���������
                ja      short @if5                                              ;��� ������ �����,
                sub     al, 30h                                                 ;� � ������ ���� �������� �� �����,
                jb      short @if5                                              ;�� ��������� �� ����� ����������� ����
                                                                                ;�������� � �� ��������� ������ � �������
                                                                                ; � �������� ���������� ������,
                mov     [bp - 4], al                                            ;���������� �������� ����� � ������
                fimul   word ptr [bp - 2]                                       ;�������� ���� ����� �� 10
                fiadd   word ptr [bp - 4]                                       ;������� � ����� ����� �������� �����
                jmp     short @if0                                              ;���������
        @if2:                                                                   ;����� ���������� ������� �����
         fld1                                                                   ;�������� � ���� ����� �������
        @if3:
                mov     ah, 01h                                                 ;���������
                int     21h                                                     ;������

                cmp     al, 39h                                                 ;���������
                ja      short @if4                                              ;��� ������ �����,
                sub     al, 30h                                                 ;� � ������ ���� �������� �� �����,
                jb      short @if4                                              ; �� ��������� �� ����� ����������� ����

                mov     [bp - 4], al                                            ;����� ��������� � �� ��������� ������,
                fidiv   word ptr [bp - 2]                                       ;�������� ��������� ������������� ������� �������,
                fld     st(0)                                                   ;���������� � � ����
                fimul   word ptr [bp - 4]                                       ;��������� �� �������� �����, ��� ����� ������� � �� ������ �����
                faddp   st(2), st                                               ;� ��������� �  ����������.
                jmp     short @if3                                              ;���������


        @if4:
        fstp    st(0)                                                           ;�� ������� ����� �������� �������� �����.
        @if5:
                mov     ah, 02h                                                 ;����� �� �����
                mov     dl, 0Dh                                                 ;������� �������
                int     21h
                test    si, si                                                  ;���������  ������� �����
                jz      short @if6                                              ;���� ����  �� ����
                fchs                                                            ;�� ������ � ����� ����
        @if6:   leave
                pop     si                                                      ;��������������� ������� si
                pop     dx                                                      ;��������������� ������� dx
                pop     ax                                                      ;��������������� ������� ax
                ret
        infloat endp



        outfloat proc near
                push    ax                                                      ;��������� ������� ��
                push    cx                                                      ;������� cx
                push    dx                                                      ;������� dx
                push    bp                                                      ;������� bp
                mov     bp, sp                                                  ;�������� � bp ��������� �����
                push    10                                                      ;������� � ����  10
                push    0                                                       ;������� � ����  0

                ftst                                                            ;��������� ����� �� ����, � ���� ��� �������������
                fstsw   ax                                                      ;��������� �����
                sahf                                                            ;�������� �������� �������� ah � ������� ���� ��������� ��������.
                jnc   @of1                                                      ;��������� ���������

                mov     ah, 02h                                                 ;�������
                mov     dl, '-'                                                 ;�����
                int     21h
                fchs                                                            ;���� ������ �����

        @of1:
                fld1
                fld     st(1)
                fprem                                                           ;������� �� ������� � ������� �����
                fsub    st(2), st                                               ;�������� �� ��������� �����
                fxch    st(2)                                                   ;������ �������
                xor     cx, cx                                                  ;������� cx ��� ����, ����� ������� ���������� ���� �� �������
                                                                                ;������� ����� ����� �� ������,
        @of2:
                fidiv   word ptr [bp - 2]                                       ;������� �� 10 �������
                fxch    st(1)                                                   ;�������� ������� ������� � 1� �������
                fld     st(1)                                                   ;�����  1  �����  �����

                fprem                                                           ;����� ���� ������� �� �������

                fsub    st(2), st                                               ;� �� ������������ ������� ��������� ������ ����� �����

                fimul   word ptr [bp - 2]                                       ;�������� ���� ������� �� 10
                fistp   word ptr [bp - 4]                                       ;�������� ����� �� ��������� ������ ������� �����.�� ����� ������� � ����� � ����� �������
                                                                                ;������ � ����� �������� � ������� 1 , 1-� ����� ����� ��� ������ ������� �������� ����� � �����, 2-� �����
                inc     cx                                                      ;�������� �������, ����� ����� ������� ������� ���� �� �����.
                push    word ptr [bp - 4]                                       ;�����������
                fxch    st(1)                                                   ;������ ������� ������� � ������ �������, ����� ������ ������ ����

                ftst                                                            ;����������� �� ����
                fstsw   ax                                                      ;��������� �����
                sahf                                                            ;�������� ����
                jnz     short @of2                                              ;��� ����� ���������, ���� �� ����� ����� �� ��������� ����.

                mov     ah, 02h                                                 ;������� �����
        @of3:                                                                   ;����� ��� ������ ��� ���� ����� �� ������� �� �����
                pop     dx                                                      ;����������� ��������� �����, ��������� � � ������ � �������.
                add     dl, 30h
                int     21h
                loop    @of3                                                    ;� ���, ���� �� ������� ��� ����� �������� ���� cx
                                                                                ;������ � ������� ������
                fstp    st(0)
                fxch    st(1)                                                   ;�������� �������
                ftst                                                            ;�������� ������� ������� �����
                fstsw   ax
                sahf
                ;jz      short @of5                                              ; ���� � ��� �� ��� �� �����



                mov     ah, 02h
                mov     dl, '.'                                                 ; ���� ��� ��-���� ���������, ������� �����
                int     21h
                mov     cx, 6                                                   ;�������� 6���� ����� �������

        @of4:
                fimul   word ptr [bp - 2]                                       ;�������� �������� ����� �� ������ (������� � ���, ��� �� �������� �� 10, � �� �����)
                fxch    st(1)                                                   ;�� �� �������� ��� � � ������
                fld     st(1)                                                   ;������ � ���� ����������� �� 10 �����

                fprem                                                           ; ������� ����� �����
                fsub    st(2), st                                               ; ������� �� ����������� �� 10����� ���� ������� �����
                fxch    st(2)                                                   ;�������� ������� ���� � ������ �������

                fistp   word ptr [bp - 4]                                       ; �������� ���������� ����� �� ��������� ������, ����� ����� ���� ����� � ��� ��������
                mov     ah, 02h                                                 ; � ����� �������.
                mov     dl, [bp - 4]
                add     dl, 30h
                int     21h

                fxch    st(1)                                                   ;����� ��������� �� ������� ���� � �������
                ftst                                                            ;(������������ ����� ������ ��� ����,
                fstsw   ax                                                      ; ������ ��� ��� �������������� �������� ����� ����� ������������� )
                sahf
                loopnz  @of4                                                    ;���� �� ������� 6 ���� (������� CX)

        @of5:
                fstp    st(0)                                                   ;������� ������� �����
                fstp    st(0)
                leave
                pop     dx                                                      ;��������������� ��� ��������
                pop     cx
                pop     ax
                ret

        outfloat endp
        end start
