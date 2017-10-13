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

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> cFunctionPrefix [
	(#(win32 osx) includes: operatingSystemName)  ifTrue: [^ #_ ].
	^ ''
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> cVariablePrefix [
	(#(win32 osx) includes: operatingSystemName)  ifTrue: [^ #_ ].
	^ ''
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

{ #category : #coff }
SAsmCompilationTargetX86 >> coffMachine [
	^ IMAGE_FILE_MACHINE_I386
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
	relocation isRelativeSOffset32OrBranch32 ifTrue: [
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
	relocation isRelativeBranch32 ifTrue: [
		(self hasPositionIndependentCode and: [relocation symbol isNotNil]) ifTrue: [ 
			^ elfReloc symbol: symbolIndex type: R_386_PLT32
		].

		^ elfReloc symbol: symbolIndex type: R_386_PC32
	].
	relocation isRelativeSOffset32 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_386_PC32
	].
	relocation isRelativeSOffset32GlobalOffsetTable ifTrue: [
		self assert: self hasPositionIndependentCode.
		^ elfReloc symbol: symbolIndex type: R_386_GOTPC
	].
	relocation isRelativeSOffset32AtGOT ifTrue: [
		self assert: self hasPositionIndependentCode.
		^ elfReloc symbol: symbolIndex type: R_386_GOT32
	].
	relocation isRelativeSOffset32GOTOffset ifTrue: [
		self assert: self hasPositionIndependentCode.
		^ elfReloc symbol: symbolIndex type: R_386_GOTOFF
	].

	self error: 'Unsupported relocation type.'
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86 >> convertRelocation: relocation section: section machoBuilder: machBuilder [
	| table machReloc pcrel length machSection extern symbolnum machRelocatedSection type |
	relocation isSectionRelativeOffset32 ifTrue: [
		"Do not emit a relocation for this case."
		relocation applyImplicitAddendIn: section.
		^ self
	].

	machSection := machBuilder sectionFromContent: relocation section.
	machRelocatedSection := machBuilder sectionFromContent: section.

	relocation applyImplicitAddendIn: section absoluteWithExtraAddend: (machSection ifNil: [0] ifNotNil: [machSection sectionOffset]) relativeWithExtraAddend: relocation offset negated - machRelocatedSection sectionOffset.
	table := machBuilder relocationTableFor: section.
	
	extern := relocation symbol isNotNil.
	symbolnum := machBuilder indexOfRelocationSymbol: relocation symbol section: machSection.
	self assert: symbolnum isNotNil.
	
	machReloc := table newEntry.
	type := SAsmMachConstants GENERIC_RELOC_VANILLA.
	(relocation isAbsoluteOffset32 or: [relocation isRelativeSOffset32OrBranch32 ]) ifTrue: [
		pcrel := relocation isRelativeSOffset32OrBranch32.
		length := 2.
	] ifFalse: [
		self error: 'Unsupported relocation type'
	].

	"extern ifTrue: [
		machRelocatedSection withExternalRelocations
	] ifFalse: [
		machRelocatedSection withLocalRelocations
	]."
	
	machReloc
		address: relocation offset;
		symbolnum: symbolnum pcrel: pcrel length: length extern: extern type: type
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> createInstructionLowerer [
	^ SAsmX86InstructionLowerer new target: self
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

{ #category : #'mach-o' }
SAsmCompilationTargetX86 >> machCPUSubType [
	^ SAsmMachConstants CPU_SUBTYPE_I386_ALL
]

{ #category : #'mach-o' }
SAsmCompilationTargetX86 >> machCPUType [
	^ SAsmMachConstants CPU_TYPE_X86
]

{ #category : #testing }
SAsmCompilationTargetX86 >> needsSlotForGOTPointer [
	^ self isWin32 not
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newDoubleFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 8;
		alignment: (self isWin32 ifTrue: [ 8 ] ifFalse: [4]);
		registerClass: SAsmX86RegisterVector;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 4;
		alignment: 4;
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
		alignment: 4;
		registerClass: SAsmX86RegisterInt32;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newIntegerVirtualRegistersForSize: size [
	^ self newIntegerVirtualRegistersForSize: size dynamicRoot: false
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86 >> newIntegerVirtualRegistersForSize: size dynamicRoot: dynamicRoot [
	^ (1 to: size + 3 // 4) collect: [ :i | self newIntegerVirtualRegister dynamicRoot: dynamicRoot ]
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

{ #category : #accessing }
SAsmCompilationTargetX86 >> usesMachO64 [
	^ false
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86 >> withPositionIndependentCode [
	self positionIndependentCode: true
]
