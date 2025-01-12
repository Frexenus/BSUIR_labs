.model   small
.stack   200h
.data
	AXPROC dw 200
	STRING_ONE DB ' INPUT 1-ST NUMBER: $'	
	STRING_TWO DB ' INPUT 2-ND NUMBER: $'
	STRING_RES DB ' RESULT: $'
	STRING_ESC DB 10, 13,'AGAIN:' , '$'
	STRING_BSP DB 10, 13, '$'
	MINUS DB '-','$'
	INONE DW 0
	INTWO DW 0
	TEN DW 10
	MCHEK DW 0	;MINUS PERFORMANCE
	MCSAV DW 0
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

	CMP AL, '-'	;AL STORE LAST SYMBOL.
	JZ ADDMIN	;IF MINUS PRESSED. MINUS ADDED

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

	
	MOV MCHEK, AX	;COUNTER BECOME ZERO FOR EACH DELALL(*)

	LEA DX,STRING_ESC
	MOV AH,09H	;STRING OUT
	INT 21H
	
	JMP TARTIN	;START INPUT AGAIN

ADDMIN:
	CMP DI, 0	;INPUT MINUS AT BEGINNING DIGIT ONLY
	JNZ TARTIN

	LEA DX, MINUS	;"-" CHARACHTER
	MOV AH,09H	;STRING OUT
	INT 21H		;BREAKING
	INC MCHEK	;ADD MINUS BINARY COUNTER

	JMP TARTIN	;GOTO START
	

DELETE:

;BACKSPACE
	
	LEA DX,STRING_BSP
	MOV AH,09H	;STRING OUT
	INT 21H

	XOR DX, DX	;DESTRUCT REGISTER - PREPARE FOR DIV
	MOV AX, DI
	MOV BX, TEN	
	DIV BX		;DECREASE DIGIT DOWN TO 10
	
	CALL OUTPROC	;PRINT THIS DIGIT
	MOV DI, AX	;SAVE THE RESULT TO WORKING REGISTER
	XOR DX,DX	;DESTRUCT DIV REG
	
	JMP TARTIN	;GOTO START
SAVING:
	LEA DX,STRING_BSP
	MOV AH,09H	;STRING OUT
	INT 21H

	MOV AX,DI	;MOVEING NUMBER TO AX REGISTER
	POP DI		;RESTORE REGISTERS
	POP DX
	POP CX
	POP BX
RET
INPROC ENDP



START:
	MOV AX, @DATA	;WHAT IT IS??
	MOV DS, AX

	

	LEA DX,STRING_ONE
	MOV AH,09H	;STRING OUT
	INT 21H
	
	CALL INPROC
	MOV INONE,AX	;ONE IN
	
	;MOV CX, MCHEK
	;MOV MCSAV, CX	
	
	LEA DX,STRING_TWO
	MOV AH,09H	;STRING OUT
	INT 21H
	
	CALL INPROC
	MOV INTWO,AX	;TWO IN	
	
	
	;ADD	

	LEA DX,STRING_RES
	MOV AH,09H	;STRING OUT
	INT 21H

	
	XOR AX, AX	;DESTRUCT REGISTERS - PREPARE FOR DIV
	XOR CX, CX
	XOR DX, DX

	
	MOV AX, INONE	
	MOV CX, INTWO
	DIV CX		;COMPUTING DIV
	PUSH AX		;SAVE RESULT

	
	MOV AX, MCHEK	;MINUS COMPUTING
	MOV BL , 2	
	DIV BL		
	CMP AH, 1	;IF OSTATOK EQUALS 1 FOR ALL MINUSES OF THE PROG
	JNZ OU		;SHOW MINUS
	LEA DX, MINUS	;"-" CHARACHTER
	MOV AH,09H	;STRING OUT
	INT 21H		;BREAKING	
OU:

	POP AX		;RESTORE RESULT
	CALL OUTPROC	;OUTPUT  


MOV AH,4CH
INT 21H



END START