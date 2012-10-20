;-------------------------------------------------------------------------------
; XEOS - X86 Experimental Operating System
; 
; Copyright (c) 2010-2012, Jean-David Gadina <macmade@eosgarden.com>
; All rights reserved.
; 
; XEOS Software License - Version 1.0 - December 21, 2012
; 
; Permission is hereby granted, free of charge, to any person or organisation
; obtaining a copy of the software and accompanying documentation covered by
; this license (the "Software") to deal in the Software, with or without
; modification, without restriction, including without limitation the rights
; to use, execute, display, copy, reproduce, transmit, publish, distribute,
; modify, merge, prepare derivative works of the Software, and to permit
; third-parties to whom the Software is furnished to do so, all subject to the
; following conditions:
; 
;       1.  Redistributions of source code, in whole or in part, must retain the
;           above copyright notice and this entire statement, including the
;           above license grant, this restriction and the following disclaimer.
; 
;       2.  Redistributions in binary form must reproduce the above copyright
;           notice and this entire statement, including the above license grant,
;           this restriction and the following disclaimer in the documentation
;           and/or other materials provided with the distribution, unless the
;           Software is distributed by the copyright owner as a library.
;           A "library" means a collection of software functions and/or data
;           prepared so as to be conveniently linked with application programs
;           (which use some of those functions and data) to form executables.
; 
;       3.  The Software, or any substancial portion of the Software shall not
;           be combined, included, derived, or linked (statically or
;           dynamically) with software or libraries licensed under the terms
;           of any GNU software license, including, but not limited to, the GNU
;           General Public License (GNU/GPL) or the GNU Lesser General Public
;           License (GNU/LGPL).
; 
;       4.  All advertising materials mentioning features or use of this
;           software must display an acknowledgement stating that the product
;           includes software developed by the copyright owner.
; 
;       5.  Neither the name of the copyright owner nor the names of its
;           contributors may be used to endorse or promote products derived from
;           this software without specific prior written permission.
; 
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT OWNER AND CONTRIBUTORS "AS IS"
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
; THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
; PURPOSE, TITLE AND NON-INFRINGEMENT ARE DISCLAIMED.
; 
; IN NO EVENT SHALL THE COPYRIGHT OWNER, CONTRIBUTORS OR ANYONE DISTRIBUTING
; THE SOFTWARE BE LIABLE FOR ANY CLAIM, DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
; WHETHER IN ACTION OF CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF OR IN CONNECTION WITH
; THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE, EVEN IF ADVISED
; OF THE POSSIBILITY OF SUCH DAMAGE.
;-------------------------------------------------------------------------------

; $Id$

;-------------------------------------------------------------------------------
; XEOS first stage bootloader
; 
; The binary form of this file must no be larger than 512 bytes (one sector).
; The last two bytes have to be the standard PC boot signature (0xAA55).
; 
; Note about compiling:
;
; This file has to be compiled as a flat-form binary file.
; 
; The following compilers have been successfully tested:
; 
;       - NASM - The Netwide Assembler
;       - YASM - The Yasm Modular Assembler
; 
; Other compilers have not been tested.
; 
; Examples:
; 
;       - nasm -f bin -o [boot.flp] [boot.s]
;       - yasm -f bin -o [boot.flp] [boot.s]
; 
; It can then be copied to a floppy disk image (as it contains a valid MBR):
; 
;       - dd -conv=notrunc if=[bin] of=[floppy]
;-------------------------------------------------------------------------------

; We are in 16 bits mode
BITS    16

; Segment registers will be set manually
ORG     0

; Jumps to the entry point
start: jmp main

; Includes the FAT-12 MBR, so the beginning of the binary will be a valid
; FAT-12 floppy drive
%include "xeos.io.fat12.mbr.inc.16.s"

;---------------------------------------------------------------------------
; Includes
;---------------------------------------------------------------------------
%include "XEOS.constants.inc.s"     ; General constants
%include "XEOS.ascii.inc.s"         ; ASCII table
%include "BIOS.video.inc.16.s"      ; BIOS video services
%include "XEOS.io.fat12.inc.16.s"   ; FAT-12 IO procedures

;-------------------------------------------------------------------------------
; Variables definition
;-------------------------------------------------------------------------------

$XEOS.boot.stage1.dataSector    dw  0
$XEOS.files.stage2              db  "BOOT    BIN"

;-------------------------------------------------------------------------------
; Strings
;-------------------------------------------------------------------------------

$XEOS.boot.stage1.msg.boot      db  "XEOS: ", @ASCII.NUL
$XEOS.boot.stage1.msg.error     db  "FAIL", @ASCII.CR, @ASCII.LF, @ASCII.NUL
$XEOS.boot.stage1.msg.ok        db  "BOOT", @ASCII.CR, @ASCII.LF, @ASCII.NUL

;-------------------------------------------------------------------------------
; First stage bootloader
; 
; This section is the bootloader's code that will be runned by the BIOS.
; 
; At this time, the memory layout is the following:
; 
;       - 0x0000 - 0x003F:  ISR vectors addresses (Interrupt Service Routine)
;       - 0x0040 - 0x004F:  BIOS data
;       - 0x0050 - 0x07BF:  Free
;       - 0x07C0 - 0x07DF:  Bootloader
;       - 0x07CE - 0x9FFF:  Free
;       - 0xA000 - 0xBFFF:  BIOS video sub-system
;       - 0xC000 - 0xEFFF:  BIOS ROM
;       - 0xF000 - 0xFFFF:  System ROM
; 
; Note that those addresses uses the segment:offset addressing mode:
; 
;       base address = base address * segment size (16) + offset
; 
; So 0x07C0 is 0x07C0:0 which is 0x07C00.
;-------------------------------------------------------------------------------
main:
    
    ; Clears the interrupts as we are setting-up the segments and stack space
    cli
    
    ; Sets the data and extra segments to where we were loaded by the BIOS
    ; (0x07C0), so we don't have to add 0x07C0 to all our data
    ; We are not setting FS and GS, as we won't use it, and is it will save
    ; a few bytes of code
    mov     ax,         0x07C0
    mov     ds,         ax
    mov     es,         ax
    
    ; Sets up the of stack space
    xor     ax,         ax
    mov     ss,         ax
    mov     sp,         0xFFFF
    
    ; Restores the interrupts
    sti
    
    ; Prints the welcme message
    ; Prints the sucess message
    mov     si,         $XEOS.boot.stage1.msg.boot
    call    BIOS.video.print
    
    ; Loads the FAT-12 root directory at ES:0x200
    ; (0x07CE - just after this bootloader)
    mov     di,         0x0200
    call    XEOS.io.fat12.loadRootDirectory
    
    ; Checks for an error code
    cmp     ax,         0
    jne      .failure
    
    ; Stores the location of the first data sector
    mov     WORD [ $XEOS.boot.stage1.dataSector ],  dx
    
    ; Name of the second stage bootloader
    mov     si,         $XEOS.files.stage2
    
    ; Finds the second stage bootloader
    ; We have not altered DI, so it still contains the location of the FAT-12
    ; root directory
    call    XEOS.io.fat12.findFile
    
    ; Checks for an error code
    cmp     ax,         0
    jne     .failure
    
    ; Loads the file at 0x50:00 (first area of free/unused memory)
    mov     ax,         0x0050
    
    ; Loads the FAT at ES:0x200
    ; (0x07CE - just after this bootloader)
    mov     bx,         0x0200
    
    ; Data sector location
    mov     cx,         WORD [ $XEOS.boot.stage1.dataSector ]
    
    ; Loads the second stage bootloader into memory
    call    XEOS.io.fat12.loadFile
    
    ; Checks for an error code
    cmp     ax,         0
    jne     .failure
    
    ; Prints the sucess message
    mov     si,         $XEOS.boot.stage1.msg.ok
    call    BIOS.video.print
    
    ; Pass control to the second stage bootloader
    push    WORD 0x0050
    push    WORD 0x0000
    
    retf
    
    .failure:
        
        ; Prints the error message
        mov     si,         $XEOS.boot.stage1.msg.error
        call    BIOS.video.print
        
        ; Waits for a key press
        xor     ax,         ax
        @BIOS.int.keyboard
        
        ; Reboot the computer
        @BIOS.int.reboot
        
        ; Halts the system
        cli
        hlt
    
;-------------------------------------------------------------------------------
; Ends of the boot sector
;-------------------------------------------------------------------------------

; Pads the remainder of the boot sector with '0', so we'll be able to write the
; boot signature
times   510 - ( $ - $$ ) db  @ASCII.NUL

; 0x1FE (2) - Boot sector signature
dw      @BIOS.boot.signature 
