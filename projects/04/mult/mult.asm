// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// for (i=0; i<R0; i++) {
//   R2 += R1
// }

@i
M=0 // i = 0
@R2
M=0 // reset R2

(LOOP)
  // if (i == R0) GOTO END
  @i
  D=M
  @R0
  D=D-M
  @END
  D;JEQ 

  // R2 += R1
  @R1
  D=M
  @R2
  M=M+D

  // i = i + 1
  @i
  M=M+1

  @LOOP
  0;JMP

(END)
  @END
  0;JMP