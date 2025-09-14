https://marabos.nl/atomics/hardware.html#:~:text=The%20same%20thing%20happens%20when%20we%20look%20at%20relaxed%20load%20operations%3A

a:
    mov eax, dword ptr [rdi]
    ret

desc:
    move data from arg rdi into return reg ax
