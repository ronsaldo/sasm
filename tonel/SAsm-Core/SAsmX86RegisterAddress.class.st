Class {
	#name : #SAsmX86RegisterAddress,
	#superclass : #SAsmInstructionOperand,
	#instVars : [
		'size',
		'base',
		'index',
		'scale',
		'displacement'
	],
	#classVars : [
		'ScaleValueMap'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #arithmetic }
SAsmX86RegisterAddress >> + displacementOrIndex [
	| result |
	result := self copy.
	displacementOrIndex isInteger ifTrue: [ ^ self copy displacement: displacementOrIndex ].
	self halt.
]

{ #category : #arithmetic }
SAsmX86RegisterAddress >> - displacementOrIndex [
	| result |
	result := self copy.
	displacementOrIndex isInteger ifTrue: [ ^ self copy displacement: displacementOrIndex negated ].
	self halt.
]

{ #category : #accessing }
SAsmX86RegisterAddress >> base [
	^ base
]

{ #category : #accessing }
SAsmX86RegisterAddress >> base: anObject [
	base := anObject
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterAddress >> byte [
	^ self copy size: 1
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterAddress >> copyWithStreamBuilder: streamBuilder [
	^ self copy
		displacement: (streamBuilder findSymbolForObject: displacement ifAbsent: [ displacement ])
]

{ #category : #accessing }
SAsmX86RegisterAddress >> displacement [
	^ displacement
]

{ #category : #accessing }
SAsmX86RegisterAddress >> displacement: anObject [
	displacement := anObject
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterAddress >> dword [
	^ self copy size: 4
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterAddress >> encodeModRMWithOpcode: opcode immediate: immediateSize longMode: longMode into: writer [
	| mod baseValue hasDisplacement hasSmallDisplacement sibByte indexValue scaleValue |
	sibByte := nil.
	self needsSibByte ifTrue: [
		baseValue := base ifNil: [ 5 ] ifNotNil: [ base valueLow ].
		indexValue := index ifNil: [ 4 ] ifNotNil: [ index valueLow ].
		scaleValue := ScaleValueMap at: scale.
		sibByte := (scaleValue << 6) | (indexValue << 3) | baseValue.
	].

	hasDisplacement := false.
	(sibByte isNotNil and: [ base valueLow == EBP valueLow ]) ifTrue: [
		hasDisplacement := true.
		hasSmallDisplacement := self hasSmallDisplacement.
		mod := hasSmallDisplacement ifTrue: [ 1 ] ifFalse: [ 2 ].
	] ifFalse: [
		(displacement = 0 and: [ base valueLow ~~ EBP valueLow ]) ifTrue: [
			mod := 0
		] ifFalse: [
			hasDisplacement := true.
			hasSmallDisplacement := self hasSmallDisplacement.
			mod := hasSmallDisplacement ifTrue: [ 1 ] ifFalse: [ 2 ].
			(base isNil and: [hasSmallDisplacement not and: [ sibByte isNil ]]) ifTrue: [ mod := 0 ]
		].
	].

	sibByte ifNotNil: [ 
		baseValue := 4
 	] ifNil: [ 
		base ifNotNil: [
			baseValue := base valueLow.
		] ifNil: [
			hasSmallDisplacement := false.
			self assert: displacement isNotNil.
			baseValue := 5
		].
	].
	
	writer nextPutC8: (mod << 6) | (opcode << 3) | baseValue.
	sibByte ifNotNil: [ writer nextPutC8: sibByte ].
	
	hasDisplacement ifTrue: [
		hasSmallDisplacement ifTrue: [
			writer nextPutC8: displacement
		] ifFalse: [
			(mod = 0 and: longMode) ifTrue: [ 
				writer nextPutIPRelativeI32: displacement extraOffset: immediateSize + 4
			] ifFalse: [ 
				writer nextPutI32: displacement
			]
		]
	].

]

{ #category : #testing }
SAsmX86RegisterAddress >> hasSmallDisplacement [
	^ displacement isInteger and: [ displacement between: -128 and: 128 ]
]

{ #category : #accessing }
SAsmX86RegisterAddress >> index [
	^ index
]

{ #category : #accessing }
SAsmX86RegisterAddress >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmX86RegisterAddress >> initialize [
	scale := 1.
	displacement := 0.
]

{ #category : #testing }
SAsmX86RegisterAddress >> isRegisterAddress [
	^ true
]

{ #category : #testing }
SAsmX86RegisterAddress >> isRegisterOrRegisterAddress [
	^ true
]

{ #category : #testing }
SAsmX86RegisterAddress >> isRegisterOrRegisterAddressI8 [
	^ size = 1
]

{ #category : #testing }
SAsmX86RegisterAddress >> isRegisterOrRegisterAddressWord [
	^ self isRegisterOrRegisterAddressI8 not
]

{ #category : #testing }
SAsmX86RegisterAddress >> needsSibByte [
	^ (base isNotNil and: [ base valueLow == ESP value ]) or: [ scale ~= 1 or: [ index isNotNil ] ]
]

{ #category : #printing }
SAsmX86RegisterAddress >> printOn: aStream [
	| hasPrevious |
	aStream nextPut: $[.
	hasPrevious := false.
	base ifNotNil: [.
		aStream print: base.
		hasPrevious := true
	].
	index ifNotNil: [.
		hasPrevious ifTrue: [ aStream nextPutAll: ' + ' ].
		aStream
			print: index; nextPut: $*; print: scale.
		hasPrevious := true
	].
	displacement ~= 0 ifTrue: [.
		hasPrevious ifTrue: [ aStream nextPutAll: ' + ' ].
		aStream
			print: displacement
	].

	aStream nextPut: $].

]

{ #category : #'as yet unclassified' }
SAsmX86RegisterAddress >> qword [
	^ self copy size: 8
]

{ #category : #accessing }
SAsmX86RegisterAddress >> scale [
	^ scale
]

{ #category : #accessing }
SAsmX86RegisterAddress >> scale: anObject [
	scale := anObject
]

{ #category : #accessing }
SAsmX86RegisterAddress >> size [
	^ size
]

{ #category : #accessing }
SAsmX86RegisterAddress >> size: anObject [
	size := anObject
]

{ #category : #'as yet unclassified' }
SAsmX86RegisterAddress >> word [
	^ self copy size: 2
]
