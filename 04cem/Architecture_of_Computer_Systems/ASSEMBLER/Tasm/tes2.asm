model small
.stack 100h
.386
.data
            STRING_TAB DB  '    ----->    $'

            tmph dd 0.01
            tmpa dd 0.02
.code

start:
mov ax, @data                                                           ;������� ������� � �������
mov ds, ax                                                              ;� ������� ���� DS
finit
                                                                        ;fstp	st(1)          ; ������� st1
org 100h
mov  ax,2
int  10H                                                                ;��������� ����������� 80x25







call infloat ;enter 0.01



call infloat ;enter 0.02


fadd

call outfloat ;compare


lea dx,STRING_TAB
mov ah,09h
int 21h
fld tmph
fld tmpa
fadd
call outfloat ;compare
                ;i want to see 0.3  -  0.3


mov ah, 4ch                                                             ;������� � ah ��� ��������� ��� ������ �� ���������
int 21h                                                                 ;�����������








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

                                                                    ; ������ ����������� �����. ������� ��� ����.
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
    mov     cx,                                                    ;�������� 6���� ����� �������

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
