
.text
.code	32

# SHA256 assembly implementation for ARMv8 AArch32

.global	sha256_block_data_order
.type	sha256_block_data_order,%function
.align  2
sha256_block_data_order:

.Lsha256prolog:

    vpush       {q4}
    vldmia      r0, {s0, s1, s2, s3, s4, s5, s6, s7}
    add         r2, r1, r2, lsl #6

.Lsha256loop:

    vld1.32     {d16-d19}, [r1]!
    adr         r3, .LKConstant256
    vmov        q2, q0
    vmov        q3, q1 
    vld1.32     {d20-d23}, [r1]!

    vrev32.8        q8, q8
    vldmia          r3!, {d24, d25}
    vrev32.8        q9, q9
    vrev32.8        q10, q10
    vldmia          r3!, {d26, d27}
    vadd.i32        q12, q8,  q12
    sha256su0.32    q8, q9
    vrev32.8        q11, q11
    vldmia          r3!, {d28, d29}
    vadd.i32        q13, q9,  q13
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q12
    sha256h2.32     q3,  q4,  q12
    sha256su0.32    q9, q10
    sha256su1.32    q8, q10, q11
    vldmia          r3!, {d30, d31}
    vadd.i32        q14, q10, q14
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q13
    sha256h2.32     q3,  q4,  q13
    sha256su0.32    q10, q11
    sha256su1.32    q9, q11, q8
    vldmia          r3!, {d24, d25}
    vadd.i32        q15, q11, q15
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q14
    sha256h2.32     q3,  q4,  q14
    sha256su0.32    q11, q8
    sha256su1.32    q10, q8, q9
    vldmia          r3!, {d26, d27}
    vadd.i32        q12, q8,  q12
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q15
    sha256h2.32     q3,  q4,  q15
    sha256su0.32    q8, q9
    sha256su1.32    q11, q9, q10
    vldmia          r3!, {d28, d29}
    vadd.i32        q13, q9,  q13
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q12
    sha256h2.32     q3,  q4,  q12
    sha256su0.32    q9, q10
    sha256su1.32    q8, q10, q11
    vldmia          r3!, {d30, d31}
    vadd.i32        q14, q10, q14
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q13
    sha256h2.32     q3,  q4,  q13
    sha256su0.32    q10, q11
    sha256su1.32    q9, q11, q8
    vldmia          r3!, {d24, d25}
    vadd.i32        q15, q11, q15
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q14
    sha256h2.32     q3,  q4,  q14
    sha256su0.32    q11, q8
    sha256su1.32    q10, q8, q9
    vldmia          r3!, {d26, d27}
    vadd.i32        q12, q8,  q12
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q15
    sha256h2.32     q3,  q4,  q15
    sha256su0.32    q8, q9
    sha256su1.32    q11, q9, q10
    vldmia          r3!, {d28, d29}
    vadd.i32        q13, q9,  q13
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q12
    sha256h2.32     q3,  q4,  q12
    sha256su0.32    q9, q10
    sha256su1.32    q8, q10, q11
    vldmia          r3!, {d30, d31}
    vadd.i32        q14, q10, q14
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q13
    sha256h2.32     q3,  q4,  q13
    sha256su0.32    q10, q11
    sha256su1.32    q9, q11, q8
    vldmia          r3!, {d24, d25}
    vadd.i32        q15, q11, q15
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q14
    sha256h2.32     q3,  q4,  q14
    sha256su0.32    q11, q8
    sha256su1.32    q10, q8, q9
    vldmia          r3!, {d26, d27}
    vadd.i32        q12, q8,  q12
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q15
    sha256h2.32     q3,  q4,  q15
    sha256su1.32    q11, q9, q10
    vldmia          r3!, {d28, d29}
    vadd.i32        q13, q9,  q13
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q12
    sha256h2.32     q3,  q4,  q12
    vldmia          r3!, {d30, d31}
    vadd.i32        q14, q10, q14
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q13
    sha256h2.32     q3,  q4,  q13
    vadd.i32        q15, q11, q15
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q14
    sha256h2.32     q3,  q4,  q14
    vmov            q4,  q2
    sha256h.32      q2,  q3,  q15
    sha256h2.32     q3,  q4,  q15   
    teq             r1, r2
    vadd.i32        q0, q0, q2
    vadd.i32        q1, q1, q3
    bne             .Lsha256loop

.Lsha256epilog:

    vstmia      r0, {s0, s1, s2, s3, s4, s5, s6, s7}
    vpop        {q4}
    bx          lr

.align  5
.LKConstant256:
.word   0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5
.word   0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5
.word   0xd807aa98,0x12835b01,0x243185be,0x550c7dc3
.word   0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174
.word   0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc
.word   0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da
.word   0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7
.word   0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967
.word   0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13
.word   0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85
.word   0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3
.word   0xd192e819,0xd6990624,0xf40e3585,0x106aa070
.word   0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5
.word   0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3
.word   0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208
.word   0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2

.size   sha256_block_data_order,.-sha256_block_data_order
.align	2

