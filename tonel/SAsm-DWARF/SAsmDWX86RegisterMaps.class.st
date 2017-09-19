Class {
	#name : #SAsmDWX86RegisterMaps,
	#superclass : #Object,
	#classVars : [
		'I386RegisterMap',
		'X86_64RegisterMap'
	],
	#pools : [
		'SAsmDWConstants',
		'SAsmX86Constants'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #initialization }
SAsmDWX86RegisterMaps class >> I386RegisterMap [
	^ I386RegisterMap
]

{ #category : #initialization }
SAsmDWX86RegisterMaps class >> X86_64RegisterMap [
	^ X86_64RegisterMap
]

{ #category : #initialization }
SAsmDWX86RegisterMaps class >> initialize [
	self
		initializeI386RegisterMap;
		initializeX86_64RegisterMap
]

{ #category : #initialization }
SAsmDWX86RegisterMaps class >> initializeI386RegisterMap [
	^ I386RegisterMap := Dictionary newFromPairs: {
		EAX . 0.
		ECX . 1.
		EDX . 2.
		EBX . 3.
		ESP . 4.
		EBP . 5.
		ESI . 6.
		EDI . 7.
		
		XMM0 . 21.
		XMM1 . 22.
		XMM2 . 23.
		XMM3 . 24.
		XMM4 . 25.
		XMM5 . 26.
		XMM6 . 27.
		XMM7 . 28.
		
		MM0 . 29.
		MM1 . 30.
		MM2 . 31.
		MM3 . 32.
		MM4 . 33.
		MM5 . 34.
		MM6 . 35.
		MM7 . 36.
	}
]

{ #category : #initialization }
SAsmDWX86RegisterMaps class >> initializeX86_64RegisterMap [
	^ X86_64RegisterMap := Dictionary newFromPairs: {
		RAX . 0.
		RDX . 1.
		RCX . 2.
		RBX . 3.
		RSI . 4.
		RDI . 5.
		RBP . 6.
		RSP . 7.
		R8 . 8.
		R9 . 9.
		R10 . 10.
		R11 . 11.
		R12 . 12.
		R13 . 13.
		R14 . 14.
		R15 . 15.
		
		XMM0 . 17.
		XMM1 . 18.
		XMM2 . 19.
		XMM3 . 20.
		XMM4 . 21.
		XMM5 . 22.
		XMM6 . 23.
		XMM7 . 24.
		XMM8 . 25.
		XMM9 . 26.
		XMM10 . 27.
		XMM11 . 28.
		XMM12 . 29.
		XMM13 . 30.
		XMM14 . 31.
		XMM15 . 32.
	}
]
