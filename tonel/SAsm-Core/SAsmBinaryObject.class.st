Class {
	#name : #SAsmBinaryObject,
	#superclass : #Object,
	#instVars : [
		'sections',
		'compilationTarget',
		'symbols',
		'moduleType'
	],
	#classVars : [
		'MachOSectionToSegmentMap'
	],
	#category : #'SAsm-Core-Binary'
}

{ #category : #initialization }
SAsmBinaryObject class >> initialize [
	MachOSectionToSegmentMap := Dictionary newFromPairs: #(
		'.text' '__TEXT'
		'.data' '__DATA'
		'.rodata' '__DATA'
		'.bss' '__DATA'
		
		'.oop' '__OOP'
		
		'.debug_abbrev' '__DWARF'
		'.debug_line' '__DWARF'
		'.debug_info' '__DWARF'
		'.debug_loc' '__DWARF'
		'.debug_str' '__DWARF'
	).
]

{ #category : #comparing }
SAsmBinaryObject >> = other [
	^ self class = other class
		and: [ sections = other sections
		and: [ symbols = other symbols ] ]
]

{ #category : #'writing coff' }
SAsmBinaryObject >> buildCoffOn: builder [
	| coffSection |
	builder header
		machine: compilationTarget coffMachine.
		
	builder createSymbolTable.
	
	sections do: [ :section |
		coffSection := builder addSection: section named: section name.
		coffSection virtualAddress: section base.
		
		"Ensure the local symbols come before the globals."
		builder indexOfRelocationSymbol: nil section: coffSection.
		
		section loaded ifTrue: [ coffSection programBits ] ifFalse: [ coffSection nobits ].
		section readable ifTrue: [ coffSection readable ].
		section writeable ifTrue: [ coffSection writeable ].
		section executable ifTrue: [ coffSection executableInstructions ].
		coffSection addressAlign: section alignment.
	].

	symbols do: [ :symbol |
		builder addSymbol: symbol.
	].

	sections do: [ :section |
		section relocations do: [ :relocation |
			compilationTarget convertRelocation: relocation section: section coffBuilder: builder
		]
	]
]

{ #category : #'writing elf' }
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
		elfSection programBits.
		elfSection address: section base.
		"Ensure the local symbols come before the globals."
		builder indexOfRelocationSymbol: nil section: elfSection.
		
		section loaded ifFalse: [ elfSection nobits ].
		section readable ifTrue: [ elfSection allocated ].
		section writeable ifTrue: [ elfSection writeable ].
		section executable ifTrue: [ elfSection executableInstructions ].
		elfSection addressAlign: section alignment.
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

{ #category : #'writing mach-o' }
SAsmBinaryObject >> buildMachOOn: builder [
	| objectSegment machoSection segmentName baseAddress |
	builder header
		cputype: compilationTarget machCPUType;
		cpusubtype: compilationTarget machCPUSubType.
	self isObjectCode ifTrue: [ builder setObjectCode].
	
	baseAddress := 0.
	objectSegment := builder newSegment.
	sections do: [ :section |
		machoSection := builder addDataComponent: section inSegment: objectSegment.
		segmentName := self machoSegmentNameFor: section.
		machoSection
			name: (self machoSectionNameFor: section);
			segmentName: segmentName;
			align: (section alignment highBit - 1);
			addr: baseAddress.
		baseAddress := baseAddress + section size.
		
		section loaded ifFalse: [ machoSection zeroFill ].
		section executable ifTrue: [
			machoSection pureInstructions.
			objectSegment executable.
		].
		section readable ifTrue: [ objectSegment readable ].
		section writeable ifTrue: [ objectSegment writeable ].
	].

	builder createSymbolTable.
	
	symbols do: [ :symbol |
		builder addSymbol: symbol.
	].


]

{ #category : #accessing }
SAsmBinaryObject >> compilationTarget [
	^ compilationTarget
]

{ #category : #accessing }
SAsmBinaryObject >> compilationTarget: anObject [
	compilationTarget := anObject
]

{ #category : #'as yet unclassified' }
SAsmBinaryObject >> concretizePendingSymbolWith: objectWriter [
	sections do: [ :sec | sec concretizePendingSymbolWith: objectWriter ]
	
]

{ #category : #accessing }
SAsmBinaryObject >> fullCodeSize [
	| fullCodeSize |
	fullCodeSize := 0.
	sections do: [ :sec | fullCodeSize := fullCodeSize + sec size ].
	^ fullCodeSize
]

{ #category : #'writing binary' }
SAsmBinaryObject >> generateBinaryWithBase: baseAddress [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeBinaryWithBase: baseAddress toStream: stream.
	^ stream contents
]

{ #category : #'writing coff' }
SAsmBinaryObject >> generateCoff [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeCoffToStream: stream.
	^ stream contents
]

{ #category : #'writing elf' }
SAsmBinaryObject >> generateElf32 [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeElf32ToStream: stream.
	^ stream contents
]

{ #category : #'writing elf' }
SAsmBinaryObject >> generateElf64 [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeElf64ToStream: stream.
	^ stream contents
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> generateMachO32 [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeMachO32ToStream: stream.
	^ stream contents
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> generateMachO64 [
	| stream |
	stream := SAsmLirBinaryStream on: (ByteArray new: 100).
	self writeMachO64ToStream: stream.
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

{ #category : #'writing mach-o' }
SAsmBinaryObject >> machoSectionNameFor: section [
	^ section name first = $. ifTrue: [ '__' , section name allButFirst ] ifFalse: [ section name ]
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> machoSegmentNameFor: section [
	MachOSectionToSegmentMap at: section name ifPresent: [ :segmentName | ^ segmentName ].
	self halt

]

{ #category : #accessing }
SAsmBinaryObject >> sections [
	^ sections
]

{ #category : #accessing }
SAsmBinaryObject >> sections: anObject [
	sections := anObject
]

{ #category : #'as yet unclassified' }
SAsmBinaryObject >> showSectionSizesInTranscript [
	sections do: [ :sec |
		Transcript show: sec name; space; show: sec size; space.
	].
	Transcript cr.
]

{ #category : #accessing }
SAsmBinaryObject >> symbols [
	^ symbols
]

{ #category : #accessing }
SAsmBinaryObject >> symbols: anObject [
	symbols := anObject
]

{ #category : #'writing binary' }
SAsmBinaryObject >> writeBinaryBase: baseAddress toFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: (self generateBinaryWithBase: baseAddress)
	]
]

{ #category : #'writing binary' }
SAsmBinaryObject >> writeBinaryToFileNamed: fileName [
	^ self writeBinaryBase: 0 toFileNamed: fileName
]

{ #category : #'writing binary' }
SAsmBinaryObject >> writeBinaryWithBase: baseAddress toStream: aStream [
	"Set the section base addresses"
	| destAddress padding |
	destAddress := baseAddress.
	sections do: [ :section |
		section base: (destAddress alignedTo: section alignment).
		destAddress := destAddress + section size.
	].

	"Apply the relocations"
	sections do: #applyRelocations.
	
	"Write the sections."
	sections do: [ :section |
		padding := (aStream position + baseAddress alignedTo: section alignment) - baseAddress.
		1 to: padding do: [ :i | aStream nextPut: 0 ].
		aStream nextPutAll: section data
	]

]

{ #category : #'writing coff' }
SAsmBinaryObject >> writeCoffToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateCoff
	]
]

{ #category : #'writing coff' }
SAsmBinaryObject >> writeCoffToStream: stream [
	| builder |
	builder := SAsmCoffBuilder new.
	self buildCoffOn: builder.
	builder writeToStream: stream
]

{ #category : #'writing elf' }
SAsmBinaryObject >> writeElf32ToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateElf32
	]
]

{ #category : #'writing elf' }
SAsmBinaryObject >> writeElf32ToStream: stream [
	| builder |
	builder := SAsmElf32Builder new.
	self buildElfOn: builder.
	builder writeToStream: stream
]

{ #category : #'writing elf' }
SAsmBinaryObject >> writeElf64ToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateElf64
	]
]

{ #category : #'writing elf' }
SAsmBinaryObject >> writeElf64ToStream: stream [
	| builder |
	builder := SAsmElf64Builder new.
	self buildElfOn: builder.
	builder writeToStream: stream
]

{ #category : #'writing elf' }
SAsmBinaryObject >> writeElfToFileNamed: fileName [
	compilationTarget usesElf64 ifTrue: [
		self writeElf64ToFileNamed: fileName
	] ifFalse: [
		self writeElf32ToFileNamed: fileName
	]
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> writeMachO32ToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateMachO32
	]
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> writeMachO32ToStream: stream [
	| builder |
	builder := SAsmMachO32Builder new.
	self buildMachOOn: builder.
	builder writeToStream: stream
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> writeMachO64ToFileNamed: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate; binary.
		out nextPutAll: self generateMachO64
	]
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> writeMachO64ToStream: stream [
	| builder |
	builder := SAsmMachO64Builder new.
	self buildMachOOn: builder.
	builder writeToStream: stream
]

{ #category : #'writing mach-o' }
SAsmBinaryObject >> writeMachOToFileNamed: fileName [
	compilationTarget usesMachO64 ifTrue: [
		self writeMachO64ToFileNamed: fileName
	] ifFalse: [
		self writeMachO32ToFileNamed: fileName
	]
]
