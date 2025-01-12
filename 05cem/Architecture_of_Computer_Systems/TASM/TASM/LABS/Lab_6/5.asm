.model small
.stack 200h
.data
color db ?
.code
.386

line proc pascal
local x1:word,x2:word,y1:word,y2:word,rx:word,ry:word,i:word,sx:word,sy:word,check:word,e:word,x:word,y:word
uses ax,bx,cx,dx
beg:
mov  i,0
mov x1,ax
mov y1,bx
mov x2,cx
mov y2,dx

mov ax, x1
sub ax, x2
absrx:
neg ax
js absrx
mov rx, ax; rx - ����� �� 0�

mov ax, y1
sub ax, y2
absry:
neg ax
js absry
mov ry, ax; ry - ����� �� 0�

mov ax, x2
sub ax, x1
shl ax,1
jc negx
mov ax, 1
jmp nextnegx
negx:
mov ax, -1
nextnegx:
mov sx, ax; - ���� ����� �� 0�

mov ax, y2
sub ax, y1
shl ax,1
jc negy
mov ax, 1
jmp nextnegy
negy:
mov ax, -1
nextnegy:
mov sy, ax; - ���� ����� �� 0�

push x1   ; x = x1
pop x
push y1   ; y = y1
pop y
push 0	  ; check = 0
pop check

mov ax,ry ;
cmp ax,rx
jle next
mov ax, rx
mov cx, ry
xchg ax,ry
mov rx, ax
mov check,1
next:       ; ���������� ����� � rx

push ry     ;e = 2*ry - rx;
pop e
sal e,1
mov ax, rx
sub e, ax

mov cx,rx
displayloop:
push cx
mov al,color;
mov ah,0Ch
mov bh,0
mov cx, x
mov dx, y
int 10h

cmp e,0
jl exite    ; e<0
cmp check,1
jne chnot1
mov ax, sx  ;ch=1
add x, ax   ;x=x+sx
jmp endch
chnot1:     
mov ax, sy  ;ch!=1
add y, ax   ;y=y+sy;
endch:
mov ax,rx   ;e=e-2*rx;
sal ax,1
sub e, ax
exite:

cmp check,1
jne chnot1_1
mov ax, sy    ;ch=1
add y, ax     ;y:=y+sy
jmp endch1
chnot1_1:
mov ax, sx    ;ch!=1
add x, ax     ;x:=x+sx;
endch1:
mov ax,ry     ;e=e+2*dy;
sal ax,1
add e, ax

pop cx
loop displayloop
ret
endp line


circle proc pascal
local x1:word,y1:word,r:word,x:word,y:word,x2:dword,y2:dword,r2:dword,sum:dword
uses ax,bx,cx,dx
mov x1,ax
mov y1,bx
mov r,cx
mov x,cx
dec x
mov y,0

mov cx,r
dispcirloop:
push cx
dispcirloopbegin:
mov ax,x1
mov bx,y1
mov cx,x
mov dx,y
call cirdots

mov ax, x
mov bx, x
mul bx
mov word ptr x2, dx
mov word ptr x2 + 2, ax ; x2=x^2
mov ax, y
mov bx, y
mul bx
mov word ptr y2, dx
mov word ptr y2 + 2, ax ; y2=y^2
mov ax, r
mov bx, r
mul bx
mov word ptr r2, dx
mov word ptr r2 + 2, ax ; r2=r^2

mov  eax,x2
mov  sum,eax
mov  eax,y2
add  sum,eax            ; sum=x^2+y^2
mov  eax,r2
cmp  sum,eax   
jae   nomoredots
inc  y                  ; x^2+y^2<r^2
jmp  dispcirloopbegin
nomoredots:             ; x^2+y^2>=r^2
dec  x
pop cx
loop dispcirloop
ret
endp circle

cirdots proc pascal
local a:word,b:word,c:word,d:word
uses ax,bx,cx,dx
mov a,ax
mov b,bx
mov c,cx
mov d,dx
mov al,color
mov ah,0Ch
mov bh,0
mov cx, a
sub cx, c
mov dx, b
sub dx, d
int 10h
mov cx, a
sub cx, c
mov dx, b
add dx, d
int 10h
mov cx, a
add cx, c
mov dx, b
sub dx, d
int 10h
mov cx, a
add cx, c
mov dx, b
add dx, d
int 10h

ret
endp cirdots

start:
	mov  ax,0a000h
    mov  es,ax
 
    mov  ah,0h
    mov  al,03h
    int  10h
 
    mov  ax,12h
    int  10h 
	
	mov al,30
	mov color,al
	
	mov cx,50
	mov dx,120
cirleloop:
	push cx
	mov ax,460
	mov bx,150
	mov cx,dx
	sub dx,2
	call circle
	pop cx
	loop cirleloop
	
	mov cx,50
	mov dx,120
cirleloop1:
	push cx
	mov ax,180
	mov bx,150
	mov cx,dx
	sub dx,2
	call circle
	pop cx
	loop cirleloop1
	mov al,12
	mov color,al
	mov ax,270
	mov bx,230
	mov cx,320
	mov dx,340
	call line
	mov ax,370
	mov bx,230
	mov cx,320
	mov dx,340
	call line
	mov ax,270
	mov bx,230
	mov cx,370
	mov dx,230
	call line
	
	mov ah,02h
	mov dh,20
	mov dl,0
	int 10h
	
	mov	ax,4c00h
	int	21h
end	start