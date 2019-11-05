include \masm32\include64\masm64rt.inc 

.data
	hInstance HINSTANCE 0
	CommandLine LPSTR 0
	ClassName db "AntiChrome",0,0
	MenuName db "AntiChrome",0
	AppName db "AntiChrome",0
	ID_TIMER equ 1
	process_id dword 0
	class_name db 512 dup (0)
	base db "Chrome_WidgetWin_1",0,0
	dwDesiredAccess dword 0
	bInheritHandle dword 0 
	hProcess qword 0
.code
main proc
	invoke GetModuleHandle, 0 
	mov hInstance, rax

	call GetCommandLine
	mov CommandLine, rax
	invoke WinMain, hInstance, NULL, CommandLine, SW_SHOWDEFAULT
	
	invoke ExitProcess, 0
main endp

WinMain proc hInst: HINSTANCE, hPrevInst: HINSTANCE, CmdLine: LPSTR, CmdShow:dword
	local wc: WNDCLASSEX
	local msg: MSG 
	local hwnd: HWND 

	mov wc.cbSize, sizeof WNDCLASSEX
	mov wc.style, CS_HREDRAW or CS_VREDRAW
	lea rbx, WndProc
	mov wc.lpfnWndProc, rbx
	mov wc.cbClsExtra, NULL
	mov wc.cbWndExtra, NULL
	push hInst
	pop wc.hInstance
	mov wc.hbrBackground, COLOR_BTNFACE+1 
	lea rbx, MenuName
	mov wc. lpszMenuName, rbx
	lea rbx, ClassName
	mov wc.lpszClassName, rbx

	invoke LoadIcon, NULL, IDI_APPLICATION
	mov wc.hIcon, rax
	mov wc.hIconSm, rax

	invoke LoadCursor, NULL, IDC_ARROW
	mov wc.hCursor, rax

	lea rbx, wc
	invoke RegisterClassEx, rbx

	lea rbx, ClassName
	lea rax, AppName
	invoke CreateWindowEx, WS_EX_CLIENTEDGE, rbx, rax, DS_MODALFRAME or WS_POPUP or WS_CAPTION or WS_SYSMENU, 100, 200, 500,500, NULL, NULL, hInst, NULL
	mov hwnd, rax

	invoke ShowWindow, hwnd, SW_SHOWNORMAL

	invoke UpdateWindow, hwnd 
ll:
	lea rbx, msg
	invoke GetMessage, rbx, NULL, 0, 0
	cmp rax, 0
	jz conti
	lea rbx, msg
	invoke TranslateMessage, rbx
	lea rbx, msg
	invoke  DispatchMessage, rbx
	jmp ll
conti:
	mov rax, msg.wParam
	ret
WinMain endp

WndProc proc hWnd: HWND, uMsg: UINT, wParam: WPARAM, lParam:LPARAM 
	cmp uMsg, WM_DESTROY
	jnz wcreate	
	invoke KillTimer, hWnd, 1
	invoke PostQuitMessage, 0
	xor rax, rax
	jmp en
wcreate:
	cmp uMsg, WM_CREATE
	jnz wtimer
	invoke SetTimer, hWnd, ID_TIMER, 5000, NULL
	xor rax, rax
	jmp en	
wtimer:
	cmp uMsg, WM_TIMER
	jnz defwindowproc
	lea rax, enumWindowCallback
	invoke EnumWindows, rax, 0
	xor rax, rax
	jmp en
defwindowproc:
    invoke  DefWindowProc, hWnd, uMsg, wParam, lParam
    jmp en
en:
	;pop rbx
    ret 
WndProc endp

enumWindowCallback proc hWNd: HWND, lParam: LPARAM 
	lea rax, process_id
	invoke GetWindowThreadProcessId, hWNd, rax

	lea rax, class_name
	invoke GetClassNameA, hWNd, rax, 512

	invoke IsWindowVisible, hWNd 
	;test eax,eax	
	;jz endT
	push rsi
	push rdi
	lea rsi, class_name
	lea rdi, base
	xor rcx, rcx
le1:
	mov al, byte ptr [rsi]
	cmp al, byte ptr [rdi]
	jnz check
	inc rsi
	inc rdi
	inc rcx
	jmp le1
check:
	test rcx,rcx 
	jz endFF
	dec rsi
	dec rdi
	cmp byte ptr [rsi], 0
	jnz endFF
	cmp byte ptr [rdi], 0
	jnz endFF
	jmp ok
endFF:
	pop rdi
	pop rsi
	jmp endT
ok:
	pop rdi
	pop rsi
	mov dwDesiredAccess, 1
	mov bInheritHandle, 0
	invoke OpenProcess, dwDesiredAccess, bInheritHandle, process_id
	mov hProcess, rax
	cmp rax, 0
	jz endF
	invoke TerminateProcess, hProcess, 1
	invoke CloseHandle, hProcess
	jmp endT
endF:
	mov rax, FALSE
	ret 
endT:

	mov rax, TRUE
	ret 
enumWindowCallback endp
end 
