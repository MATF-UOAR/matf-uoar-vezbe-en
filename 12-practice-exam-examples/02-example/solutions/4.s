.text

.align 2

.global count_typical

// int count_typical(unsigned long *a, int n);
// w0                x0               w1
count_typical:
	stp fp, lr, [sp, #-16]!
	mov fp, sp
	sub sp, sp, #32

    // -------------------- <- sp = fp - 32
    //
    //  space for median
    // -------------------- <- fp - 24
    //
    //  space for mean
    // -------------------- <- fp - 16
    //  address alignment
    // -------------------- <- fp - 12
    //  space for n
    // -------------------- <- fp - 8
    //
    //  space for a
    // -------------------- <- fp

    str x0, [fp, #-8]
    str w1, [fp, #-12]
    sub x2, fp, #24  // address of mean
    sub x3, fp, #32  // address of median
    bl statistics    // fills stack memory passed as the 3rd and 4th args

    ldr x0, [fp, #-8]
    ldr w1, [fp, #-12]
    ldr x4, [fp, #-24]  // x4 - mean
    ldr x5, [fp, #-32]  // x5 - median
    cmp x4, x5          // compare mean and median
    csel x2, x4, x5, lo // smaller value goes into x2
    csel x3, x4, x5, hi // larger value goes into x3

    bl count_in_range

	mov sp, fp
	ldp fp, lr, [sp], #16
	ret
