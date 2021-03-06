Class {
	#name : #SAsmX86Constants,
	#superclass : #SharedPool,
	#classVars : [
		'AH',
		'AL',
		'AX',
		'BH',
		'BL',
		'BP',
		'BX',
		'CH',
		'CL',
		'CX',
		'DH',
		'DI',
		'DL',
		'DX',
		'EAX',
		'EBP',
		'EBX',
		'ECX',
		'EDI',
		'EDX',
		'ESI',
		'ESP',
		'MM0',
		'MM1',
		'MM2',
		'MM3',
		'MM4',
		'MM5',
		'MM6',
		'MM7',
		'NopFillPattern16',
		'NopFillPattern32',
		'NopFillPattern32_AMD',
		'NopFillPattern32_Intel',
		'R10',
		'R10B',
		'R10D',
		'R10W',
		'R11',
		'R11B',
		'R11D',
		'R11W',
		'R12',
		'R12B',
		'R12D',
		'R12W',
		'R13',
		'R13B',
		'R13D',
		'R13W',
		'R14',
		'R14B',
		'R14D',
		'R14W',
		'R15',
		'R15B',
		'R15D',
		'R15W',
		'R8',
		'R8B',
		'R8D',
		'R8W',
		'R9',
		'R9B',
		'R9D',
		'R9W',
		'RAX',
		'RAXB',
		'RBP',
		'RBPB',
		'RBX',
		'RBXB',
		'RCX',
		'RCXB',
		'RDI',
		'RDIB',
		'RDX',
		'RDXB',
		'RSI',
		'RSIB',
		'RSP',
		'RSPB',
		'R_386_32',
		'R_386_COPY',
		'R_386_GLOB_DAT',
		'R_386_GOT32',
		'R_386_GOTOFF',
		'R_386_GOTPC',
		'R_386_JMP_SLOT',
		'R_386_NONE',
		'R_386_PC32',
		'R_386_PLT32',
		'R_386_RELATIVE',
		'R_X86_64_16',
		'R_X86_64_32',
		'R_X86_64_32S',
		'R_X86_64_64',
		'R_X86_64_8',
		'R_X86_64_COPY',
		'R_X86_64_DTPMOD64',
		'R_X86_64_DTPOFF32',
		'R_X86_64_DTPOFF64',
		'R_X86_64_GLOB_DAT',
		'R_X86_64_GOT32',
		'R_X86_64_GOTOFF64',
		'R_X86_64_GOTPC32',
		'R_X86_64_GOTPC32_TLSDESC',
		'R_X86_64_GOTPCREL',
		'R_X86_64_GOTTPOFF',
		'R_X86_64_IRELATIVE',
		'R_X86_64_JUMP_SLOT',
		'R_X86_64_NONE',
		'R_X86_64_PC16',
		'R_X86_64_PC32',
		'R_X86_64_PC64',
		'R_X86_64_PC8',
		'R_X86_64_PLT32',
		'R_X86_64_RELATIVE',
		'R_X86_64_SIZE32',
		'R_X86_64_SIZE64',
		'R_X86_64_TLSDESC',
		'R_X86_64_TLSDESC_CALL',
		'R_X86_64_TLSGD',
		'R_X86_64_TLSLD',
		'R_X86_64_TPOFF32',
		'R_X86_64_TPOFF64',
		'SI',
		'SP',
		'X86ByteRegisters',
		'X86DWordRegisters',
		'X86MappedRegisters',
		'X86QWordRegisters',
		'X86RexByteRegisters',
		'X86WordRegisters',
		'XMM0',
		'XMM1',
		'XMM10',
		'XMM11',
		'XMM12',
		'XMM13',
		'XMM14',
		'XMM15',
		'XMM2',
		'XMM3',
		'XMM4',
		'XMM5',
		'XMM6',
		'XMM7',
		'XMM8',
		'XMM9'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'class initialization' }
SAsmX86Constants class >> declareRegisters: registerNames withClass: registerClass [
	| register |
	^ registerNames collectWithIndex: [ :mnemonic :index |
		(self hasClassVarNamed: mnemonic) ifFalse: [ 
			self addClassVarNamed: mnemonic.
		].
	
		register := registerClass new name: mnemonic; value: index - 1.
		self classVarNamed: mnemonic put: register.
		register
	].
]

{ #category : #'class initialization' }
SAsmX86Constants class >> initialize [
	super initialize.
	self initializeRegisters.
	self initializeNopPatterns.
	self initializeElfRelocations.
]

{ #category : #initialization }
SAsmX86Constants class >> initializeElf32Relocations [
	"A - addend"
	"B - base"
	"G - offset into the GOT"
	"GOT - GOT address"
	"L - linkage table offset"
	"P - place of relocation"
	"S - symbol value"
	R_386_NONE := 0. 	"None"
	R_386_32 := 1. 		"S + A"
	R_386_PC32 := 2.	"S + A - P"
	R_386_GOT32 := 3. 	"G + A - P"
	R_386_PLT32 := 4. 	"L + A - P"
	R_386_COPY := 5.	"None"
	R_386_GLOB_DAT := 6. 	"S"
	R_386_JMP_SLOT := 7. 	"S"
	R_386_RELATIVE := 8.	"B + A"
	R_386_GOTOFF := 9.	"S + A - GOT"
	R_386_GOTPC := 10. "GOT + A - P"
	
]

{ #category : #initialization }
SAsmX86Constants class >> initializeElf64Relocations [

	R_X86_64_NONE := 0.
	R_X86_64_64 := 1.
	R_X86_64_PC32 := 2.
	R_X86_64_GOT32 := 3.
	R_X86_64_PLT32 := 4.
	R_X86_64_COPY := 5.
	R_X86_64_GLOB_DAT := 6.
	R_X86_64_JUMP_SLOT := 7.
	R_X86_64_RELATIVE := 8.
	R_X86_64_GOTPCREL := 9.
	R_X86_64_32 := 10.
	R_X86_64_32S := 11.
	R_X86_64_16 := 12.
	R_X86_64_PC16 := 13.
	R_X86_64_8 := 14.
	R_X86_64_PC8 := 15.
	R_X86_64_DTPMOD64 := 16.
	R_X86_64_DTPOFF64 := 17.
	R_X86_64_TPOFF64 := 18.
	R_X86_64_TLSGD := 19.
	R_X86_64_TLSLD := 20.
	R_X86_64_DTPOFF32 := 21.
	R_X86_64_GOTTPOFF := 22.
	R_X86_64_TPOFF32 := 23.
	R_X86_64_PC64 := 24.
	R_X86_64_GOTOFF64 := 25.
	R_X86_64_GOTPC32 := 26.
	R_X86_64_SIZE32 := 32.
	R_X86_64_SIZE64 := 33.
	R_X86_64_GOTPC32_TLSDESC := 34.
	R_X86_64_TLSDESC_CALL := 35.
	R_X86_64_TLSDESC := 36.
	R_X86_64_IRELATIVE := 37.
]

{ #category : #initialization }
SAsmX86Constants class >> initializeElfRelocations [
	self
		initializeElf32Relocations;
		initializeElf64Relocations
]

{ #category : #'class initialization' }
SAsmX86Constants class >> initializeNopPatterns [
	"These filling patterns are taken from the YASM source code"
	NopFillPattern16 := #(
		"Fill patterns that GAS uses."
		(16r90)                                 "1 - nop"
		(16r89 16rf6)                           " 2 - mov si si "
    	(16r8d 16r74 16r00)                     " 3 - lea si [si+byte 0] "
		(16r8d 16rb4 16r00 16r00)               " 4 - lea si [si+word 0] "
    	(16r90                                  " 5 - nop "
       16r8d 16rb4 16r00 16r00)               "     lea si [si+word 0] "
    	(16r89 16rf6                            " 6 - mov si si "
         16r8d 16rbd 16r00 16r00)               "     lea di [di+word 0] "
    	(16r8d 16r74 16r00                      " 7 - lea si [si+byte 0] "
         16r8d 16rbd 16r00 16r00)               "     lea di [di+word 0] "
    	(16r8d 16rb4 16r00 16r00                " 8 - lea si [si+word 0] "
         16r8d 16rbd 16r00 16r00)               "     lea di [di+word 0] "
    	(16reb 16r07 16r90 16r90 16r90 16r90    " 9 - jmp $+9 nop fill "
         16r90 16r90 16r90)
		(16reb 16r08 16r90 16r90 16r90 16r90    " 10 - jmp $+10 nop fill "
         16r90 16r90 16r90 16r90)
		(16reb 16r09 16r90 16r90 16r90 16r90    " 11 - jmp $+11 nop fill "
         16r90 16r90 16r90 16r90 16r90)
		(16reb 16r0a 16r90 16r90 16r90 16r90    " 12 - jmp $+12 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90)
		(16reb 16r0b 16r90 16r90 16r90 16r90    " 13 - jmp $+13 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90 16r90)
		(16reb 16r0c 16r90 16r90 16r90 16r90    " 14 - jmp $+14 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90 16r90 16r90)
		(16reb 16r0d 16r90 16r90 16r90 16r90    " 15 - jmp $+15 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90 16r90 16r90 16r90)
	).
	
	NopFillPattern32 := #(
        (16r90)                              " 1 - nop "
        (16r66 16r90)                        " 2 - xchg ax ax (o16 nop) "
        (16r8d 16r76 16r00)                  " 3 - lea esi [esi+byte 0] "
        (16r8d 16r74 16r26 16r00)            " 4 - lea esi [esi*1+byte 0] "
        (16r90                               " 5 - nop "
         16r8d 16r74 16r26 16r00)            "     lea esi [esi*1+byte 0] "
        (16r8d 16rb6 16r00 16r00 16r00 16r00)" 6 - lea esi [esi+dword 0] "
        (16r8d 16rb4 16r26 16r00 16r00 16r00 " 7 - lea esi [esi*1+dword 0] "
         16r00)
        (16r90                               " 8 - nop "
         16r8d 16rb4 16r26 16r00 16r00 16r00 "     lea esi [esi*1+dword 0] "
         16r00)
        (16reb 16r07 16r90 16r90 16r90 16r90 " 9 - jmp $+9 nop fill "
         16r90 16r90 16r90)
        (16reb 16r08 16r90 16r90 16r90 16r90 " 10 - jmp $+10 nop fill "
         16r90 16r90 16r90 16r90)
        (16reb 16r09 16r90 16r90 16r90 16r90 " 11 - jmp $+11 nop fill "
         16r90 16r90 16r90 16r90 16r90)
        (16reb 16r0a 16r90 16r90 16r90 16r90 " 12 - jmp $+12 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90)
        (16reb 16r0b 16r90 16r90 16r90 16r90 " 13 - jmp $+13 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90 16r90)
        (16reb 16r0c 16r90 16r90 16r90 16r90 " 14 - jmp $+14 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90 16r90 16r90)
        (16reb 16r0d 16r90 16r90 16r90 16r90 " 15 - jmp $+15 nop fill "
         16r90 16r90 16r90 16r90 16r90 16r90 16r90 16r90 16r90)
	).
	
	NopFillPattern32_Intel := #(
        (16r90)                              " 1 - nop "
        (16r66 16r90)                        " 2 - xchg ax ax (o16 nop) "
        (16r0f 16r1f 16r00)                         " 3 - nop(3) "
        (16r0f 16r1f 16r40 16r00)                   " 4 - nop(4) "
        (16r0f 16r1f 16r44 16r00 16r00)             " 5 - nop(5) "
        (16r66 16r0f 16r1f 16r44 16r00 16r00)       " 6 - nop(6) "
        (16r0f 16r1f 16r80 16r00 16r00 16r00 16r00) " 7 - nop(7) "
        (16r0f 16r1f 16r84 16r00 16r00 16r00 16r00  " 8 - nop(8) "
         16r00)
        (16r66 16r0f 16r1f 16r84 16r00 16r00 16r00  " 9 - nop(9) "
         16r00 16r00)
        (16r66 16r2e 16r0f 16r1f 16r84 16r00 16r00  " 10 - o16 cs nop "
         16r00 16r00 16r00)
        (16r66 16r66 16r2e 16r0f 16r1f 16r84 16r00  " 11 - 2x o16 cs nop "
         16r00 16r00 16r00 16r00)
        (16r66 16r66 16r66 16r2e 16r0f 16r1f 16r84  " 12 - 3x o16 cs nop "
         16r00 16r00 16r00 16r00 16r00)
        (16r66 16r66 16r66 16r66 16r2e 16r0f 16r1f  " 13 - 4x o16 cs nop "
         16r84 16r00 16r00 16r00 16r00 16r00)
        (16r66 16r66 16r66 16r66 16r66 16r2e 16r0f  " 14 - 5x o16 cs nop "
         16r1f 16r84 16r00 16r00 16r00 16r00 16r00)
        (16r66 16r66 16r66 16r66 16r66 16r66 16r2e  " 15 - 6x o16 cs nop "
         16r0f 16r1f 16r84 16r00 16r00 16r00 16r00 16r00)
	).
	
	NopFillPattern32_AMD := #(
        (16r90)                              " 1 - nop "
        (16r66 16r90)                        " 2 - xchg ax ax (o16 nop) "
        (16r0f 16r1f 16r00)                         " 3 - nop(3) "
        (16r0f 16r1f 16r40 16r00)                   " 4 - nop(4) "
        (16r0f 16r1f 16r44 16r00 16r00)             " 5 - nop(5) "
        (16r66 16r0f 16r1f 16r44 16r00 16r00)       " 6 - nop(6) "
        (16r0f 16r1f 16r80 16r00 16r00 16r00 16r00) " 7 - nop(7) "
        (16r0f 16r1f 16r84 16r00 16r00 16r00 16r00  " 8 - nop(8) "
         16r00)
        (16r66 16r0f 16r1f 16r84 16r00 16r00 16r00  " 9 - nop(9) "
         16r00 16r00)
        (16r66 16r66 16r0f 16r1f 16r84 16r00 16r00  " 10 - nop(10) "
         16r00 16r00 16r00)
        (16r0f 16r1f 16r44 16r00 16r00              " 11 - nop(5) "
         16r66 16r0f 16r1f 16r44 16r00 16r00)       "      nop(6) "
        (16r66 16r0f 16r1f 16r44 16r00 16r00        " 12 - nop(6) "
         16r66 16r0f 16r1f 16r44 16r00 16r00)       "      nop(6) "
        (16r66 16r0f 16r1f 16r44 16r00 16r00        " 13 - nop(6) "
         16r0f 16r1f 16r80 16r00 16r00 16r00 16r00) "      nop(7) "
        (16r0f 16r1f 16r80 16r00 16r00 16r00 16r00  " 14 - nop(7) "
         16r0f 16r1f 16r80 16r00 16r00 16r00 16r00) "      nop(7) "
        (16r0f 16r1f 16r80 16r00 16r00 16r00 16r00        " 15 - nop(7) "
         16r0f 16r1f 16r84 16r00 16r00 16r00 16r00 16r00) "      nop(8) "
	)
]

{ #category : #'class initialization' }
SAsmX86Constants class >> initializeRegisters [
	X86ByteRegisters := self
		declareRegisters: #(AL CL DL BL AH CH DH BH)
		withClass: SAsmX86RegisterInt8.

	X86RexByteRegisters := self
		declareRegisters: #(RAXB RCXB RDXB RBXB RSPB RBPB RSIB RDIB R8B R9B R10B R11B R12B R13B R14B R15B)
		withClass: SAsmX86RegisterInt8.

	X86MappedRegisters := { AL . CL . DL . BL . nil . nil . nil . nil .
		 nil . nil . nil . nil .  nil . nil . nil . nil  }.
	X86WordRegisters :=self
		declareRegisters: #(AX CX DX BX SP BP SI DI R8W R9W R10W R11W R12W R13W R14W R15W)
		withClass: SAsmX86RegisterInt16.
	X86DWordRegisters := self
		declareRegisters: #(EAX ECX EDX EBX ESP EBP ESI EDI R8D R9D R10D R11D R12D R13D R14D R15D)
		withClass: SAsmX86RegisterInt32.
	X86QWordRegisters := self
		declareRegisters: #(RAX RCX RDX RBX RSP RBP RSI RDI R8 R9 R10 R11 R12 R13 R14 R15)
		withClass: SAsmX86RegisterInt64.
	
	self
		declareRegisters: #(MM0 MM1 MM2 MM3 MM4 MM5 MM6 MM7)
		withClass: SAsmX86RegisterVectorMMX.

	self
		declareRegisters: #(XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7
			XMM8 XMM9 XMM10 XMM11 XMM12 XMM13 XMM14 XMM15)
		withClass: SAsmX86RegisterVector.
]
