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
; String procedures
; 
; Those procedures and macros are intended to be used only in 16 bits real mode.
;-------------------------------------------------------------------------------
%ifndef __XEOS_STRING_INC_16_ASM__
%define __XEOS_STRING_INC_16_ASM__

;-------------------------------------------------------------------------------
; Includes
;-------------------------------------------------------------------------------
%include "XEOS.constants.inc.s"       ; General constants
%include "XEOS.macros.inc.s"          ; General macros
%include "XEOS.ascii.inc.s"           ; ASCII table

; We are in 16 bits mode
BITS    16

;-------------------------------------------------------------------------------
; Converts an unsigned binary bumber into a string representation
; 
; Input registers:
;       
;       - AX:       The unsigned binary number
;       - BX:       The base in which to convert the number
;       - CX:       Only for base 16: zero padding
;       - DX:       Only for base 16: if 1, prefix with 0x, otherwise don't
;       - DI:       The destination byte buffer for the string
; 
; Return registers:
;       
;       None
; 
; Killed registers:
;       
;       None
;-------------------------------------------------------------------------------
XEOS.string.utoa:

    ; Saves registers
    pusha
    
    ; Checks if we are going to print in hexadecimal
    cmp     ebx,        16
    je      .hexPrefix
    
    ; Checks if we are going to print in decimal
    cmp     ebx,        10
    je      .start
    
    ; Checks if we are going to print in octal
    cmp     ebx,        8
    je      .start
    je      .start
    
    ; Checks if we are going to print in binary
    cmp     ebx,        2
    je      .start
    
    ; Restore registers
    popa
    
    ret
    
    .hexPrefix:
        
        ; Stores the padding
        mov     si,         cx
        
        ; Chekcs if we need to prefix with 0x
        cmp     dx,         1
        jne     .start
        
        ; Adds the 0x prefix for the hexadecimal
        mov     [ di ],     BYTE 0x30
        mov     [ di + 1 ], BYTE 0x78
        add     di,         2
    
    .start:
        
        ; Resets ECX (digit counter)
        xor     ecx,        ecx
        
    .divide:
        
        ; Resets EDX
        xor     edx,        edx
        
        ; Divides by the base
        div     ebx
        
        ; Saves reminder
        push    edx
        
        ; Increments ECX (digit counter)
        inc     ecx
        
        ; Loop till we reach 0
        cmp     eax,         0
        jg      .divide
        
        ; Checks if we are going to print in hexadecimal
        cmp     ebx,        16
        jne     .dec
    
    .hex:
        
        ; Pushes the counter
        push    cx
        
        ; Padding
        cmp     si,         cx
        jle     .padDone
        
        ; Number of zeros for padding
        sub     si,     cx
        mov     cx,     si
        
        .pad:
            
            ; Adds a 0 for padding
            mov     [ di ],     BYTE 0x30
            inc     di
            
            ; Continues padding
            loop    .pad
            
        .padDone:
            
            ; Restores the counter
            pop     cx
            
        .hexChar:
            
            ; Restores the reminder
            pop     eax
            
            ; Checks if we must print a digit or a letter
            cmp    eax,         9
            jg      .letter
            
        .number:
            
            ; Number - Adds 48 (ASCII for '0')
            add     al,         0x30
            jmp     .store
            
        .letter:
            
            ; Letter - Adds 65 (ASCII for 'A')
            sub     al,         10
            add     al,         0x41
            
        .store:
            
            ; Stores the character
            mov     [ di ],     BYTE al
            inc     di
            
            ; Continue till we have digits to print
            loop    .hexChar
            
            jmp     .end
            
    .dec:
        
        ; Restores the reminder
        pop     eax
        
        ; Adds 48 (ASCII for '0')
        add     al,         0x30
        
        ; Stores the character
        mov     [ di ],     BYTE al
        inc     di
        
        ; Continue till we have digits to print
        loop    .dec
        
    .end:
        
        ; Adds the terminating character (ASCII 0)
        mov     [ di ],     BYTE 0
    
    ; Restore registers
    popa
    
    ret
    
%endif