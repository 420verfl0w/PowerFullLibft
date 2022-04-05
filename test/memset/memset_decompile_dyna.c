// https://code.woboq.org/userspace/glibc/elf/rtld.c.html#rtld_global_ro


void *memset(void)
{
    uint32_t uVar1;
    undefined8 uVar2;

    uVar2 = 0xbbf70;
    if ((*(uint32_t *)(__rtld_global_ro + 0xcc) & 0x1000) == 0) {
        if ((*(uint64_t *)(__rtld_global_ro + 200) & 0x400000000004) == 4) {
            uVar2 = 0x190050;
            if ((*(uint32_t *)(__rtld_global_ro + 0xcc) & 0x800) == 0) {
                uVar2 = 0x190900;
                if ((*(uint8_t *)(__rtld_global_ro + 0x7d) & 2) == 0) {
                    uVar2 = 0x190890;
                }
                return uVar2;
            }
        } else {
            uVar1 = *(uint32_t *)(__rtld_global_ro + 0x7c) & 0x200;
            if ((*(uint8_t *)(__rtld_global_ro + 200) & 2) != 0) {
                uVar2 = 0x18ba70;
                if (uVar1 == 0) {
                    uVar2 = 0x18ba10;
                }
                return uVar2;
            }
            uVar2 = 0xbbf20;
            if (uVar1 != 0) {
                uVar2 = 0xbbfa0;
            }
        }
    }
    return (uVar2);
}
