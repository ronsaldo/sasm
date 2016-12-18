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
		'R11',
		'R12',
		'R13',
		'R14',
		'R15',
		'R8',
		'R9',
		'RAX',
		'RBP',
		'RBX',
		'RCX',
		'RDI',
		'RDX',
		'RSI',
		'RSP',
		'SI',
		'SP',
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
	registerNames doWithIndex: [ :mnemonic :index |
		(self hasClassVarNamed: mnemonic) ifFalse: [ 
			self addClassVarNamed: mnemonic.
		].
		self classVarNamed: mnemonic put: (registerClass new name: mnemonic; value: index - 1)
	].
]

{ #category : #'class initialization' }
SAsmX86Constants class >> initialize [
	super initialize.
	self initializeRegisters.
]

{ #category : #'class initialization' }
SAsmX86Constants class >> initializeRegisters [
	self
		declareRegisters: #(AL CL DL BL AH CH DH BH)
		withClass: SAsmX86RegisterInt8.
	self
		declareRegisters: #(AX CX DX BX SP BP SI DI)
		withClass: SAsmX86RegisterInt16.

	self
		declareRegisters: #(EAX ECX EDX EBX ESP EBP ESI EDI)
		withClass: SAsmX86RegisterInt32.

	self
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
