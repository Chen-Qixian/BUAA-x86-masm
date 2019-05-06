STACK		SEGMENT	PARA STACK
STACK_AREA      DW      100h DUP(?)
STACK_TOP	EQU	$-STACK_AREA
STACK		ENDS

DATA		SEGMENT	PARA
TABLE_LEN       DW 16
TABLE           DW 200,300,400,10,20,0,1,8
                DW 41H,40,42H,50,60,0FFFFH,2,3
DATA		ENDS

CODE		SEGMENT
		ASSUME	CS:CODE,DS:DATA
		ASSUME	SS:STACK
MAIN		PROC	FAR
		
START:          MOV     AX,STACK
		MOV	SS,AX
		MOV	SP,STACK_TOP
		MOV	AX,DATA
		MOV	DS,AX			;SET SS,SP,DS

LP1:    	MOV     BX,1
        	MOV     CX,TABLE_LEN
        	DEC     CX
        	MOV     SI,OFFSET TABLE
LP2:    	MOV     AX,[SI]
        	CMP     AX,[SI+2]
        	JAE     CONTINUE
        	XCHG    AX,[SI+2]
        	MOV     [SI],AX
        	MOV     BX,0
CONTINUE:
       		ADD     SI,2
        	LOOP    LP2

	        CMP     BX,1
        	JZ      EXIT
        	JMP     SHORT   LP1

EXIT:		MOV     AX,4C00H
		INT     21H
MAIN		ENDP
CODE		ENDS		 

		END     START
END
