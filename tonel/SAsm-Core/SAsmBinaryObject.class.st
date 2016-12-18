Class {
	#name : #SAsmBinaryObject,
	#superclass : #Object,
	#instVars : [
		'sections',
		'compilationTarget',
		'symbols',
		'moduleType'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #comparing }
SAsmBinaryObject >> = other [
	^ self class = other class
		and: [ sections = other sections
		and: [ symbols = other symbols ] ]
]

{ #category : #writing }
SAsmBinaryObject >> buildElfOn: builder [
	| elfSection |
	builder header 
		machine: compilationTarget elfMachine.
	builder createSymbolTable.
	self isObjectCode ifFalse: [
		builder createDynSymbolTable.
	].

	sections do: [ :section |
		elfSection := builder addFirstComponent: section sectionNamed: section name.
		elfSection programBits; allocated.
		elfSection address: section base.
		"Ensure the local symbols come before the globals."
		builder indexOfRelocationSymbol: nil section: elfSection.
		
		(#('.text' '.oopRegistration') includes: section name) ifTrue: [ elfSection executableInstructions ].
		(#('.bss' '.data' '.oop') includes: section name) ifTrue: [
			elfSection
				writeable;
				addressAlign: 16
		].
		(#('.text' '.rodata') includes: section name) ifTrue: [
			elfSection
				addressAlign: 16
		].

		section name = #'.bss' ifTrue: [ elfSection nobits ].
	].

	symbols do: [ :symbol |
		builder addSymbol: symbol.
	].

	sections do: [ :section |
		section relocations do: [ :relocation |
			compilationTarget convertRelocation: relocation section: section elfBuilder: builder
		]
	]
]

{ #category : #accessing }
SAsmBinaryObject >> compilationTarget [
	^ compilationTarget
]

{ #category : #accessing }
SAsmBinaryObject >> compilationTarget: anObject [
	compilationTarget := anObject
]

{ #category : #writing }
SAsmBinaryObject >> generateElf32 [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeElf32ToStream: stream.
	^ stream contents
]

{ #category : #writing }
SAsmBinaryObject >> generateElf64 [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeElf64ToStream: stream.
	^ stream contents
]

{ #category : #initialization }
SAsmBinaryObject >> initialize [
	super initialize.
	moduleType := #object.
	symbols := #().
	compilationTarget := SAsmCompilationTargetX86 new.
]

{ #category : #testing }
SAsmBinaryObject >> isFullProgram [
	^ moduleType == #program
]

{ #category : #testing }
SAsmBinaryObject >> isObjectCode [
	^ moduleType == #object
]

{ #category : #accessing }
SAsmBinaryObject >> sections [
	^ sections
]

{ #category : #accessing }
SAsmBinaryObject >> sections: anObject [
	sections := anObject
]

{ #category : #accessing }
SAsmBinaryObject >> symbols [
	^ symbols
]

{ #category : #accessing }
SAsmBinaryObject >> symbols: anObject [
	symbols := anObject
]

{ #category : #writing }
SAsmBinaryObject >> writeElf32ToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateElf32
	]
]

{ #category : #writing }
SAsmBinaryObject >> writeElf32ToStream: stream [
	| builder |
	builder := SAsmElf32Builder new.
	self buildElfOn: builder.
	builder writeToStream: stream
]

{ #category : #writing }
SAsmBinaryObject >> writeElf64ToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateElf64
	]
]

{ #category : #writing }
SAsmBinaryObject >> writeElf64ToStream: stream [
	| builder |
	builder := SAsmElf64Builder new.
	self buildElfOn: builder.
	builder writeToStream: stream
]

{ #category : #writing }
SAsmBinaryObject >> writeElfToFileNamed: fileName [
	compilationTarget usesElf64 ifTrue: [
		self writeElf64ToFileNamed: fileName
	] ifFalse: [
		self writeElf32ToFileNamed: fileName
	]
]

{ #category : #writing }
SAsmBinaryObject >> writeToFileNamed: aFileName [
	aFileName asFileReference writeStreamDo: [ :out | out binary.
		sections do: [ :section |
			out nextPutAll: section data
		]
	]
]
