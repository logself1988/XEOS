/*
 * Some or all of this work - Copyright (c) 2006 - 2012, Intel Corp.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 *  Thermal Zone
 *
 * (verify exceptions caused by the imprope use of Thermal Zone type objects)
 */

Name(z105, 105)

ThermalZone (tz00) {Name(n000, "tz00")}

// Expected exceptions:
//
// 47 - AE_AML_OPERAND_TYPE
//
Method(m4bd)
{
	Name(ts, "m4bd")

	ThermalZone (tz01) {Name(n000, "tz01")}

	Event(e000)

	Name(i000, 0)

	// Local Named Object
	Method(m000, 1)
	{
		ThermalZone (tz02) {Name(n000, "tz02")}

		DerefOf(tz02)
		CH06(arg0, 0, 47)
	}

	// Global Named Object
	Method(m001, 1)
	{
		if (y083) {
			DerefOf(tz00)
			CH06(arg0, 1, 47)
		}
	}

	// Local
	Method(m002, 1)
	{
		ThermalZone (tz02) {Name(n000, "tz02")}

		Event(e000)

		CopyObject(tz02, Local0)

		// CondRefOf
		
		CondRefOf(Local0)
		CH03(ts, z105, 0, 0, 0)

		CondRefOf(Local0, Local1)
		CH03(ts, z105, 1, 0, 0)

		// CopyObject

		CopyObject(Local0, Local1)
		CH03(ts, z105, 2, 0, 0)

		// Decrement

		Decrement(Local0)
		CH06(arg0, 1, 47)

		// DerefOf

		DerefOf(Local0)
		CH06(arg0, 2, 47)

		// FindSetLeftBit

		FindSetLeftBit(Local0)
		CH06(arg0, 3, 47)

		FindSetLeftBit(Local0, Local1)
		CH06(arg0, 4, 47)

		// FindSetRightBit

		FindSetRightBit(Local0)
		CH06(arg0, 5, 47)

		FindSetRightBit(Local0, Local1)
		CH06(arg0, 6, 47)

		// FromBCD

		FromBCD(Local0)
		CH06(arg0, 7, 47)

		FromBCD(Local0, Local1)
		CH06(arg0, 8, 47)

		// Increment

		Increment(Local0)
		CH06(arg0, 9, 47)

		// LNot

		LNot(Local0)
		CH06(arg0, 10, 47)

		// Not

		Not(Local0)
		CH06(arg0, 11, 47)

		Not(Local0, Local1)
		CH06(arg0, 12, 47)

		// ObjectType

		ObjectType(Local0)
		CH03(ts, z105, 3, 0, 0)

		// RefOf

		RefOf(Local0)
		CH03(ts, z105, 4, 0, 0)

		// Release

		Release(Local0)
		CH06(arg0, 13, 47)

		// Reset

		Reset(Local0)
		CH06(arg0, 14, 47)

		// Signal

		Signal(Local0)
		CH06(arg0, 15, 47)

		// SizeOf

		SizeOf(Local0)
		CH06(arg0, 16, 47)

		// Sleep

		Sleep(Local0)
		CH06(arg0, 17, 47)

		// Stall

		Stall(Local0)
		CH06(arg0, 18, 47)

		// Store

		Store(Local0, Local1)
		CH06(arg0, 19, 47)

		// ToBCD

		ToBCD(Local0)
		CH06(arg0, 20, 47)

		ToBCD(Local0, Local1)
		CH06(arg0, 21, 47)

		// ToBuffer

		ToBuffer(Local0)
		CH06(arg0, 22, 47)

		ToBuffer(Local0, Local1)
		CH06(arg0, 23, 47)

		// ToDecimalString

		ToDecimalString(Local0)
		CH06(arg0, 24, 47)

		ToDecimalString(Local0, Local1)
		CH06(arg0, 25, 47)

		// ToHexString

		ToHexString(Local0)
		CH06(arg0, 26, 47)

		ToHexString(Local0, Local1)
		CH06(arg0, 27, 47)

		// ToInteger

		ToInteger(Local0)
		CH06(arg0, 28, 47)

		ToInteger(Local0, Local1)
		CH06(arg0, 29, 47)

		// Acquire

		Acquire(Local0, 100)
		CH06(arg0, 30, 47)

		// Add

		Add(Local0, i000)
		CH06(arg0, 31, 47)

		Add(i000, Local0)
		CH06(arg0, 32, 47)

		Add(Local0, i000, Local1)
		CH06(arg0, 33, 47)

		Add(i000, Local0, Local1)
		CH06(arg0, 34, 47)

		// And

		And(Local0, i000)
		CH06(arg0, 35, 47)

		And(i000, Local0)
		CH06(arg0, 36, 47)

		And(Local0, i000, Local1)
		CH06(arg0, 37, 47)

		And(i000, Local0, Local1)
		CH06(arg0, 38, 47)

		// Concatenate

		Concatenate(Local0, i000)
		CH06(arg0, 39, 47)

		Concatenate(i000, Local0)
		CH06(arg0, 40, 47)

		Concatenate(Local0, i000, Local1)
		CH06(arg0, 41, 47)

		Concatenate(i000, Local0, Local1)
		CH06(arg0, 42, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(Local0, ResourceTemplate(){})
		CH06(arg0, 43, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, Local0)
		CH06(arg0, 44, 47)

		ConcatenateResTemplate(Local0, ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, Local0, Local1)
		CH06(arg0, 46, 47)

		// Divide

		Divide(Local0, i000)
		CH06(arg0, 47, 47)

		Divide(i000, Local0)
		CH06(arg0, 48, 47)

		Divide(Local0, i000, Local2)
		CH06(arg0, 49, 47)

		Divide(i000, Local0, Local2)
		CH06(arg0, 50, 47)

		Divide(Local0, i000, Local2, Local1)
		CH06(arg0, 51, 47)

		Divide(i000, Local0, Local2, Local1)
		CH06(arg0, 52, 47)

		// Fatal

		Fatal(0xff, 0xffffffff, Local0)
		CH06(arg0, 53, 47)

		// Index

		Index(Local0, 0)
		CH06(arg0, 54, 47)

		Index("0", Local0)
		CH06(arg0, 55, 47)

		Index(Local0, 0, Local1)
		CH06(arg0, 56, 47)

		Index("0", Local0, Local1)
		CH06(arg0, 57, 47)

		// LEqual

		LEqual(Local0, i000)
		CH06(arg0, 58, 47)

		LEqual(i000, Local0)
		CH06(arg0, 59, 47)

		// LGreater

		LGreater(Local0, i000)
		CH06(arg0, 60, 47)

		LGreater(i000, Local0)
		CH06(arg0, 61, 47)

		// LGreaterEqual

		LGreaterEqual(Local0, i000)
		CH06(arg0, 62, 0xff)

		LGreaterEqual(i000, Local0)
		CH06(arg0, 63, 0xff)

		// LLess

		LLess(Local0, i000)
		CH06(arg0, 64, 47)

		LLess(i000, Local0)
		CH06(arg0, 65, 47)

		// LLessEqual

		LLessEqual(Local0, i000)
		CH06(arg0, 66, 0xff)

		LLessEqual(i000, Local0)
		CH06(arg0, 67, 0xff)

		// LNotEqual

		LNotEqual(Local0, i000)
		CH06(arg0, 68, 0xff)

		LNotEqual(i000, Local0)
		CH06(arg0, 69, 0xff)

		// LOr

		LOr(Local0, i000)
		CH06(arg0, 70, 47)

		LOr(i000, Local0)
		CH06(arg0, 71, 47)

		// Mod

		Mod(Local0, i000)
		CH06(arg0, 72, 47)

		Mod(i000, Local0)
		CH06(arg0, 73, 47)

		Mod(Local0, i000, Local1)
		CH06(arg0, 74, 47)

		Mod(i000, Local0, Local1)
		CH06(arg0, 75, 47)

		// Multiply

		Multiply(Local0, i000)
		CH06(arg0, 76, 47)

		Multiply(i000, Local0)
		CH06(arg0, 77, 47)

		Multiply(Local0, i000, Local1)
		CH06(arg0, 78, 47)

		Multiply(i000, Local0, Local1)
		CH06(arg0, 79, 47)

		// NAnd

		NAnd(Local0, i000)
		CH06(arg0, 80, 47)

		NAnd(i000, Local0)
		CH06(arg0, 81, 47)

		NAnd(Local0, i000, Local1)
		CH06(arg0, 82, 47)

		NAnd(i000, Local0, Local1)
		CH06(arg0, 83, 47)

		// NOr

		NOr(Local0, i000)
		CH06(arg0, 84, 47)

		NOr(i000, Local0)
		CH06(arg0, 85, 47)

		NOr(Local0, i000, Local1)
		CH06(arg0, 86, 47)

		NOr(i000, Local0, Local1)
		CH06(arg0, 87, 47)

		// Or

		Or(Local0, i000)
		CH06(arg0, 88, 47)

		Or(i000, Local0)
		CH06(arg0, 89, 47)

		Or(Local0, i000, Local1)
		CH06(arg0, 90, 47)

		Or(i000, Local0, Local1)
		CH06(arg0, 91, 47)

		// ShiftLeft

		ShiftLeft(Local0, i000)
		CH06(arg0, 92, 47)

		ShiftLeft(i000, Local0)
		CH06(arg0, 93, 47)

		ShiftLeft(Local0, i000, Local1)
		CH06(arg0, 94, 47)

		ShiftLeft(i000, Local0, Local1)
		CH06(arg0, 95, 47)

		// ShiftRight

		ShiftRight(Local0, i000)
		CH06(arg0, 96, 47)

		ShiftRight(i000, Local0)
		CH06(arg0, 97, 47)

		ShiftRight(Local0, i000, Local1)
		CH06(arg0, 98, 47)

		ShiftRight(i000, Local0, Local1)
		CH06(arg0, 99, 47)

		// Subtract

		Subtract(Local0, i000)
		CH06(arg0, 100, 47)

		Subtract(i000, Local0)
		CH06(arg0, 101, 47)

		Subtract(Local0, i000, Local1)
		CH06(arg0, 102, 47)

		Subtract(i000, Local0, Local1)
		CH06(arg0, 103, 47)

		// ToString

		ToString(Local0, 1)
		CH06(arg0, 104, 47)

		ToString(i000, Local0)
		CH06(arg0, 105, 47)

		ToString(Local0, 1, Local1)
		CH06(arg0, 106, 47)

		ToString(i000, Local0, Local1)
		CH06(arg0, 107, 47)

		// Wait

		Wait(Local0, i000)
		CH06(arg0, 108, 47)

		Wait(e000, Local0)
		CH06(arg0, 109, 47)

		// XOr

		XOr(Local0, i000)
		CH06(arg0, 110, 47)

		XOr(i000, Local0)
		CH06(arg0, 111, 47)

		XOr(Local0, i000, Local1)
		CH06(arg0, 112, 47)

		XOr(i000, Local0, Local1)
		CH06(arg0, 113, 47)

		// Mid

		Mid(Local0, 1, 1)
		CH06(arg0, 114, 47)

		Mid("123", Local0, 1)
		CH06(arg0, 115, 47)

		Mid("123", 1, Local0)
		CH06(arg0, 116, 47)

		Mid(Local0, 1, 1, Local1)
		CH06(arg0, 117, 47)

		Mid("123", Local0, 1, Local1)
		CH06(arg0, 118, 47)

		Mid("123", 1, Local0, Local1)
		CH06(arg0, 119, 47)

		// Match

		Match(Local0, MTR, 0, MTR, 0, 0)
		CH06(arg0, 120, 47)

		Match(Package(){1}, MTR, Local0, MTR, 0, 0)
		CH06(arg0, 121, 47)

		Match(Package(){1}, MTR, 0, MTR, Local0, 0)
		CH06(arg0, 122, 47)

		Match(Package(){1}, MTR, 0, MTR, 0, Local0)
		CH06(arg0, 123, 47)
	}

	// Reference to Object
	Method(m003, 3)
	{
		Name(EXC0, 47)	// AE_AML_OPERAND_TYPE

		Store(ObjectType(arg1), Local0)
		if (LNotEqual(Local0, 13)) {
			err(arg0, z105, 200, 0, 0, Local0, 13)
			return (1)
		}

		if (arg2) {
			if (LNot(y503)) {
				Store(62, EXC0)	// AE_AML_NO_RETURN_VALUE
			}
		}

		DeRefOf(arg1)
		CH03(ts, z105, 5, 0, 0)

		// CondRefOf
		
		CondRefOf(DeRefOf(arg1))
		CH06(arg0, 0, EXC0)

		CondRefOf(DeRefOf(arg1), Local1)
		CH06(arg0, 1, EXC0)

		// CopyObject

		CopyObject(DeRefOf(arg1), Local1)
		CH06(arg0, 2, EXC0)

		// Decrement

		Decrement(DeRefOf(arg1))
		CH06(arg0, 3, EXC0)

		// DerefOf

		DerefOf(DeRefOf(arg1))
		CH06(arg0, 4, EXC0)

		// FindSetLeftBit

		FindSetLeftBit(DeRefOf(arg1))
		CH06(arg0, 5, EXC0)

		FindSetLeftBit(DeRefOf(arg1), Local1)
		CH06(arg0, 6, EXC0)

		// FindSetRightBit

		FindSetRightBit(DeRefOf(arg1))
		CH06(arg0, 7, EXC0)

		FindSetRightBit(DeRefOf(arg1), Local1)
		CH06(arg0, 8, EXC0)

		// FromBCD

		FromBCD(DeRefOf(arg1))
		CH06(arg0, 9, EXC0)

		FromBCD(DeRefOf(arg1), Local1)
		CH06(arg0, 10, EXC0)

		// Increment

		Increment(DeRefOf(arg1))
		CH06(arg0, 11, EXC0)

		// LNot

		LNot(DeRefOf(arg1))
		CH06(arg0, 12, EXC0)

		// Not

		Not(DeRefOf(arg1))
		CH06(arg0, 13, EXC0)

		Not(DeRefOf(arg1), Local1)
		CH06(arg0, 14, EXC0)

		// ObjectType

		ObjectType(DeRefOf(arg1))
		CH03(ts, z105, 6, 0, 0)

		// RefOf

		RefOf(DeRefOf(arg1))
		CH06(arg0, 15, EXC0)

		// Release

		// Reset

		// Signal

		// SizeOf

		SizeOf(DeRefOf(arg1))
		CH06(arg0, 16, EXC0)

		// Sleep

		Sleep(DeRefOf(arg1))
		CH06(arg0, 17, EXC0)

		// Stall

		Stall(DeRefOf(arg1))
		CH06(arg0, 18, EXC0)

		// Store

		Store(DeRefOf(arg1), Local1)
		CH06(arg0, 19, EXC0)

		// ToBCD

		ToBCD(DeRefOf(arg1))
		CH06(arg0, 20, EXC0)

		ToBCD(DeRefOf(arg1), Local1)
		CH06(arg0, 21, EXC0)

		// ToBuffer

		ToBuffer(DeRefOf(arg1))
		CH06(arg0, 22, EXC0)

		ToBuffer(DeRefOf(arg1), Local1)
		CH06(arg0, 23, EXC0)

		// ToDecimalString

		ToDecimalString(DeRefOf(arg1))
		CH06(arg0, 24, EXC0)

		ToDecimalString(DeRefOf(arg1), Local1)
		CH06(arg0, 25, EXC0)

		// ToHexString

		ToHexString(DeRefOf(arg1))
		CH06(arg0, 26, EXC0)

		ToHexString(DeRefOf(arg1), Local1)
		CH06(arg0, 27, EXC0)

		// ToInteger

		ToInteger(DeRefOf(arg1))
		CH06(arg0, 28, EXC0)

		ToInteger(DeRefOf(arg1), Local1)
		CH06(arg0, 29, EXC0)

		// Acquire

		// Add

		Add(DeRefOf(arg1), i000)
		CH06(arg0, 31, EXC0)

		Add(i000, DeRefOf(arg1))
		CH06(arg0, 32, EXC0)

		Add(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 33, EXC0)

		Add(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 34, EXC0)

		// And

		And(DeRefOf(arg1), i000)
		CH06(arg0, 35, EXC0)

		And(i000, DeRefOf(arg1))
		CH06(arg0, 36, EXC0)

		And(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 37, EXC0)

		And(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 38, EXC0)

		// Concatenate

		Concatenate(DeRefOf(arg1), i000)
		CH06(arg0, 39, EXC0)

		Concatenate(i000, DeRefOf(arg1))
		CH06(arg0, 40, EXC0)

		Concatenate(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 41, EXC0)

		Concatenate(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 42, EXC0)

		// ConcatenateResTemplate

		ConcatenateResTemplate(DeRefOf(arg1), ResourceTemplate(){})
		CH06(arg0, 43, EXC0)

		ConcatenateResTemplate(ResourceTemplate(){}, DeRefOf(arg1))
		CH06(arg0, 44, EXC0)

		ConcatenateResTemplate(DeRefOf(arg1), ResourceTemplate(){}, Local1)
		CH06(arg0, 45, EXC0)

		ConcatenateResTemplate(ResourceTemplate(){}, DeRefOf(arg1), Local1)
		CH06(arg0, 46, EXC0)

		// Divide

		Divide(DeRefOf(arg1), i000)
		CH06(arg0, 47, EXC0)

		Divide(i000, DeRefOf(arg1))
		CH06(arg0, 48, EXC0)

		Divide(DeRefOf(arg1), i000, Local2)
		CH06(arg0, 49, EXC0)

		Divide(i000, DeRefOf(arg1), Local2)
		CH06(arg0, 50, EXC0)

		Divide(DeRefOf(arg1), i000, Local2, Local1)
		CH06(arg0, 51, EXC0)

		Divide(i000, DeRefOf(arg1), Local2, Local1)
		CH06(arg0, 52, EXC0)

		// Fatal

		Fatal(0xff, 0xffffffff, DeRefOf(arg1))
		CH06(arg0, 53, EXC0)

		// Index

		Index(DeRefOf(arg1), 0)
		CH06(arg0, 54, EXC0)

		Index("0", DeRefOf(arg1))
		CH06(arg0, 55, EXC0)

		Index(DeRefOf(arg1), 0, Local1)
		CH06(arg0, 56, EXC0)

		Index("0", DeRefOf(arg1), Local1)
		CH06(arg0, 57, EXC0)

		// LEqual

		LEqual(DeRefOf(arg1), i000)
		CH06(arg0, 58, EXC0)

		LEqual(i000, DeRefOf(arg1))
		CH06(arg0, 59, EXC0)

		// LGreater

		LGreater(DeRefOf(arg1), i000)
		CH06(arg0, 60, EXC0)

		LGreater(i000, DeRefOf(arg1))
		CH06(arg0, 61, EXC0)

		// LGreaterEqual

		LGreaterEqual(DeRefOf(arg1), i000)
		CH06(arg0, 62, 0xff)

		LGreaterEqual(i000, DeRefOf(arg1))
		CH06(arg0, 63, 0xff)

		// LLess

		LLess(DeRefOf(arg1), i000)
		CH06(arg0, 64, EXC0)

		LLess(i000, DeRefOf(arg1))
		CH06(arg0, 65, EXC0)

		// LLessEqual

		LLessEqual(DeRefOf(arg1), i000)
		CH06(arg0, 66, 0xff)

		LLessEqual(i000, DeRefOf(arg1))
		CH06(arg0, 67, 0xff)

		// LNotEqual

		LNotEqual(DeRefOf(arg1), i000)
		CH06(arg0, 68, 0xff)

		LNotEqual(i000, DeRefOf(arg1))
		CH06(arg0, 69, 0xff)

		// LOr

		LOr(DeRefOf(arg1), i000)
		CH06(arg0, 70, EXC0)

		LOr(i000, DeRefOf(arg1))
		CH06(arg0, 71, EXC0)

		// Mod

		Mod(DeRefOf(arg1), i000)
		CH06(arg0, 72, EXC0)

		Mod(i000, DeRefOf(arg1))
		CH06(arg0, 73, EXC0)

		Mod(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 74, EXC0)

		Mod(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 75, EXC0)

		// Multiply

		Multiply(DeRefOf(arg1), i000)
		CH06(arg0, 76, EXC0)

		Multiply(i000, DeRefOf(arg1))
		CH06(arg0, 77, EXC0)

		Multiply(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 78, EXC0)

		Multiply(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 79, EXC0)

		// NAnd

		NAnd(DeRefOf(arg1), i000)
		CH06(arg0, 80, EXC0)

		NAnd(i000, DeRefOf(arg1))
		CH06(arg0, 81, EXC0)

		NAnd(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 82, EXC0)

		NAnd(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 83, EXC0)

		// NOr

		NOr(DeRefOf(arg1), i000)
		CH06(arg0, 84, EXC0)

		NOr(i000, DeRefOf(arg1))
		CH06(arg0, 85, EXC0)

		NOr(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 86, EXC0)

		NOr(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 87, EXC0)

		// Or

		Or(DeRefOf(arg1), i000)
		CH06(arg0, 88, EXC0)

		Or(i000, DeRefOf(arg1))
		CH06(arg0, 89, EXC0)

		Or(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 90, EXC0)

		Or(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 91, EXC0)

		// ShiftLeft

		ShiftLeft(DeRefOf(arg1), i000)
		CH06(arg0, 92, EXC0)

		ShiftLeft(i000, DeRefOf(arg1))
		CH06(arg0, 93, EXC0)

		ShiftLeft(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 94, EXC0)

		ShiftLeft(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 95, EXC0)

		// ShiftRight

		ShiftRight(DeRefOf(arg1), i000)
		CH06(arg0, 96, EXC0)

		ShiftRight(i000, DeRefOf(arg1))
		CH06(arg0, 97, EXC0)

		ShiftRight(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 98, EXC0)

		ShiftRight(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 99, EXC0)

		// Subtract

		Subtract(DeRefOf(arg1), i000)
		CH06(arg0, 100, EXC0)

		Subtract(i000, DeRefOf(arg1))
		CH06(arg0, 101, EXC0)

		Subtract(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 102, EXC0)

		Subtract(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 103, EXC0)

		// ToString

		ToString(DeRefOf(arg1), 1)
		CH06(arg0, 104, EXC0)

		ToString(i000, DeRefOf(arg1))
		CH06(arg0, 105, EXC0)

		ToString(DeRefOf(arg1), 1, Local1)
		CH06(arg0, 106, EXC0)

		ToString(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 107, EXC0)

		// Wait

		Wait(e000, DeRefOf(arg1))
		CH06(arg0, 109, EXC0)

		// XOr

		XOr(DeRefOf(arg1), i000)
		CH06(arg0, 110, EXC0)

		XOr(i000, DeRefOf(arg1))
		CH06(arg0, 111, EXC0)

		XOr(DeRefOf(arg1), i000, Local1)
		CH06(arg0, 112, EXC0)

		XOr(i000, DeRefOf(arg1), Local1)
		CH06(arg0, 113, EXC0)

		// Mid

		Mid(DeRefOf(arg1), 1, 1)
		CH06(arg0, 114, EXC0)

		Mid("123", DeRefOf(arg1), 1)
		CH06(arg0, 115, EXC0)

		Mid("123", 1, DeRefOf(arg1))
		CH06(arg0, 116, EXC0)

		Mid(DeRefOf(arg1), 1, 1, Local1)
		CH06(arg0, 117, EXC0)

		Mid("123", DeRefOf(arg1), 1, Local1)
		CH06(arg0, 118, EXC0)

		Mid("123", 1, DeRefOf(arg1), Local1)
		CH06(arg0, 119, EXC0)

		// Match

		Match(DeRefOf(arg1), MTR, 0, MTR, 0, 0)
		CH06(arg0, 120, EXC0)

		Match(Package(){1}, MTR, DeRefOf(arg1), MTR, 0, 0)
		CH06(arg0, 121, EXC0)

		Match(Package(){1}, MTR, 0, MTR, DeRefOf(arg1), 0)
		CH06(arg0, 122, EXC0)

		Match(Package(){1}, MTR, 0, MTR, 0, DeRefOf(arg1))
		CH06(arg0, 123, EXC0)

		return (0)
	}

	// Result of Method invocation
	Method(m004, 1)
	{
		Name(i000, 0) // Label to check m000 invocations

		Method(m000)
		{
			CopyObject(tz00, Local0)
			Return (Local0)
		}

		// CondRefOf
		
		CondRefOf(m000())
		CH06(arg0, 0, 47)

		CondRefOf(m000(), Local1)
		CH06(arg0, 1, 47)

		// CopyObject

		CopyObject(m000(), Local1)
		CH03(ts, z105, 7, 0, 0)

		// Decrement

		Decrement(m000())
		CH06(arg0, 2, 47)

		// DerefOf

		DerefOf(m000())
		CH06(arg0, 3, 47)

		// FindSetLeftBit

		FindSetLeftBit(m000())
		CH06(arg0, 4, 47)

		FindSetLeftBit(m000(), Local1)
		CH06(arg0, 5, 47)

		// FindSetRightBit

		FindSetRightBit(m000())
		CH06(arg0, 6, 47)

		FindSetRightBit(m000(), Local1)
		CH06(arg0, 7, 47)

		// FromBCD

		FromBCD(m000())
		CH06(arg0, 8, 47)

		FromBCD(m000(), Local1)
		CH06(arg0, 9, 47)

		// Increment

		Increment(m000())
		CH06(arg0, 10, 47)

		// LNot

		LNot(m000())
		CH06(arg0, 11, 47)

		// Not

		Not(m000())
		CH06(arg0, 12, 47)

		Not(m000(), Local1)
		CH06(arg0, 13, 47)

		// ObjectType
        /* Nov. 2012: Method invocation as arg to ObjectType is now illegal */
//
//		ObjectType(m000())
//		CH03(ts, z105, 8, 0, 0)

		// RefOf

		RefOf(m000())
		CH06(arg0, 14, 47)

		// Release

		Release(m000())
		CH06(arg0, 13, 47)

		// Reset

		Reset(m000())
		CH06(arg0, 14, 47)

		// Signal

		Signal(m000())
		CH06(arg0, 15, 47)

		// SizeOf

		SizeOf(m000())
		CH06(arg0, 16, 47)

		// Sleep

		Sleep(m000())
		CH06(arg0, 17, 47)

		// Stall

		Stall(m000())
		CH06(arg0, 18, 47)

		// Store

		Store(m000(), Local1)
		CH06(arg0, 19, 47)

		// ToBCD

		ToBCD(m000())
		CH06(arg0, 20, 47)

		ToBCD(m000(), Local1)
		CH06(arg0, 21, 47)

		// ToBuffer

		ToBuffer(m000())
		CH06(arg0, 22, 47)

		ToBuffer(m000(), Local1)
		CH06(arg0, 23, 47)

		// ToDecimalString

		ToDecimalString(m000())
		CH06(arg0, 24, 47)

		ToDecimalString(m000(), Local1)
		CH06(arg0, 25, 47)

		// ToHexString

		ToHexString(m000())
		CH06(arg0, 26, 47)

		ToHexString(m000(), Local1)
		CH06(arg0, 27, 47)

		// ToInteger

		ToInteger(m000())
		CH06(arg0, 28, 47)

		ToInteger(m000(), Local1)
		CH06(arg0, 29, 47)

		// Acquire

		Acquire(m000(), 100)
		CH06(arg0, 30, 47)

		// Add

		Add(m000(), i000)
		CH06(arg0, 31, 47)

		Add(i000, m000())
		CH06(arg0, 32, 47)

		Add(m000(), i000, Local1)
		CH06(arg0, 33, 47)

		Add(i000, m000(), Local1)
		CH06(arg0, 34, 47)

		// And

		And(m000(), i000)
		CH06(arg0, 35, 47)

		And(i000, m000())
		CH06(arg0, 36, 47)

		And(m000(), i000, Local1)
		CH06(arg0, 37, 47)

		And(i000, m000(), Local1)
		CH06(arg0, 38, 47)

		// Concatenate

		Concatenate(m000(), i000)
		CH06(arg0, 39, 47)

		Concatenate(i000, m000())
		CH06(arg0, 40, 47)

		Concatenate(m000(), i000, Local1)
		CH06(arg0, 41, 47)

		Concatenate(i000, m000(), Local1)
		CH06(arg0, 42, 47)

		// ConcatenateResTemplate

		ConcatenateResTemplate(m000(), ResourceTemplate(){})
		CH06(arg0, 43, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, m000())
		CH06(arg0, 44, 47)

		ConcatenateResTemplate(m000(), ResourceTemplate(){}, Local1)
		CH06(arg0, 45, 47)

		ConcatenateResTemplate(ResourceTemplate(){}, m000(), Local1)
		CH06(arg0, 46, 47)

		// Divide

		Divide(m000(), i000)
		CH06(arg0, 47, 47)

		Divide(i000, m000())
		CH06(arg0, 48, 47)

		Divide(m000(), i000, Local2)
		CH06(arg0, 49, 47)

		Divide(i000, m000(), Local2)
		CH06(arg0, 50, 47)

		Divide(m000(), i000, Local2, Local1)
		CH06(arg0, 51, 47)

		Divide(i000, m000(), Local2, Local1)
		CH06(arg0, 52, 47)

		// Fatal

		Fatal(0xff, 0xffffffff, m000())
		CH06(arg0, 53, 47)

		// Index

		Index(m000(), 0)
		CH06(arg0, 54, 47)

		Index("0", m000())
		CH06(arg0, 55, 47)

		Index(m000(), 0, Local1)
		CH06(arg0, 56, 47)

		Index("0", m000(), Local1)
		CH06(arg0, 57, 47)

		// LEqual

		LEqual(m000(), i000)
		CH06(arg0, 58, 47)

		LEqual(i000, m000())
		CH06(arg0, 59, 47)

		// LGreater

		LGreater(m000(), i000)
		CH06(arg0, 60, 47)

		LGreater(i000, m000())
		CH06(arg0, 61, 47)

		// LGreaterEqual

		LGreaterEqual(m000(), i000)
		CH06(arg0, 62, 0xff)

		LGreaterEqual(i000, m000())
		CH06(arg0, 63, 0xff)

		// LLess

		LLess(m000(), i000)
		CH06(arg0, 64, 47)

		LLess(i000, m000())
		CH06(arg0, 65, 47)

		// LLessEqual

		LLessEqual(m000(), i000)
		CH06(arg0, 66, 0xff)

		LLessEqual(i000, m000())
		CH06(arg0, 67, 0xff)

		// LNotEqual

		LNotEqual(m000(), i000)
		CH06(arg0, 68, 0xff)

		LNotEqual(i000, m000())
		CH06(arg0, 69, 0xff)

		// LOr

		LOr(m000(), i000)
		CH06(arg0, 70, 47)

		LOr(i000, m000())
		CH06(arg0, 71, 47)

		// Mod

		Mod(m000(), i000)
		CH06(arg0, 72, 47)

		Mod(i000, m000())
		CH06(arg0, 73, 47)

		Mod(m000(), i000, Local1)
		CH06(arg0, 74, 47)

		Mod(i000, m000(), Local1)
		CH06(arg0, 75, 47)

		// Multiply

		Multiply(m000(), i000)
		CH06(arg0, 76, 47)

		Multiply(i000, m000())
		CH06(arg0, 77, 47)

		Multiply(m000(), i000, Local1)
		CH06(arg0, 78, 47)

		Multiply(i000, m000(), Local1)
		CH06(arg0, 79, 47)

		// NAnd

		NAnd(m000(), i000)
		CH06(arg0, 80, 47)

		NAnd(i000, m000())
		CH06(arg0, 81, 47)

		NAnd(m000(), i000, Local1)
		CH06(arg0, 82, 47)

		NAnd(i000, m000(), Local1)
		CH06(arg0, 83, 47)

		// NOr

		NOr(m000(), i000)
		CH06(arg0, 84, 47)

		NOr(i000, m000())
		CH06(arg0, 85, 47)

		NOr(m000(), i000, Local1)
		CH06(arg0, 86, 47)

		NOr(i000, m000(), Local1)
		CH06(arg0, 87, 47)

		// Or

		Or(m000(), i000)
		CH06(arg0, 88, 47)

		Or(i000, m000())
		CH06(arg0, 89, 47)

		Or(m000(), i000, Local1)
		CH06(arg0, 90, 47)

		Or(i000, m000(), Local1)
		CH06(arg0, 91, 47)

		// ShiftLeft

		ShiftLeft(m000(), i000)
		CH06(arg0, 92, 47)

		ShiftLeft(i000, m000())
		CH06(arg0, 93, 47)

		ShiftLeft(m000(), i000, Local1)
		CH06(arg0, 94, 47)

		ShiftLeft(i000, m000(), Local1)
		CH06(arg0, 95, 47)

		// ShiftRight

		ShiftRight(m000(), i000)
		CH06(arg0, 96, 47)

		ShiftRight(i000, m000())
		CH06(arg0, 97, 47)

		ShiftRight(m000(), i000, Local1)
		CH06(arg0, 98, 47)

		ShiftRight(i000, m000(), Local1)
		CH06(arg0, 99, 47)

		// Subtract

		Subtract(m000(), i000)
		CH06(arg0, 100, 47)

		Subtract(i000, m000())
		CH06(arg0, 101, 47)

		Subtract(m000(), i000, Local1)
		CH06(arg0, 102, 47)

		Subtract(i000, m000(), Local1)
		CH06(arg0, 103, 47)

		// ToString

		ToString(m000(), 1)
		CH06(arg0, 104, 47)

		ToString(i000, m000())
		CH06(arg0, 105, 47)

		ToString(m000(), 1, Local1)
		CH06(arg0, 106, 47)

		ToString(i000, m000(), Local1)
		CH06(arg0, 107, 47)

		// Wait

		Wait(m000(), i000)
		CH06(arg0, 108, 47)

		Wait(e000, m000())
		CH06(arg0, 109, 47)

		// XOr

		XOr(m000(), i000)
		CH06(arg0, 110, 47)

		XOr(i000, m000())
		CH06(arg0, 111, 47)

		XOr(m000(), i000, Local1)
		CH06(arg0, 112, 47)

		XOr(i000, m000(), Local1)
		CH06(arg0, 113, 47)

		// Mid

		Mid(m000(), 1, 1)
		CH06(arg0, 114, 47)

		Mid("123", m000(), 1)
		CH06(arg0, 115, 47)

		Mid("123", 1, m000())
		CH06(arg0, 116, 47)

		Mid(m000(), 1, 1, Local1)
		CH06(arg0, 117, 47)

		Mid("123", m000(), 1, Local1)
		CH06(arg0, 118, 47)

		Mid("123", 1, m000(), Local1)
		CH06(arg0, 119, 47)

		// Match

		Match(m000(), MTR, 0, MTR, 0, 0)
		CH06(arg0, 120, 47)

		Match(Package(){1}, MTR, m000(), MTR, 0, 0)
		CH06(arg0, 121, 47)

		Match(Package(){1}, MTR, 0, MTR, m000(), 0)
		CH06(arg0, 122, 47)

		Match(Package(){1}, MTR, 0, MTR, 0, m000())
		CH06(arg0, 123, 47)
	}

	// Reference to Object as Result of Method invocation
	Method(m005, 1)
	{
		ThermalZone (tz02) {Name(n000, "tz02")}

		Name(i000, 0) // Label to check m000 invocations

		Method(m000, 2)
		{
			Store(arg0, i000)
			if (LEqual(arg1, 0)) {
				Store(Refof(tz00), Local0)
			} elseif (LEqual(arg1, 1)) {
				Store(Refof(tz02), Local0)
			}
			Return (Local0)
		}

		Method(CH00, 2)
		{
			if (LNotEqual(i000, arg1)) {
				err(arg0, z105, 0, 0, 0, i000, arg1)
			}
		}

		Name(lpN0, 2)
		Name(lpC0, 0)

		While (lpN0) {
			Multiply(3, lpC0, Local0)

			Store(0, i000)

			DerefOf(m000(1, lpC0))
			CH03(ts, z105, Add(9, lpC0), 0, 0)
			CH00(arg0, 1)

			DerefOf(DerefOf(m000(2, lpC0)))
			CH06(arg0, Add(1, Local0), 47)
			CH00(arg0, 2)

			Index(DerefOf(m000(3, lpC0)), 0)
			CH06(arg0, Add(2, Local0), 47)
			CH00(arg0, 3)

			Match(DerefOf(m000(4, lpC0)), MTR, 0, MTR, 0, 0)
			CH06(arg0, Add(3, Local0), 47)
			CH00(arg0, 4)

			Decrement(lpN0)
			Increment(lpC0)
		}
	}

	CH03(ts, z105, 11, 0, 0)

	// Local Named Object
	m000(ts)

	// Global Named Object
	m001(ts)

	// Local
	if (y504) {
		m002(Concatenate(ts, "-m002"))
	}

	// Reference to Local Named Object

	m003(Concatenate(ts, "-m003-RefLocName"), RefOf(tz01), 1)

	Store(RefOf(tz01), Local0)
	m003(Concatenate(ts, "-m003-RefLocName2"), Local0, 1)

	CondRefOf(tz01, Local0)
	m003(Concatenate(ts, "-m003-CondRefLocName"), Local0, 1)

	m003(Concatenate(ts, "-m003-RefGlobName"), RefOf(tz00), 1)

	Store(RefOf(tz00), Local0)
	m003(Concatenate(ts, "-m003-RefGlobName2"), Local0, 1)

	CondRefOf(tz00, Local0)
	m003(Concatenate(ts, "-m003-CondRefGlobName"), Local0, 1)

	// Reference to Object as element of Package

	Name(pp00, Package(){tz00})

	if (y113) {
		m003(Concatenate(ts, "-m003-Index"), Index(pp00, 0), 0)
	}

	Store(Index(pp00, 0), Local1)
	m003(Concatenate(ts, "-m003-Index2"), Local1, 0)

	if (y113) {
		m003(Concatenate(ts, "-m003-Index3"), Index(pp00, 0, Local2), 0)
	}

	Index(pp00, 0, Local3)
	m003(Concatenate(ts, "-m003-Index4"), Local3, 0)

	Store(Index(pp00, 0, Local4), Local5)
	m003(Concatenate(ts, "-m003-Index5"), Local5, 0)

	// Result of Method invocation
	if (y504) {
		m004(Concatenate(ts, "-m004"))
	}

	// Reference to Object as Result of Method invocation
	m005(Concatenate(ts, "-m005"))
}
