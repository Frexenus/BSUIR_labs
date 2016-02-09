model small
.stack 100h
.386
.data
           STRING_A DB ' INPUT A: $'
           STRING_B DB ' INPUT B: $'
           STRING_C DB ' INPUT C: $'
           STRING_test DB ' INPUT test: $'

            ;������� ���������� ������������� Ax^2+Bx+C
            a dd ?
            b dd ?
            nb dd ?
            c dd ?
            d dd ?
            two dd 2.0
            four dd 4.0
            kd dd ?
            nkd dd ?
            x1 dd ?
            x2 dd ?
            testkoef dd 7.3

            ;���������� ��� �����

.code
                        start:
                                    mov ax, @data
                                    mov ds, ax

                                call infloat
                                fstp a
                                call infloat
                                fstp b
                                call infloat
                                fstp c
                                ;LEA DX,STRING_test
                                ;MOV AH,09H	;STRING OUT
                                ;INT 21H
                                ;fld testkoef
                                fstp st(0)
                                fstp st(1)
                                fstp st(2)



                                  fld b     ; s(0)=b
                                  fmul b  ;s(0)=b*b
                                  fld a ; s(0) = a, s(1)=b*b
                                  fmul c ;s(0) = a*c, s(1)=b*b
                                  fmul four ;s(0) =4*a*c, s(1)=b*b
                                  fsub  ;s(0) = b*b-4*a*c
                                  fsqrt ;s(0) =sqrt(b*b-4*a*c)
                                  fstp kd  ;�������� ������ ���������� �������������

                                  fstp st(0)    ;st(0)=0
                                  fldz;st(0)=0, st(1)=0
                                  fld b;st(0)=b, st(1)=0
                                  fsub ;st(0)=-b

                                  fstp nb


                                  fstp st(0)    ;st(0)=0
                                  fldz;st(0)=0, st(1)=0
                                  fld kd;st(0)=kd, st(1)=0
                                  fsub ;st(0)=-kd
                                  fstp nkd


                                  fld nb
                                  fld nkd
                                  fadd
                                  fld a
                                  fmul two
                                  fdiv



                                  call outfloat

                                  fld nb
                                  fld kd
                                  fadd
                                  fld a
                                  fmul two
                                  fdiv



                                  call outfloat



                                ;fld a
                                ;fstp st(0)
                                ;call outfloat

                                ;fstp a  ;���������� �� ����� ������ �������� ��������


                                    ;fld testkoef ;�������� ���� ����� ����������(success)
                                    ;call outfloat


                                    ;call outfloat ;�� ������ ��� �����


                                    mov ah, 4ch
                                    int 21h

                                    infloat proc    near
                                        push    ax
                                        push    dx
                                        push    si
                                ; ��������� ���� �����, ����� ������� ������� � ��� �����-������ �����.
                                        push    bp
                                        mov     bp, sp
                                        push    10
                                        push    0
                                ; � SI ������� �����.
                                        xor     si, si
                                ; ����� ����������� �����. ������� ��� ����.
                                        fldz
                                ; ������ ������ ������. ��� ����� ���� �����.
                                        mov     ah, 01h
                                        int     21h
                                        cmp     al, '-'
                                        jne     short @if1
                                ; ���� ��� ������������� �����, ���������� ���
                                ; � ������ ��������� �����.
                                        inc     si
                                @if0:   mov     ah, 01h
                                        int     21h
                                ; ���� ������� �����, �� ���� ����������
                                ; � ������������ ������� �����.
                                @if1:   cmp     al, '.'
                                        je      short @if2
                                ; �� � ���� ���, �� ��������, ��� ����� �����
                                ; (� ��������� ������ �������� ����),
                                        cmp     al, 39h
                                        ja      short @if5
                                        sub     al, 30h
                                        jb      short @if5
                                ; �������� � �� ��������� ������ � �������
                                ; � �������� ���������� ������,
                                        mov     [bp - 4], al
                                ; �� ���� ������� ��� ��������� ����� �� ������
                                        fimul   word ptr [bp - 2]
                                ; � �������� ������ ��� ��������� �����.
                                        fiadd   word ptr [bp - 4]
                                ; � ���, ���� �� �������.
                                        jmp     short @if0
                                ; ���� ��������� ������� ������� �����,
                                ; �� �������� ��������.
                                @if2:   fld1
                                ; ������ �����.
                                @if3:   mov     ah, 01h
                                        int     21h
                                ; ���� ��� �� �����, ������.
                                        cmp     al, 39h
                                        ja      short @if4
                                        sub     al, 30h
                                        jb      short @if4
                                ; ����� ��������� � �� ��������� ������,
                                        mov     [bp - 4], al
                                ; �������� ��������� ������������� ������� �������,
                                        fidiv   word ptr [bp - 2]
                                ; ��������� �,
                                        fld     st(0)
                                ; ��������� �� �������� �����, ��� ����� �������
                                ; � �� ������ �����,
                                        fimul   word ptr [bp - 4]
                                ; � ��������� � �������� ����������.
                                        faddp   st(2), st
                                ; �����-����, ���� �� �������.
                                        jmp     short @if3
                                ; ���� ���� ������� ����� ��������,
                                ; ��� ������ �� ����� ������� �������.
                                @if4:   fstp    st(0)
                                ; ����, �� ������� ����� �������� �������� �����.
                                ; �������� ����� ������ ������� �� ����� ������
                                @if5:   mov     ah, 02h
                                        mov     dl, 0Dh
                                        int     21h
                                        mov     dl, 0Ah
                                        int     21h
                                ; � ��������� ��� ����.
                                        test    si, si
                                        jz      short @if6
                                        fchs
                                @if6:   leave
                                        pop     si
                                        pop     dx
                                        pop     ax
                                        ret
                        infloat endp



                        outfloat proc near
                                        push    ax
                                        push    cx
                                        push    dx
                                ; ��������� ���� �����, ����� ������� � �� �������
                                ; � ��� �����-������ �����.
                                        push    bp
                                        mov     bp, sp
                                        push    10
                                        push    0
                                ; ��������� ����� �� ����, � ���� ��� �������������,
                                        ftst
                                        fstsw   ax
                                        sahf
                                        jnc     @of1
                                ; �� ������� �����
                                        mov     ah, 02h
                                        mov     dl, '-'
                                        int     21h
                                ; � ��������� ������ �����.
                                        fchs
                                ; ��������� ����� ����� �� �������.   ; ST(0) ST(1) ST(2) ST(3) ...
                                ; ������� ����� ����� �� �������.      ; 73.25 ... ���-�� �� ����
                                @of1:   fld1                           ;  1    73.25 ...
                                        fld     st(1)                  ; 73.25  1    73.25 ...
                                ; ������� �� ������� �� ������� ���� ������� �����.
                                        fprem                          ;  0.25  1    73.25 ...
                                ; ���� ������� � �� ��������� �����, ��������� ����� �����.
                                        fsub    st(2), st              ;  0.25  1    73    ...
                                        fxch    st(2)                  ; 73     1     0.25 ...
                                ; ������� ���������� � ����� ������. ������� ���������� ���� ����� � CX.
                                        xor     cx, cx
                                ; ������� ����� ����� �� ������,
                                @of2:   fidiv   word ptr [bp - 2]      ;  7.3   1     0.25 ...
                                        fxch    st(1)                  ;  1     7.3   0.25 ...
                                        fld     st(1)                  ;  7.3   1     7.3   0.25 ...
                                ; ������� ������� ����� - ��������� ������ ����� ����� ����� ��������� �����,-
                                        fprem                          ;  0.3   1     7.3   0.25 ...
                                ; �� �������� ������� ������ ����� �����
                                        fsub    st(2), st              ;  0.3   1     7     0.25 ...
                                ; � �������� �����
                                        fimul   word ptr [bp - 2]      ;  3     1     7     0.25 ...
                                        fistp   word ptr [bp - 4]      ;  1     7     0.25 ...
                                        inc     cx
                                ; � �����.
                                        push    word ptr [bp - 4]
                                        fxch    st(1)                  ;  7     1     0.25 ...
                                ; ��� ����� ���������, ���� �� ����� ����� �� ��������� ����.
                                        ftst
                                        fstsw   ax
                                        sahf
                                        jnz     short @of2
                                ; ������ ������� �.
                                        mov     ah, 02h
                                @of3:   pop     dx
                                ; ����������� ��������� �����, ��������� � � ������ � �������.
                                        add     dl, 30h
                                        int     21h
                                ; � ���, ���� �� ������� ��� �����.
                                        loop    @of3                   ;  0     1     0.25 ...
                                ; ����, ������ �������� �� ������� �����, ��� ������ �������� � �������������.
                                        fstp    st(0)                  ;  1     0.25 ...
                                        fxch    st(1)                  ;  0.25  1    ...
                                        ftst
                                        fstsw   ax
                                        sahf
                                        jz      short @of5
                                ; ���� ��� ��-���� ���������, ������� �����
                                        mov     ah, 02h
                                        mov     dl, '.'
                                        int     21h
                                ; � �� ����� ����� ���� ������� �����.
                                        mov     cx, 6
                                ; �������� �������� ����� �� ������,
                                @of4:   fimul   word ptr [bp - 2]      ;  2.5   1    ...
                                        fxch    st(1)                  ;  1     2.5  ...
                                        fld     st(1)                  ;  2.5   1     2.5  ...
                                ; ������� ����� ����� - ��������� ����� ����� ������� ����� ��������� �����,-
                                        fprem                          ;  0.5   1     2.5  ...
                                ; ������� �� ������������ ���� ������� �����,
                                        fsub    st(2), st              ;  0.5   1     2    ...
                                        fxch    st(2)                  ;  2     1     0.5  ...
                                ; �������� ���������� ����� �� ��������� ������
                                        fistp   word ptr [bp - 4]      ;  1     0.5  ...
                                ; � ����� �������.
                                        mov     ah, 02h
                                        mov     dl, [bp - 4]
                                        add     dl, 30h
                                        int     21h
                                ; ������, ���� ������� ������� ����� ���������
                                        fxch    st(1)                  ;  0.5   1    ...
                                        ftst
                                        fstsw   ax
                                        sahf
                                ; � �� ������ ����� ����� ����, ���������.
                                        loopnz  @of4                   ;  0     1    ...
                                ; ����, ����� ��������. �������� ������ ����� �� �����.
                                @of5:   fstp    st(0)                  ;  1     ...
                                        fstp    st(0)                  ;  ...
                                ; ������, ������.
                                        leave
                                        pop     dx
                                        pop     cx
                                        pop     ax
                                        ret
                        outfloat endp



                        end start
