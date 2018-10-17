format PE GUI 4.0

include 'win32ax.inc'

section '.data' data readable writeable
        _cpu db 'CPU: ',0
        _ram db 'RAM: ',0
        _cpuv dd ?
        _ramv db ?
        _tmp dd 'ntel'

.code

start:
                                  ;EBX,EDX,ECX

        push ebx
        push ecx
        push edx

        ;cdq
        mov eax,0
        cpuid

        mov [_cpuv],ecx

        invoke MessageBox,HWND_DESKTOP,_cpuv,_cpu,MB_OK
        ;invoke MessageBox,HWND_DESKTOP,_ramv,_ram,MB_OK

        pop edx
        pop ecx
        pop ebx
        pop eax

        invoke ExitProcess,0

.end start