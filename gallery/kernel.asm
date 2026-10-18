; 64-bit Linux ELF entry point and string print routine
section .data
    msg:    db "System initialized successfully.", 10
    msg_len: equ $ - msg

section .text
    global _start

_start:
    ; sys_write(stdout, msg, msg_len)
    mov rax, 1          ; SYS_write
    mov rdi, 1          ; fd: stdout
    lea rsi, [rel msg]  ; pointer to buffer
    mov rdx, msg_len    ; count
    syscall

    ; sys_exit(0)
    mov rax, 60         ; SYS_exit
    xor rdi, rdi        ; exit code 0
    syscall
