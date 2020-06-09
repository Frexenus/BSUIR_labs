
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
            tmpx dd ?
            tmpk dd ?
            tmps dd ?
            x dd 0.53333
            k dd 2.0
            twokplusone dd ?
            one dd 1.0
            two dd 2.0
            minusone dd -1.0
            tmptwokplus dd ?
            fact_twokplusone dd ?

.code
        start:
        mov ax, @data                                                           ;������� ������� � �������
        mov ds, ax                                                              ;� ������� ���� DS


        finit
        fld k
        call sintail
        fld x
        call sinFPU




        mov ah, 4ch                                                             ;������� � ah ��� ��������� ��� ������ �� ���������
        int 21h                                                                 ;�����������




        sinFPU proc

        fsin
        fstp y
        fld y
        call outfloat


        ret
        sinFPU endp




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


call outfloat
ret
sintail endp



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
        mov     cx, 8                                                   ;�������� 6���� ����� �������

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
