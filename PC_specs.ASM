;=========================FASM=========================FASM=========================FASM=========================
format PE console
include 'win32ax.inc'
entry start

section '.data' data readable writeable
        cpuv db ?
        buff dd 8*8
        tpts:   db  ''
        id: db  17 dup(0)

section '.code' code readable executable

start:

        push eax
        push ebx
        push ecx
        push edx

        invoke   GlobalMemoryStatusEx, buff

        mov eax,[buff+08h]
        mov edx,[buff+08h+4]
        shrd eax,edx,20
        cinvoke printf, <'RAM',10,'Total   : %d Mb',10,0>,eax

        mov eax,[buff+10h]
        mov edx,[buff+10h+4]
        shrd eax,edx,20
        mov edx,100
        sub edx,[buff+04h]
        cinvoke printf, <'Free    : %d Mb, %d%%',10,10,0>,eax,edx

        mov eax,0
        mov ebx,0
        mov ecx,0
        mov edx,0

        cpuid                             ;EBX,EDX,ECX

        lea esi,[cpuv]
        mov [esi],ebx
        mov [esi+4],edx
        mov [esi+8],ecx

        cinvoke printf, <'Processor',10,'Manufacturer : %s',10,0>,cpuv

        mov edi, 80000002h
@@:     mov eax, edi
        mov esi, id
        cpuid
        mov [esi],eax
        mov [esi+4],ebx
        mov [esi+8],ecx
        mov [esi+0Ch],edx
 
        cinvoke printf, tpts, id
        inc edi
        cmp di, 5
        jb  @B

        cinvoke scanf

        pop edx
        pop ecx
        pop ebx
        pop eax

        invoke ExitProcess,0

section '.idata' import data readable
library kernel32, 'kernel32.dll',\
        msvcrt, 'msvcrt.dll'
 
import kernel32,\
       GlobalMemoryStatusEx, 'GlobalMemoryStatusEx',\
       ExitProcess, 'ExitProcess'
 
import msvcrt,\
       printf, 'printf',\
        scanf, 'scanf'