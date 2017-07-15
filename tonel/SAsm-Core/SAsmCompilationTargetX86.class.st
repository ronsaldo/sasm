Class {
	#name : #SAsmCompilationTargetX86,
	#superclass : #SAsmCompilationTarget,
	#instVars : [
		'positionIndependentCode'
	],
	#classVars : [
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
		'R_386_RELATIVE'
	],
	#pools : [
		'SAsmCoffConstants',
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'class initialization' }
SAsmCompilationTargetX86 class >> initialize [
	super initialize.
	
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

{ #category : #'calling conventions' }
SAsmCompilationTargetX86 >> callingConventionNamed: aCallingConventionName [
	aCallingConventionName == #naked ifTrue: [ ^ SAsmX86CallingConventionNaked new ].
	aCallingConventionName == #stdcall ifTrue: [ ^ SAsmX86CallingConventionStdcall new ].
	aCallingConventionName == #cdecl ifTrue: [ ^ SAsmX86CallingConventionCDecl new ].
	aCallingConventionName == #smalltalk ifTrue: [ ^ SAsmX86CallingConventionSmalltalk new ].
	aCallingConventionName == #smalltalk_send ifTrue: [ ^ SAsmX86CallingConventionSmalltalkSend new ].
	aCallingConventionName == #smalltalk_supersend ifTrue: [ ^ SAsmX86CallingConventionSmalltalkSuperSend new ].
	aCallingConventionName == #apicall ifTrue: [
	].

	self error: 'Unknown calling convention ' , aCallingConventionName
]

{ #category : #'elf constants' }
SAsmCompilationTargetX86 >> coffMachine [
	^ 16r14c
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86 >> convertRelocation: relocation section: section coffBuilder: coffBuilder [
	| table coffReloc symbolIndex |
	relocation applyImplicitAddendIn: section relativeWithExtraAddend: 4.
	table := coffBuilder relocationTableForSectionContent: section.
	
	coffReloc := table newEntry.
	symbolIndex := coffBuilder indexOfRelocationSymbol: relocation symbol section: (coffBuilder sectionFromContent: relocation section).
	
	coffReloc
		virtualAddress: relocation offset;
		symbolTableIndex: symbolIndex.
		
	relocation isAbsoluteOffset32 ifTrue: [
		^ coffReloc type: IMAGE_REL_I386_DIR32
	].
	relocation isSectionRelativeOffset32 ifTrue: [
		^ coffReloc type: IMAGE_REL_I386_SECREL
	].
	relocation isRelativeSOffset32 ifTrue: [
		^ coffReloc type: IMAGE_REL_I386_REL32
	].

	self error: 'Unsupported relocation type.'
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86 >> convertRelocation: relocation section: section elfBuilder: elfBuilder [
	| table elfReloc symbolIndex |
	relocation applyImplicitAddendIn: section.
	table := elfBuilder relocationSectionFor: section.
	elfReloc := table newEntry.
	symbolIndex := elfBuilder indexOfRelocationSymbol: relocation symbol section: (elfBuilder sectionFromContent: relocation section).
	elfReloc offset: relocation offset.
	(relocation isAbsoluteOffset32 or: [ relocation isSectionRelativeOffset32 ]) ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_386_32
	].
	relocation isRelativeSOffset32 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_386_PC32
	].

	self error: 'Unsupported relocation type.'
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> createInstructionLowerer [
	^ SAsmX86InstructionLowerer new target: self
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> csymbolPrefix [
	(#(win32 osx) includes: operatingSystemName)  ifTrue: [^ #_ ].
	^ ''
]

{ #category : #'elf constants' }
SAsmCompilationTargetX86 >> elfMachine [
	^ 3
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> emitNopOfSize: paddingSize with: writer [
	| remainingSize pattern |
	remainingSize := paddingSize.
	[remainingSize > 0] whileTrue: [
		pattern := NopFillPattern32_Intel at: (remainingSize min: NopFillPattern32_Intel size).
		writer nextPutAll: pattern.
		remainingSize := remainingSize - pattern size
	].

	"1 to: paddingSize do: [ :i | writer nextPut: 16r90 ]"
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> framePointerRegister [
	^ EBP
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> gotBaseRegister [
	^ EBX
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> hasPositionIndependentCode [
	^ positionIndependentCode
]

{ #category : #initialization }
SAsmCompilationTargetX86 >> initialize [
	super initialize.
	positionIndependentCode := false
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newDoubleFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 8;
		registerClass: SAsmX86RegisterVector;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 4;
		registerClass: SAsmX86RegisterVector;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newFloatVirtualRegistersForSize: size [
	size = 4 ifTrue: [ ^ { self newFloatVirtualRegister } ].
	size = 8 ifTrue: [ ^ { self newDoubleFloatVirtualRegister } ].
	self error: 'Unsupported float register type'
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newIntegerVirtualRegister [
	^ SAsmIntegerVirtualRegister new size: 4;
		registerClass: SAsmX86RegisterInt32;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newIntegerVirtualRegistersForSize: size [
	^ (1 to: size + 3 // 4) collect: [ :i | self newIntegerVirtualRegister ]
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> pointerSize [
	^ 4
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> positionIndependentCode: anObject [
	positionIndependentCode := anObject
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> setupBinaryObjectWriter: writer [
	writer cpuMode: #protected
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> stackPointerRegister [
	^ ESP
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> usesElf64 [
	^ false
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> withPositionIndependentCode [
	self positionIndependentCode: true
]
