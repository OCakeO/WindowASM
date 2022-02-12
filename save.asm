.386
.model 			flat,stdcall
option			casemap:none
; ComboBox

include 		..\include\windows.inc
include 		..\include\user32.inc
include 		..\include\kernel32.inc
include 		..\include\gdi32.inc
include 		..\include\comdlg32.inc
include 		..\include\comctl32.inc


includelib 		..\lib\user32.lib
includelib 		..\lib\kernel32.lib
includelib 		..\lib\gdi32.lib
includelib 		..\lib\comdlg32.lib
includelib 		..\lib\comctl32.lib

	.data
sizefile		DWORD 0
sizefile2		DWORD 0

ClassName		db	"window1",0
ClassName2		db	"window2",0
AppName			db	"one window",0
AppName2		db	"two window",0
hello_mess1		db	"Left",0
hello_mess2		db	"Right",0
hello_title		db	"Hooray!",0
save 			db	"Сохранить",0	;Menu
open 			db	"Открыть файл",0	;Menu
exit 			db	"Выход",0	;Menu
file 			db	"Файл",0	;Menu
about 			db	"О программе",0
aboutfile 		db	"Эта программа на чистом WinApi",0
calc       		db  "C:\Windows\System32\calc.exe",0
ris      		db  "CATSEYE.bmp",0
ButtonClassName	db	"Button",0	;Button
EditClassName	db	"Edit",0	;Edit
ComboBoxName	db	"ComboBox",0;ComboBox
ButtonText1		db	"MessageBoxA",0	;Button
ButtonText2		db	"Квадратик",0	;Button
ButtonText3		db	"Калькулятор",0	;Button
ButtonText4		db	"Кнопка 4",0	;Button  
ButtonText5		db	"Картинка",0	;Button
ComboBoxText1	db	"Hello",0	;ComboBox
tbt				db 	"New",0,"Open",0,"Save",0,"Cut",0,"Copy",0,"Paste",0,0	;tbButtons
filter			db	"Текстовые файлы",0,"*.txt",0,0
filename		db	255 dup(0)
defext			db	"txt",0
MesComboBox1	db 	"Hello",0
MesComboBox2	db 	"Hell",0
MesComboBox3	db 	"o",0

wc				WNDCLASSEX 	<?>
msg				MSG 		<?>
paintStruct 	PAINTSTRUCT <?>
startInfo 		STARTUPINFO <?>
procInfo  		PROCESS_INFORMATION <?>
ofn				OPENFILENAME <?>
ol				OVERLAPPED 	<?>
tbButtons		TBBUTTON 	<0>
td 				db	0

buffer			db 1000 dup(?)

hWer			HWND	?
hwndButton		HWND 	?	;Button
hwndEdit1		HWND 	?	;Edit
hwndEdit2		HWND 	?	;Edit
hwndMenu		HMENU 	?	;Menu
hwndPopMenu		HMENU 	?	;Menu
hBmp			HWND 	?
hMem			HWND 	?
hwnd			HWND 	?
hwnd2 			HWND 	?
hdc1  			HDC  	?	;paintStruct
hMemo			HWND	?
hMemo2			HWND	?
hFile			HANDLE	?	;Menu
hFile2			HANDLE	?	;Menu
hInstance		HINSTANCE ?
hToolBar		HANDLE	?
hPaste			HWND 	?
hwndCombo		HWND	?

	.const
ButtonID1		EQU	1
ButtonID2		EQU	2
ButtonID3		EQU	3
ButtonID4		EQU	4
ButtonID5		EQU 5
EditID1			EQU	6
EditID2			EQU	7
EditID3			EQU 8
MemoID1			EQU 9
MemoID2			EQU 10

id_save 		EQU 11	;Menu
id_about 		EQU 12	;Menu
id_exit 		EQU 13	;Menu
id_action 		EQU 14	;Menu
id_open 		EQU 15	;Menu

tbButtonID1		EQU 16
tbButtonID2		EQU 17
tbButtonID3		EQU 18
tbButtonID4		EQU 19
id_cut			EQU 20
ComboBoxID1		EQU 21

	.code
start:
	invoke	GetModuleHandle,NULL
	mov 	hInstance, eax

	mov 	wc.cbSize,			SIZEOF WNDCLASSEX
	mov		wc.style,			CS_HREDRAW or CS_VREDRAW or CS_BYTEALIGNWINDOW
	mov 	wc.lpfnWndProc, 	OFFSET WndProc
	mov 	wc.cbClsExtra,		NULL
	mov		wc.cbWndExtra,		NULL
	
	push	hInstance
	pop 	wc.hInstance
	
	mov		wc.hbrBackground,	COLOR_WINDOW+1
	mov 	wc.lpszMenuName,	NULL
	mov		wc.lpszClassName, 	OFFSET ClassName
	
	invoke	LoadIcon,NULL,IDI_APPLICATION
	mov 	wc.hIcon,eax
	mov		wc.hIconSm,eax
	
	invoke	LoadCursor,NULL,IDC_ARROW
	mov		wc.hCursor,eax
	
	invoke	RegisterClassEx,addr wc
	invoke	CreateWindowEx,NULL,addr ClassName,addr AppName,WS_OVERLAPPEDWINDOW,200,200,1100,600,NULL,NULL,hInstance,NULL
	mov		hwnd,eax
	
	invoke	ShowWindow,hwnd,SW_SHOWNORMAL
	invoke	UpdateWindow,hwnd

MSG_LOOP:
	invoke	GetMessage,addr msg,NULL,0,0
	cmp	eax,0
	je	END_LOOP
	
	invoke	TranslateMessage,addr msg
	invoke	DispatchMessage,addr msg
	jmp	MSG_LOOP
END_LOOP:
	mov	eax,msg.wParam
	invoke	ExitProcess,eax

WndProc proc hWnd:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	.if 	uMsg == WM_DESTROY
		;invoke DeleteDC,hMem
		;invoke DeleteObject,hBmp
	    invoke	PostQuitMessage,NULL
	    xor 	eax,eax
	    ret
	.elseif	uMsg == WM_CREATE
;Button
	    invoke	CreateWindowEx,NULL,addr ButtonClassName,addr ButtonText1,WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON ,280,50,100,20,hWnd,ButtonID1,hInstance,NULL
	    mov		hwndButton,eax

	    invoke	CreateWindowEx,NULL,addr ButtonClassName,addr ButtonText2,WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON ,280,80,100,20,hWnd,ButtonID2,hInstance,NULL
	    mov		hwndButton,eax

	    invoke	CreateWindowEx,NULL,addr ButtonClassName,addr ButtonText3,WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON ,280,110,100,20,hWnd,ButtonID3,hInstance,NULL
	    mov		hwndButton,eax

	    invoke	CreateWindowEx,NULL,addr ButtonClassName,addr ButtonText4,WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON ,280,140,100,20,hWnd,ButtonID4,hInstance,NULL
	    mov		hwndButton,eax
		
;Button
;Edit
	    invoke	CreateWindowEx,NULL,addr EditClassName,NULL,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_AUTOHSCROLL or ES_MULTILINE,50,50,200,25,hWnd,EditID1,hInstance,NULL
	    mov		hwndEdit1,eax
	    invoke	SetFocus,hwndEdit1
		
	    invoke	CreateWindowEx,NULL,addr EditClassName,NULL,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_AUTOHSCROLL or ES_MULTILINE,50,90,200,25,hWnd,EditID2,hInstance,NULL
	    mov		hwndEdit2,eax
;Edit
;Memo		
	    invoke	CreateWindowEx,NULL,addr EditClassName,NULL,WS_CHILD or WS_VISIBLE or WS_DLGFRAME or WS_VSCROLL or ES_MULTILINE or ES_AUTOVSCROLL,400,50,300,180,hWnd,MemoID1,hInstance,NULL
	    mov		hMemo,eax
		
		invoke	CreateWindowEx,NULL,addr EditClassName,NULL,WS_CHILD or WS_VISIBLE or WS_DLGFRAME or WS_VSCROLL or ES_MULTILINE or ES_AUTOVSCROLL,720,50,300,180,hWnd,MemoID2,hInstance,NULL
	    mov		hMemo2,eax
;Memo	
		invoke 	CreateMenu
		mov 	hwndMenu, eax

		invoke 	CreatePopupMenu
		mov 	hwndPopMenu, eax
		
		invoke 	AppendMenu, hwndPopMenu, MF_STRING, id_open, addr open
		invoke 	AppendMenu, hwndPopMenu, MF_STRING, id_save, addr save
		invoke 	AppendMenu, hwndPopMenu, MF_SEPARATOR, 0, 0
		invoke 	AppendMenu, hwndPopMenu, MF_STRING, id_exit, addr exit

		invoke 	AppendMenu, hwndMenu, MF_POPUP, hwndPopMenu, addr file
		invoke 	AppendMenu, hwndMenu, MF_STRING, id_about, addr about
		invoke 	ModifyMenu, hwndMenu, 1, MF_BYPOSITION or MF_HELP, id_about, addr about
		
		invoke 	SetMenu, hWnd, hwndMenu
		
;OPENFILENAME
		mov ofn.lStructSize,		SIZEOF OPENFILENAME
		
		push hInstance
		pop ofn.hInstance
		
		mov ofn.lpstrFilter,		offset filter
		mov ofn.lpstrFile,			offset filename
		mov ofn.nMaxFile, 			1000
		mov ofn.lpstrDefExt,		offset defext
;OPENFILENAME
;tbButtons		
		mov tbButtons.iBitmap,STD_FILENEW
		mov tbButtons.idCommand,tbButtonID1
		mov tbButtons.fsState,TBSTATE_ENABLED
		mov tbButtons.fsStyle,TBSTYLE_BUTTON
		mov tbButtons.iString,0
		
		invoke CreateToolbarEx, hWnd, WS_VISIBLE or WS_CHILD or WS_BORDER, 0, 0, HINST_COMMCTRL, IDB_STD_SMALL_COLOR,addr tbButtons, 1, 0, 0, 0, 0, SIZEOF TBBUTTON
		; HINST_COMMCTRL - Менять на хендл главного окна == вставлять свои пикчи, также менять .BitMap
		mov hToolBar,eax
		invoke SendMessage,hToolBar,TB_ADDSTRING,0,addr tbt
		
		
		mov tbButtons.iBitmap,STD_FILEOPEN
		mov tbButtons.idCommand,id_open
		mov tbButtons.iString,1
		invoke SendMessage,hToolBar,TB_ADDBUTTONS,1,addr tbButtons
		
		mov tbButtons.iBitmap,STD_FILESAVE
		mov tbButtons.idCommand,id_save
		mov tbButtons.iString,2
		invoke SendMessage,hToolBar,TB_ADDBUTTONS,1,addr tbButtons
		
		mov tbButtons.fsStyle,TBSTYLE_SEP
		invoke SendMessage,hToolBar,TB_ADDBUTTONS,1,addr tbButtons
		
		mov tbButtons.iBitmap,STD_CUT
		mov tbButtons.idCommand,tbButtonID2
		mov tbButtons.fsStyle,TBSTYLE_BUTTON
		mov tbButtons.iString,3
		invoke SendMessage,hToolBar,TB_ADDBUTTONS,1,addr tbButtons
		
		mov tbButtons.iBitmap,STD_COPY
		mov tbButtons.idCommand,tbButtonID3
		mov tbButtons.fsStyle,TBSTYLE_BUTTON
		mov tbButtons.iString,4
		invoke SendMessage,hToolBar,TB_ADDBUTTONS,1,addr tbButtons
		
		mov tbButtons.iBitmap,STD_PASTE
		mov tbButtons.idCommand,tbButtonID4
		mov tbButtons.fsStyle,TBSTYLE_BUTTON
		mov tbButtons.iString,5
		invoke SendMessage,hToolBar,TB_ADDBUTTONS,1,addr tbButtons
;tbButtons
;comboBox
		invoke	CreateWindowEx,0,addr ComboBoxName,addr ComboBoxText1,CBS_DROPDOWN or CBS_HASSTRINGS or WS_CHILD or WS_VISIBLE or CBS_AUTOHSCROLL,20,250,250,300,hWnd,ComboBoxID1,hInstance,NULL
		mov	hwndCombo,eax
		
		invoke	SendMessage,hwndCombo, CB_ADDSTRING, 0, addr MesComboBox1;
		invoke	SendMessage,hwndCombo, CB_ADDSTRING, 0, addr MesComboBox2;
		invoke	SendMessage,hwndCombo, CB_ADDSTRING, 0, addr MesComboBox3;
;comboBox 
.elseif uMsg==WM_SIZE
	invoke SendMessage,hToolBar,TB_AUTOSIZE,0,0 


.elseif uMsg==WM_PAINT
	invoke BeginPaint, hWnd, addr paintStruct
	mov hdc1,eax
				
.elseif uMsg==WM_COMMAND
		
	
	    mov eax,wParam
	    .if ax==ButtonID1
	        shr eax,16
	        .if ax==BN_CLICKED
			  invoke GetWindowText,hwndEdit1,addr buffer,512
			  invoke SetWindowTextA,hwndEdit2,addr buffer
			  invoke MessageBoxA,NULL,addr buffer,addr AppName,MB_OK
	        .endif
	    .endif
	    .if ax==id_exit
	    	shr eax,16
	    	.if ax==BN_CLICKED
	    		invoke PostMessage, hWnd, WM_CLOSE, 0, 0
	    	.endif
	    .endif
	    .if ax==id_about
	    	shr eax,16
	    	.if ax==BN_CLICKED
	    		invoke MessageBoxA,NULL,addr aboutfile,addr AppName2,MB_OK
	    	.endif
	    .endif
	    .if ax==ButtonID2
	        shr eax,16
	        .if ax==BN_CLICKED
	        	mov wc.lpfnWndProc, OFFSET ChildProc
	        	mov	wc.lpszClassName, OFFSET ClassName2
	        	invoke	RegisterClassEx,addr wc
			  	invoke 	CreateWindowEx,NULL,addr ClassName2,addr AppName2,WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,CW_USEDEFAULT,300,300,NULL,NULL,hInstance,NULL
				mov hwnd2, eax
				
				invoke	ShowWindow,hwnd2,SW_SHOWNORMAL
				invoke	UpdateWindow,hwnd2
	        .endif
	    .endif
	    .if ax == ButtonID3
	        shr eax,16
	        .if ax == BN_CLICKED
			  invoke CreateProcessA,addr calc, NULL, NULL, NULL, FALSE,	 NULL, NULL, NULL, addr startInfo, addr procInfo
	        .endif
	    .endif
	    .if ax == id_save
	        shr eax,16
	        .if ax == BN_CLICKED
			invoke GetSaveFileNameA, addr ofn
			invoke CreateFile,ofn.lpstrFile,GENERIC_READ or GENERIC_WRITE,0,NULL,CREATE_ALWAYS,0,NULL
			mov hFile,eax
			invoke GetWindowText,hMemo,addr buffer,65000
			mov sizefile,eax
			invoke WriteFile,hFile,addr buffer, sizefile, addr ol, NULL
			invoke CloseHandle,hFile
	        .endif
	    .endif
		.if ax == id_open
	        shr eax,16
	        .if ax == BN_CLICKED
			invoke GetOpenFileNameA, addr ofn
			invoke CreateFile,ofn.lpstrFile,GENERIC_READ or GENERIC_WRITE,0,NULL,CREATE_ALWAYS,0,NULL
			mov hFile2,eax
			invoke SetWindowText,hMemo2,addr buffer
			mov sizefile2,eax
			invoke CloseHandle,hFile2
	        .endif
	    .endif
		
		
		.if ax==ButtonID4
	        shr eax,16
	        .if ax==BN_CLICKED
				
				invoke LoadImage,NULL,addr ris,IMAGE_BITMAP,0,0,LR_LOADFROMFILE
				mov hBmp,eax
			
				invoke CreateCompatibleDC,hdc1
				mov hMem,eax
				
				invoke SelectObject,hMem,hBmp
				invoke BitBlt,hdc1,20,200,311,313,hMem,NULL,NULL,SRCCOPY
			
	        .endif
	    .endif
		
		.if ax==tbButtonID1
	        shr eax,16
	        .if ax==BN_CLICKED
				invoke DeleteObject,hBmp
				invoke DeleteObject,hdc1
				invoke DeleteDC,hMem
				
				invoke	ShowWindow,hwnd,SW_MAXIMIZE
				invoke	ShowWindow,hwnd,SW_SHOWNORMAL
				
				
				invoke SetWindowText,hwndEdit1,addr td
				invoke SetWindowText,hwndEdit2,addr td
				invoke SetWindowText,hMemo,addr td
				invoke SetWindowText,hMemo2,addr td
	        .endif
	    .endif
		
		.if ax==tbButtonID2
	        shr eax,16
	        .if ax==BN_CLICKED
				invoke GetFocus
			mov hPaste,eax
			invoke SendMessage,hPaste,WM_CUT,0,0
				
	        .endif
	    .endif
		.if ax==tbButtonID3
	        shr eax,16
	        .if ax==BN_CLICKED
				invoke GetFocus
			mov hPaste,eax
			invoke SendMessage,hPaste,WM_COPY,0,0
				
	        .endif
	    .endif
		.if ax==tbButtonID4
	        shr eax,16
	        .if ax==BN_CLICKED
			invoke GetFocus
			mov hPaste,eax
			invoke SendMessage,hPaste,WM_PASTE,0,0
			mov eax,0
	        .endif
	    .endif
		
		.if ax==ComboBoxID1
	        shr eax,16
	        .if ax==CBN_SELCHANGE
			invoke SendMessage,hwndCombo,CB_GETCURSEL,0,0
			.if eax == 0
			invoke SetWindowTextA,hwndEdit1,addr MesComboBox1
			.elseif eax == 1
			invoke SetWindowTextA,hwndEdit1,addr MesComboBox2
			.elseif eax == 2
			invoke SetWindowTextA,hwndEdit1,addr MesComboBox3
			.endif
	        .endif
	    .endif
    .endif


	
	invoke 	BitBlt,hdc1,20,200,311,313,hMem,NULL,NULL,SRCCOPY
	invoke	DefWindowProc,hWnd,uMsg,wParam,lParam

ret	
WndProc endp

ChildProc proc hWnd:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM
	.if uMsg == WM_DESTROY
		invoke DestroyWindow, hWnd	
	.elseif uMsg == WM_PAINT
		invoke BeginPaint, hWnd, addr paintStruct
		mov hdc1, eax
		invoke Rectangle, hdc1, 20, 20, 100, 50
		invoke EndPaint, hWnd, addr paintStruct
	.else
		invoke	DefWindowProc,hWnd,uMsg,wParam,lParam
	.endif
ret
ChildProc endp

end start