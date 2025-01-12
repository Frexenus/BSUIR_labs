include	pmode_6.lib
;---------------------------------------------------------------------------
.386p
pmode segment use16
	assume	cs:pmode, ds:pmode, es:pmode

	org	100h

main		proc	far
start:
;----------------------------------------------------------------------------
;----------------------------------------------------------------------------
; ��।��塞 ᥫ����� ��� ����⠭��. � ��� � ��� ���� TI = 0 (�롮ઠ
; ���ਯ�஢ �ந�������� �� GDT), RPL = 00B - �஢��� �ਢ������ - �㫥���.

IDT_descr_max_n	= 20h	; ��᫮ ���ᨬ��쭮 �ᯮ��㥬�� ���ਯ�஢ �
			;  ��⥬� (�� ���樠����樨 ��।����� ⮫쪮
			;  ���� 6).

IDT_descr_n	= 32h	; ��᫮ ���ਯ�஢ � IDT (20h - ��� �᪫�祭��,
			;  10h - ��� IRQ � 2 - ��� �ணࠬ���� ���뢠���)


Code_selector	=  8
Stack_selector	= 16
Data_selector	= 24
Screen_selector = 32
R_Mode_Code	= 40
R_Mode_Data	= 48
;----------------------------------------------------------------------------

	call	store_R_Mode_IRQ_Mask

	call	what_cpu

	mov	R_Mode_SS,ss
	mov	R_Mode_DS,ds
	mov	R_Mode_ES,es
	mov	R_Mode_FS,fs
	mov	R_Mode_GS,gs

	mov	R_Mode_segment,cs
	lea	ax,R_Mode_entry
	mov	R_Mode_offset,ax

	mov	bx,offset GDT + 8
	xor	eax,eax
	mov	edx,eax

	push	cs
	pop	ax

	shl	eax,4
	mov	dx,0FFFFh		; �।�� ᥣ���� ���� = 64� - 1
	mov	cl,10011000b
	call	set_descriptor		; Code

	lea	dx,Stack_seg_start
	add	eax,edx
	mov	dx,1024
	mov	cl,10010110b
	call	set_descriptor		; Stack

	xor	eax,eax
	mov	ax,ds
	shl	eax,4
	mov	dx,0ffffh
	mov	cl,10010010b
	call	set_descriptor		; Data

	mov	eax,0b8000h
	mov	edx,4000
	mov	cl,10010010b
	call	set_descriptor

; ��⮢�� �������⥫�� ���ਯ��� ��� ������ � R-Mode:

	xor	eax,eax

	push	cs
	pop	ax

	shl	eax,4

	mov	edx,0ffffh
	mov	cl,10011010b
	call	set_descriptor		; R_Mode_Code

	mov	cl,10010010b
	call	set_descriptor		; R_Mode_Data

; ��⠭�������� IDTR:

	xor	eax,eax
	mov	edx,eax
	mov	ax,ds
	shl	eax,4		; �AX = 䨧��᪨� ���� ᥣ���� ������

	lea	dx,IDT
	add	edx,eax
	mov	IDT_adr,edx

	mov	dx,IDT_descr_n * 8 - 1
	mov	IDT_lim,dx

; ��⠭�������� GDTR:

	lea	dx,GDT
	add	edx,eax
	mov	GDT_adr,edx

	mov	dx,63		; �।�� GDT = 8 * (1 + 7) - 1
	mov	GDT_lim,dx

	cli

	lidt	IDTR
	lgdt	GDTR

	mov	R_Mode_SP,sp

; ���室�� � ������ ०��:

	mov	eax,cr0
	or	al,1
	mov	cr0,eax


; ������ � ����񭭮� ०���

	db	0eah
	dw	P_Mode_entry
	dw	Code_selector

;----------------------------------------------------------------------------
P_Mode_entry:

	mov	ax,Screen_selector
	mov	es,ax

	mov	ax,Data_selector
	mov	ds,ax

	mov	ax,Stack_selector
	mov	ss,ax
	mov	sp,0

; �뢮��� ZS-��ப�:

	mov	text_color,1bh

	lea	bx,Start_P_Mode_ZS
	mov	dx,0300h
	call	put_zs

; ����� �ணࠬ�� � ����񭭮� ०��� (����� - ⮫쪮 �뢮� ��ப�):

	call	P_Mode_redirect_IRQ

	call	setup_IDT

	lea	bx,P_Mode_ZS
	mov	dx,0400h
	call	put_zs

; ���������� ࠡ��� ���뢠��� �� ⠩����

	in	al,21h
	and	al,11111100b	; �����᪨�㥬 ���뢠��� ⠩���
				;  � ����������.
	out	21h,al

	mov	al,0
	mov	timer_count,al		; ����뢠�� ��� ����稪�
	mov	timer_sec,al

	xor	eax,eax		; ��᫮ � EAX �㤥� �뢮����� �� ��࠭
				;  � ��᪮��筮� 横��.

	sti		; ����蠥� ������� ���뢠���. ������ ���
			;  ��᪮���� 横� �㤥� "ࢠ����" ⠩��஬ �
			;  ��������ன � ������� ⮫쪮 ᫥���� ��
			;  ����稪���.
timer_demo_start:

	mov	dx,1400h	; � 20-� ��ப�, �㫥��� ������ ...
	call	put_dd_num	; ... �㤥� �뢮����� dd-�᫮.
	inc	eax		; � ����� ��� 㢥��稢�����.

	cmp	timer_count,18
	jb	timer_demo_start	; �뢮��� �᫮, ���� timer_count < 18

	mov	timer_count,0		; timer_count ���⨣ 18.
					;  ����뢠�� ���.

	push	ax
	mov	al,timer_sec
	inc	al
	mov	timer_sec,al
	mov	dx,1410h
	call	put_db_num		; �뢮��� �᫮ ᥪ㭤.

	pop	ax

	cmp	timer_sec,4
	jbe	timer_demo_start	; �த������ 横�, �᫨ timer_sec < 4

	jmp	Return_to_R_Mode

;----------------------------------------------------------------------------
Return_to_R_Mode:

	cli

	call	R_Mode_redirect_IRQ

	xor	eax,eax
	mov	IDT_adr,eax
	dec	ax		; AX = -1 = FFFFh
	mov	IDT_lim,ax

; �����頥��� � ०�� ॠ���� ���ᮢ.

	db	0eah
	dw	Pre_R_Mode_entry
	dw	R_Mode_Code

Pre_R_Mode_entry:
	mov	ax,R_Mode_Data
	mov	ss,ax
	mov	ds,ax
	mov	es,ax
	mov	fs,ax
	mov	gs,ax

	lidt	IDTR

; 4. ������ 䫠� PE � CR0.

	mov	eax,cr0
	and	al,0feh
	mov	cr0,eax

; 5. �믮����� ������� far jump �� �ணࠬ�� ०��� ॠ���� ���ᮢ.

		db	0eah
R_Mode_offset	dw	?
R_Mode_segment	dw	?

R_Mode_entry:
; 6. ����㧨�� � ॣ����� SS, DS, ES, FS � GS ����室��� ���祭�� ��� 0.

	mov	ss,R_Mode_SS
	mov	ds,R_Mode_DS
	mov	es,R_Mode_ES
	mov	fs,R_Mode_FS
	mov	gs,R_Mode_GS

; 7. ������� ���뢠��� (STI).

	mov	sp,R_Mode_SP

	sti

; �뢮��� ZS-��ப� "Back to real address mode..."

	lea	bx,R_Mode_ZS
	mov	ax,0b800h
	mov	es,ax
	mov	di,800
	call	putzs

	exitcode 0

	int	20h

;----------------------------------------------------------------------------
what_cpu	proc	near
; ��।������ ⨯� ������ � ������ � �� APIC.

	pushf
	pop	ax

	or	ah,0f0h		; ��⠭�������� ���� 12..15 � FLAGS

	push	ax
	popf

	pushf
	pop	ax

	mov	al,ah
	shr	al,4
	and	al,1111b	; ���뢠�� ���� 3..7

	cmp	al,1111b
	je	wcpu_1

	cmp	al,0
	je	wcpu_2

	cmp	al,0111b
	je	wcpu_3


wcpu_1:
; ������ - 8086
; �ணࠬ�� ࠡ���� �� �㤥�

wcpu_2:
; ������ - i286
; �ணࠬ�� ⮦� ࠡ���� �� �㤥�

	int	20h		; ������ � MS-DOS.

wcpu_3:
; 32-ࠧ�來� ������

	pushfd
	pop	eax
	mov	edx,eax
	mov	ebx,eax		; �����

	btc	eax,18		; �������㥬 ��� 18
	push	eax
	popfd

	pushfd
	pop	eax

	mov	ecx,40000h	; ��⠭�������� � ECX 18-� ���
	and	eax,ecx		; ����塞 � EAX � EDX �� ����, �஬� 18.
	and	edx,ecx

	cmp	eax,edx
	je	wcpu_3_1

	shl	ecx,3		; � ECX ��⠭����� ⮫쪮 21-� ���

	mov	eax,ebx
	btc	eax,21		; �������㥬 ��� 21

	push	eax
	popfd

	pushfd
	pop	eax

	and	eax,ecx		; ����塞 � EAX � EBX �� ����, �஬� 21.
	and	ebx,ecx

	cmp	eax,ebx
	jne	wcpu_4

; ������ - ࠭�� ����� i486, �� �����ন����� ������� CPUID

wcpu_3_1:
; ������ - i386

	mov	al,0
	jmp	wcpu_end

wcpu_4:
; ������ ����� �믮����� ������� CPUID

	xor	ecx,ecx
	mov	cl,1		; ECX = 1 - ����� ����� ������� CPUID
	db	0fh, 0a2h	; ��� ������� CPUID

; EDX = ���ଠ�� � �孮������ (Feature Information)

	test	dh,10b		; 9-� ��� EDX ��⠭����� ?
	jne	wcpu_5

	mov	al,0
	jmp	wcpu_end

wcpu_5:
	mov	al,1

wcpu_end:
	mov	APIC_presence,al

	ret

endp
;----------------------------------------------------------------------------
stopper:
; AL = ����� �᪫�祭��
; CF = 1/0 - ��� �訡�� ���� / ���

	mov	text_color,1ah
	mov	cl,al		; ���࠭塞 � CL ����� �᪫�祭��

	mov	al,0		; AL = �ਧ��� ������ ���� �訡��
				;  (1/0 - ���� / ���).
	jnc	stop_1

	mov	al,1

stop_1:
	xor	ebx,ebx
	mov	bx,ss		; EBX = BX = ᥫ���� �⥪�
	lar	edx,ebx		; EDX = ����� �������� ���ਯ��
				;  ᥣ���� �⥪�.
	shr	edx,22
	test	dl,1		; �஢��塞 ��� D (ࠧ��୮��� ᥣ����
				;  16 ��� 32 ���).
	jnz	stop_3

 ; �⥪ - 16-ࠧ�來�

	cmp	al,1		; ��� �訡�� ����?
	jne	stop_2

	pop	ax		; Error code
	mov	dx,0747h
	call	put_dw_num

stop_2:
	pop	ax		; IP
	mov	dx,0647h
	call	put_dw_num

	pop	ax		; CS
	mov	dx,0547h
	call	put_dw_num

	pop	ax		; FLAGS
	mov	dx,0447h
	call	put_dw_num

	jmp	stop_5

stop_3:
 ; �⥪ - 32-ࠧ�來�

	cmp	al,1		; ��� �訡�� ����?
	jne	stop_4

	pop	eax		; Error Code
	mov	dx,0747h
	call	put_dd_num

stop_4:
	pop	eax		; EIP
	mov	dx,0647h
	call	put_dd_num

	pop	eax		; CS
	mov	dx,0547h
	call	put_dd_num

	pop	eax		; EFLAGS
	mov	dx,0447h
	call	put_dd_num

stop_5:
	mov	text_color,1fh

	mov	dx,0347h
	mov	al,cl
	call	put_db_num	; �뢮��� ����� �᪫�祭��, ��।���� �
				;  ��楤��� � ॣ���� AL.

	mov	text_color,1bh

	lea	bx,exept_mess_1
	mov	dx,033bh
	call	put_zs		; "Exeption:"

	mov	dx,043bh
	call	put_zs		; "EFLAGS:"

	mov	dx,053bh
	call	put_zs		; "CS:"

	mov	dx,063bh
	call	put_zs		; "EIP:"

	mov	dx,073bh
	call	put_zs		; "Error Code:"

	jmp	Return_to_R_Mode	; ��室 � R-mode

;----------------------------------------------------------------------------
put_db_num	proc	near
; �뢮� � ��⭠����筮� ���� db-�᫠ � ��ਡ�⮬ text_color � ������ X,Y.
; AL = �᫮
; DX = ������ �뢮��: DL = X, DH = Y
; ������: DL += 2

	push	eax
	push	cx
	push	dx
	push	di
	push	es

	call	get_adr		; �८�ࠧ������ ���न��� �뢮�� (DX) � ����
				;  ���������� (ES:DI).

	mov	dl,al		; �६���� ��࠭塞 �뢮����� �᫮

	and	al,0fh		; AL = ����訩 hex-ࠧ�� �᫠.
	cmp	al,9		; �᫨ �᫮ ����� 0Ah, � ������塞 �
				;  ���� 30h, ���� - 37h.
	jbe	pdbn_1

	add	al,7

pdbn_1:
	add	al,30h
	mov	ah,text_color

	shl	eax,16		; ���頥� ��⮢� ��ਡ�� � ᨬ��� � ������
				;  ���� EAX ��� ⮣�, �⮡� ��⮬ �����
				;  �������� �뢥�� ��� ᨬ����.

	mov	al,dl
	shr	al,4		; AL = ���訩 hex-ࠧ�� �뢮������ �᫠.

	cmp	al,9		; �᫨ �᫮ ����� 0Ah, � ������塞 �
				;  ���� 30h, ���� - 37h.
	jbe	pdbn_2

	add	al,7

pdbn_2:
	add	al,30h
	mov	ah,text_color

	mov	es:[ di ],eax	; �뢮��� ��� ᨬ���� �� ��࠭.

	pop	es
	pop	di
	pop	dx
	pop	cx
	pop	eax

	add	dl,2		; �����稢��� ���न���� �뢮�� X �� 2, ���
				;  ���ᯥ祭�� "��⮬���᪮��" ��ॢ���
				;  ⥪�饩 ����樨 �뢮��.
	ret

endp
;----------------------------------------------------------------------------
put_dw_num	proc	near
; �뢮� � ��⭠����筮� ���� dw-�᫠ � ��ਡ�⮬ text_color � ������ X,Y.
; AX = �᫮
; DX = ������ �뢮��: DL = X, DH = Y
; ������: DL += 4

	ror	ax,8		; �����﫨 ���⠬� AL � AH.
	call	put_db_num	; �뢮��� ᮤ�ন��� AL - �� ���� ���
				;  ����� ࠧ�鸞 4-ࠧ�來��� dw hex-�᫠.
	ror	ax,8		; �����﫨 ���⭮ ���⠬� AL � AH.
	call	put_db_num	; �뢮��� ��� ������ ࠧ�鸞 ��������� �᫠

	ret

endp
;----------------------------------------------------------------------------
put_dd_num	proc	near
; �뢮� � ��⭠����筮� ���� dd-�᫠ � ��ਡ�⮬ text_color � ������ X,Y.
; EAX = �᫮
; DX = ������ �뢮��: DL = X, DH = Y
; ������: DL += 8

	ror	eax,16		; ��⮢�� ��� �뢮�� ������ ���� dd-�᫠
	call	put_dw_num	; ... � �뢮��� ��.
	ror	eax,16		; ��⮢�� ��� �뢮�� ������� ���� dd-�᫠
	call	put_dw_num	; ... �뢮��� � ��.

	ret

endp
;----------------------------------------------------------------------------
get_adr		proc	near
; �८�ࠧ������ ���न��� �뢮�� � ����
; DX = ������ �뢮��: DL = X, DH = Y
; ������: ES:DI = ���� �뢮�� � ���������� ⥪�⮢��� ०���

	push	dx

	mov	di,Screen_selector
	mov	es,di

	movzx	di,dl		; DI = DL
	add	di,di		; DI = DI*2 = DL*2
	movzx	dx,dh		; DX = DH
	shl	dx,5
	add	di,dx
	shl	dx,2
	add	di,dx		; DI += DX * 2^5 + DX * 2^7
				;  ��� DI += DX * 160.
	pop	dx

	ret

endp
;----------------------------------------------------------------------------
put_zs	proc	near
; �뢮� ZS-��ப� (ZS = Zero-String - ��ப�, ����稢������ ���)
; ��६����� text_color ᮤ�ন� ��ਡ�� 梥� ��� �뢮��.
; DS:BX = ��ப�
; ������: DL += ����� ��ப�
;	   DS:BX 㪠�뢠�� �� ᫥���騩 ��᫥ 0 ����.

	push	ax

	mov	ah,text_color
	call	get_adr		; �८�ࠧ������ ���न��� �뢮�� � ����
				;  ����������.
pzs_start:
	mov	al,[ bx ]
	inc	bx
	cmp	al,0		; ������ ��� �뢮�� = 0?
	je	pzs_end		; �᫨ ��, � ��室...

	stosw			; ... ���� - �뢮� �� ��࠭.
	jmp	pzs_start

pzs_end:
	pop	ax

	ret

endp
;----------------------------------------------------------------------------
store_R_Mode_IRQ_Mask	proc	near
; ���࠭�� ���祭�� ��᪨ IRQ � ��६����� R_Mode_IRQ_Mask ��� ���४⭮��
;  ����⠭������� IRQ �� ������ � R-Mode.

	in	al,0a1h
	mov	ah,al
	in	al,21h
	mov	R_Mode_IRQ_Mask,ax

	ret

endp
;----------------------------------------------------------------------------
init_set_descriptor
init_putzs

init_P_Mode_redirect_IRQ
init_R_Mode_redirect_IRQ
init_redirect_IRQ

init_set_IDT_descriptor
init_set_int_IDT_descriptor
init_set_trap_IDT_descriptor

init_handlers
init_setup_IDT

init_disable_APIC
init_enable_APIC
;----------------------------------------------------------------------------

; ZS-��ப� ��� �뢮�� �� �室� � P-Mode:
Start_P_Mode_ZS:	db	"Entering to protected mode...",0

; ZS-��ப� ��� �뢮�� �� ࠡ�� � P-Mode:
P_Mode_ZS:	db	"Working in P-mode...",0

; ZS-��ப� ��� �뢮�� � R-Mode:
R_Mode_ZS:	db	"Back to real address mode...",0

;----------------------------------------------------------------------------
; ����饭�� �����襪 �᪫�祭��
exept_mess_1	db	'Exeption:',0
exept_mess_2	db	'EFLAGS:',0
exept_mess_3	db	'CS:',0
exept_mess_4	db	'EIP:',0
exept_mess_5	db	'Error Code:',0
;exept_mess_	db	'',0
;exept_mess_	db	'',0
;----------------------------------------------------------------------------
text_color	db	?
;----------------------------------------------------------------------------
APIC_presence	db	?	; 1/0 - APIC ���� / ���
R_Mode_IRQ_Mask	dw	?
;----------------------------------------------------------------------------
timer_count	db	?
timer_sec	db	?
;----------------------------------------------------------------------------
R_Mode_SP	dw	?
R_Mode_SS	dw	?
R_Mode_DS	dw	?
R_Mode_ES	dw	?
R_Mode_FS	dw	?
R_Mode_GS	dw	?
;----------------------------------------------------------------------------
; ��ࠧ ॣ���� IDTR:
IDTR	label	fword
IDT_lim		dw	?
IDT_adr		dd	?

; ��ࠧ ॣ���� GDTR:

GDTR	label	fword
GDT_lim		dw	?
GDT_adr		dd	?
;----------------------------------------------------------------------------
IDT:
	dq	IDT_descr_n dup (?)
;----------------------------------------------------------------------------
GDT:
	dq	IDT_descr_max_n dup (?)
;----------------------------------------------------------------------------
	db	1024 dup (?)	; ��१�ࢨ஢��� ��� �⥪�.
Stack_seg_start:	; ��᫥���� ��⪠ �ணࠬ�� - ��� �㤥� ��� �⥪.
;----------------------------------------------------------------------------
main		endp
	pmode	ends
	end	start
