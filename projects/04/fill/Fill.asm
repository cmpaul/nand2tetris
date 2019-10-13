// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// do {
//   key = keyboard
//   if (key == prevkey) {
//     continue
//   }
//   if (key == 0) {
//     color = white
//   } else {
//     color = black
//   }
//   address = screen
//   max_address = keyboard
//   while (address < max_address) {
//     address = color
//     address += 32
//   }
//   prevkey = key
// }

// initialize prevkey = 0
@prevkey
M=0

(LOOP)
  // Capture the current key press
  @KBD
  D=M
  @key
  M=D

  // Compare to the previous key press
  @prevkey
  D=D-M
  @LOOP
  D;JEQ // continue if they're equal

  // Re-load the current key press
  @key
  D=M
  @WHITE
  D;JEQ // Turn the screen white if it's zero

  // Turn the screen black
  @color
  M=-1
  @REDRAW
  0;JMP

(WHITE)
  @color
  M=0

(REDRAW)
  // Initialize the screen
  @SCREEN
  D=A
  @address
  M=D // address = 16384 (base address of SCREEN)

  // Initialize the loop
  @KBD
  D=A
  @maxaddress
  M=D // maxaddress = 24576 (base address of KBD)

(DRAWLOOP)
  @address
  D=M
  @maxaddress
  D=D-M
  @DRAWLOOPEND
  D;JGT

  @color
  D=M
  @address
  A=M
  M=D // RAM[address] = color (16px)

  @1
  D=A
  @address
  M=D+M // move address to the next register
  @DRAWLOOP
  0;JMP // goto DRAWLOOP

(DRAWLOOPEND)
  // prevkey = key
  @key
  D=M
  @prevkey
  M=D

  @LOOP
  0;JMP
