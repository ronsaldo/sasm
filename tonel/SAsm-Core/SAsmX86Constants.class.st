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
]

{ #category : #'class initialization' }
SAsmX86Constants class >> initializeRegisters [
	X86ByteRegisters := self
		declareRegisters: #(AL CL DL BL AH CH DH BH)
		withClass: SAsmX86RegisterInt8.

	X86RexByteRegisters := self
		declareRegisters: #(RAXB RCXB RDXB RBXB RSPB RBPB RSIB RDIB R8B R9B R10B R11B R12B R13B R14B R15B)
		withClass: SAsmX86RegisterInt8.

	X86MappedRegisters := { AL . CL . DL . BL . nil . nil . nil . nil }.
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
