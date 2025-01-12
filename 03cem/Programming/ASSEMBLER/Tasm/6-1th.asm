.model small
.stack 100H
.data

	MSG_ENN	db "ENTER N:", 10, 13, '$'
	MSG_ENM db "ENTER M: ", 10, 13, '$'
	MSG_MAA db "ENTER Matrix A:", '$'
	MSG_MAB db "ENTER Matrix B:",  '$'
	MSG_MAX db "Each-element-max Matrix:",10,13,'$'
	SPACE db "   ",'$'
	MATX_A db 1000 dup (0)
	MATX_B db 1000 dup (0)
	MATX_X db 1000 dup (0)
	MATX_TEST db 1,2,3,4,5,6,7,8,9,10,11,12		;Test Matrix
	VAR_TEST_N dw 3
	VAR_TEST_M dw 4
	STRING_ESC db 10,13,'$'
	VAR_N DW 1;
	VAR_M DW 1;
	COU_N dw 0
	COU_M dw 0
	TEMP_COU dw 1
	TEN dw 10
	MUL_NM dw 0
	INT_MAIN MACRO
		MOV AX, @data
		MOV DS, AX
		MOV ES, AX
	ENDM
	RETURN_0 MACRO
	MOV AX, 4c00H
	INT	21H
	ENDM
.code
OUTPROC PROC
	PUSH CX		;SAVE REGISTERS
	PUSH DX
	PUSH BX
	PUSH AX
        MOV BX, TEN	;PREPARE DECREASE CAPACITY
        XOR CX,CX	;COUNTER ZERO
        FOR1:
            XOR DX, DX 	;DX SHOULD BE ZERO
            DIV BX	;DECREASE CAPACITY
            PUSH DX	;RESIDUE GOING TO STACK
            INC CX	;INCREASE COUNTER FOR LOOP
            TEST AX,AX	;IF THE NUMBER BECOME NOT-ZERO START TO OUTPUT
            JNZ FOR1
        MOV AH, 02h	;OUTPUT FUNTCTION OF 21 BREAKING
        FOR2:
            POP DX	;TAKE DIGIT FROM THE STACK (1->5->6)
            ADD DL, 30H	;CONVERT TO THE CHARACHTERS
            INT 21h	;BREAKING
            LOOP FOR2	
	POP AX		;RESTORE REGISTERS
	POP BX
	POP DX
	POP CX
RET
OUTPROC ENDP
INPROC PROC
	PUSH BX		;SAVE ALL REGISTERS
	PUSH CX
	PUSH DX
	PUSH DI		;MAGIC REGISTER DI MUST BE SAVED
	XOR DI,DI 	;AND SHOULD BE NULL
TARTIN:
	XOR DX, DX
	XOR AX, AX
	MOV AH,08H	;EXACTLY INPUT TO THE AX REGISTER
	INT 21H
	XOR AH,AH
	CMP AL,13 	;AL STORE LAST SYMBOL. 13 - IS FOR ENTER
	JZ SAVING	;IF ENTER PRESSED TARTING SAVING TO THE REGISTER
	CMP AL,8 	;AL STORE LAST SYMBOL. 8 - IS FOR BACKSPACE
	JZ DELETE	;IF BACKSPACE PRESSED DELETING LAST SYMBOL
	CMP AL,27 	;AL STORE LAST SYMBOL. 27 - IS FOR ESCAPE
	JZ DELALL	;IF ESCAPE PRESSED DELETING ALL NUMBER
	;NOT-TO-INPUT STRING CHECKING
	CMP AL, '9'
	JA TARTIN	;IF AL SYMBOL MORE THAN '9' TARTING TO ENTER SYMBOL AGAIN
	CMP AL, '0'
	JB TARTIN	;IF AL SYMBOL LESS THAN '0' TARTING TO ENTER SYMBOL AGAIN
	MOV AH,02H 	;OUTPUT CHECKED SYMBOL
	MOV DL,AL	;DL STORE SYMBOL TO OUTPUT
	INT 21H
	XOR AH,AH
	SUB AX, 30H	;CONVERT SYMBOL TO THE DIGIT
	PUSH AX		;SAVE DIGIT
	MOV AX, DI	;MOVE LAST VALUE TO AX REGISTER TO PREPARE CHECKING
	MOV BX, TEN	;CHECKING TO THE OVERLIMIT
	MUL BX		;MULTIPLY
	JC DELALL	;IF OVERLIMIT GOTO ESCAPE
	POP DI
	ADD AX, DI	;SUM A HOLE NUMBER(AX) * 10 + CURRENT DIGIT(DI)
	CMP AX,65534
	JNC DELALL
	MOV DI,AX	;SAVING NUMBER
	JMP TARTIN	;ADDING NEW DIGIT
DELALL:
	XOR AX,AX	;CLEAR AX REGISTER
	XOR DI,DI	;CLEAR DI(SAVED NUMBER) REGISTER
	LEA DX,STRING_ESC
	MOV AH,09H	;STRING OUT
	INT 21H
	JMP TARTIN	;START INPUT AGAIN
DELETE:
;BACKSPACE
	XOR DX, DX	;DESTRUCT REGISTER - PREPARE FOR DIV
	MOV AX, DI
	MOV BX, TEN	
	DIV BX		;DECREASE DIGIT DOWN TO 10
	CALL OUTPROC	;PRINT THIS DIGIT
	MOV DI, AX	;SAVE THE RESULT TO WORKING REGISTER
	XOR DX,DX	;DESTRUCT DIV REG
	JMP TARTIN	;GOTO START
SAVING:
	MOV AX,DI	;MOVEING NUMBER TO AX REGISTER
	POP DI		;RESTORE REGISTERS
	POP DX
	POP CX
	POP BX
RET
INPROC ENDP
MATX_ENT_A PROC	
PUSH AX
MOV ax,VAR_N	;SAVING REGISTERS
MOV COU_N,ax
MOV ax, VAR_M
MOV COU_M, ax
XOR si,si
FIXED_ENTERANCE_A:
CALL INPROC
MOV MATX_A[si], AL
INC si
CMP MUL_NM,si
LEA DX,SPACE			
MOV AH,09H	;STRING OUT
INT 21H
JNZ FIXED_ENTERANCE_A
MOV AX, 0
MOV COU_N, ax 		;RESTORE REGISTERS
MOV COU_M, ax
POP AX
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
RET
MATX_ENT_A ENDP
MATX_ENT_B PROC	
PUSH AX
MOV ax,VAR_N	;SAVING REGISTERS
MOV COU_N,ax
MOV ax, VAR_M
MOV COU_M, ax
XOR si,si
FIXED_ENTERANCE_B:
CALL INPROC
MOV MATX_B[si], AL
INC si
CMP MUL_NM,si
LEA DX,SPACE			
MOV AH,09H	;STRING OUT
INT 21H
JNZ FIXED_ENTERANCE_B
MOV AX, 0
MOV COU_N, ax 		;RESTORE REGISTERS
MOV COU_M, ax
POP AX
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
RET
MATX_ENT_B ENDP
MATX_OUT_TEST PROC
MOV AX, VAR_TEST_N
MOV COU_N, AX
MOV AX,VAR_TEST_M
MOV COU_M,AX
XOR BX, BX
LOOP_ND:
DEC COU_M
MOV AX, VAR_TEST_N
MOV COU_N, AX
LOOP_ST:
	DEC COU_N
	XOR ax,ax
	MOV si, bx
	MOV al, MATX_TEST[si]
	CALL OUTPROC
	LEA dx,SPACE			;SPACE
	MOV AH,09H	;STRING OUT
	INT 21H
	INC BX
	CMP COU_N,0
	JNZ LOOP_ST
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
CMP COU_M, 0
JNZ LOOP_ND
RET
MATX_OUT_TEST ENDP





CREATE_MAX_MATX PROC

XOR SI,SI
LOOP_comp:

MOV AL,MATX_A[si]
MOV BL,MATX_B[si]

CMP al,bl
jg save_al

MOV MATX_X[si], bl
jmp next

save_al:
MOV MATX_X[si], AL

next:




INC SI
CMP MUL_NM,si
JNZ LOOP_comp


RET
CREATE_MAX_MATX ENDP






MATX_OUT_X PROC



MOV AX, VAR_N
MOV COU_N, AX
MOV AX,VAR_M
MOV COU_M,AX
XOR BX, BX
LOOP_ND_X:
DEC COU_M
MOV AX, VAR_N
MOV COU_N, AX
LOOP_ST_X:
	DEC COU_N
	XOR ax,ax
	MOV si, bx
	MOV al, MATX_X[si]
	CALL OUTPROC
	LEA dx,SPACE			;SPACE
	MOV AH,09H	;STRING OUT
	INT 21H
	INC BX
	CMP COU_N,0
	JNZ LOOP_ST_X
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
CMP COU_M, 0
JNZ LOOP_ND_X





RET
MATX_OUT_X ENDP

















MATX_OUT_B PROC
MOV AX, VAR_N
MOV COU_N, AX
MOV AX,VAR_M
MOV COU_M,AX
XOR BX, BX
LOOP_ND_B:
DEC COU_M
MOV AX, VAR_N
MOV COU_N, AX
LOOP_ST_B:
	DEC COU_N
	XOR ax,ax
	MOV si, bx
	MOV al, MATX_B[si]
	CALL OUTPROC
	LEA dx,SPACE			;SPACE
	MOV AH,09H				;STRING OUT
	INT 21H
	INC BX
	CMP COU_N,0
	JNZ LOOP_ST_B
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
CMP COU_M, 0
JNZ LOOP_ND_B
RET
MATX_OUT_B ENDP
MATX_OUT_A PROC
MOV AX, VAR_N
MOV COU_N, AX
MOV AX,VAR_M
MOV COU_M,AX
XOR BX, BX
LOOP_ND_A:
DEC COU_M
MOV AX, VAR_N
MOV COU_N, AX
LOOP_ST_A:
	DEC COU_N
	XOR ax,ax
	MOV si, bx
	MOV al, MATX_A[si]
	CALL OUTPROC
	LEA dx,SPACE			;SPACE
	MOV AH,09H	;STRING OUT
	INT 21H
	INC BX
	CMP COU_N,0
	JNZ LOOP_ST_A
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
CMP COU_M, 0
JNZ LOOP_ND_A
RET
MATX_OUT_A ENDP
		assume	DS: @data, ES: @data 	 
MAIN:
		INT_MAIN
		LEA DX, MSG_ENN			;message to ENTER N
		MOV AH, 09H
		INT 21H
	CALL INPROC					;scan N
	MOV VAR_N,AX	
	LEA DX,STRING_ESC			;↓←
	MOV AH,09H	;STRING OUT
	INT 21H
		LEA DX, MSG_ENM			;message to ENTER M
		MOV AH, 09H
		INT 21H
	CALL INPROC					;scan M
	XOR DX,DX
	MOV VAR_M,AX		
	MUL VAR_N
	MOV MUL_NM,AX
;A MATRIX:
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
LEA DX, MSG_MAA			;message to ENTER MATRIX A
MOV AH, 09H
INT 21H
CALL MATX_ENT_A
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
CALL MATX_OUT_A
;B MATRIX:
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
LEA DX, MSG_MAB			;message to ENTER MATRIX B
MOV AH, 09H
INT 21H
CALL MATX_ENT_B
LEA DX,STRING_ESC			;↓←
MOV AH,09H	;STRING OUT
INT 21H
CALL MATX_OUT_B
	;CALL MATX_OUT_TEST
	;MOV AX, MUL_NM			;CHECKING enterence
	;CALL OUTPROC
LEA DX,MSG_MAX			;message to output Each-element-max matrix 
MOV AH,09H	;STRING OUT
INT 21H
CALL CREATE_MAX_MATX
CALL MATX_OUT_X


		RETURN_0
end MAIN