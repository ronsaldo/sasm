Class {
	#name : #'SAsmCompilationTargetX86_64',
	#superclass : #SAsmCompilationTarget,
	#instVars : [
		'positionIndependentCode'
	],
	#classVars : [
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
		'R_X86_64_TPOFF64'
	],
	#pools : [
		'SAsmCoffConstants',
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'class initialization' }
SAsmCompilationTargetX86_64 class >> initialize [
	super initialize.
	
	self initializeElfRelocations.
]

{ #category : #initialization }
SAsmCompilationTargetX86_64 class >> initializeElfRelocations [

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

{ #category : #'calling conventions' }
SAsmCompilationTargetX86_64 >> callingConventionNamed: aCallingConventionName [
	aCallingConventionName == #naked ifTrue: [ ^ SAsmX86_64CallingConventionNaked new ].
	operatingSystemName == #win32 ifTrue: [ 
		aCallingConventionName == #stdcall ifTrue: [ ^ SAsmX86_64CallingConventionCDeclWindows new ].
		aCallingConventionName == #cdecl ifTrue: [ ^ SAsmX86_64CallingConventionCDeclWindows new ].
		aCallingConventionName == #apicall ifTrue: [ ^ SAsmX86_64CallingConventionCDeclWindows new ].
	] ifFalse: [ 
		aCallingConventionName == #stdcall ifTrue: [ ^ SAsmX86CallingConventionCDecl new ].
		aCallingConventionName == #cdecl ifTrue: [ ^ SAsmX86_64CallingConventionCDecl new ].
		aCallingConventionName == #apicall ifTrue: [ ^ SAsmX86_64CallingConventionCDecl new ].
	].

	aCallingConventionName == #smalltalk ifTrue: [ ^ SAsmX86_64CallingConventionSmalltalk new ].
	aCallingConventionName == #smalltalk_send ifTrue: [ ^ SAsmX86_64CallingConventionSmalltalkSend new ].
	aCallingConventionName == #smalltalk_supersend ifTrue: [ ^ SAsmX86_64CallingConventionSmalltalkSuperSend new ].

	self error: 'Unknown calling convention ' , aCallingConventionName
]

{ #category : #'elf constants' }
SAsmCompilationTargetX86_64 >> coffMachine [
	^ IMAGE_FILE_MACHINE_AMD64
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86_64 >> convertRelocation: relocation section: section coffBuilder: coffBuilder [
	| table coffReloc symbolIndex |
	relocation applyImplicitAddendIn: section relativeWithExtraAddend: 4.
	table := coffBuilder relocationTableForSectionContent: section.
	
	coffReloc := table newEntry.
	symbolIndex := coffBuilder indexOfRelocationSymbol: relocation symbol section: (coffBuilder sectionFromContent: relocation section).
	
	coffReloc
		virtualAddress: relocation offset;
		symbolTableIndex: symbolIndex.
		
	relocation isAbsoluteOffset32 ifTrue: [
		^ coffReloc type: IMAGE_REL_AMD64_ADDR32
	].
	relocation isAbsoluteOffset64 ifTrue: [
		^ coffReloc type: IMAGE_REL_AMD64_ADDR64
	].
	relocation isSectionRelativeOffset64 ifTrue: [
		^ coffReloc type: IMAGE_REL_AMD64_SECREL
	].
	relocation isRelativeSOffset32 ifTrue: [
		^ coffReloc type: IMAGE_REL_AMD64_REL32
	].

	self error: 'Unsupported relocation type.'
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86_64 >> convertRelocation: relocation section: section elfBuilder: elfBuilder [
	| table elfReloc symbolIndex |
	table := elfBuilder relocationWithAddendSectionFor: section.
	relocation clearImplicitAddendIn: section.
	
	elfReloc := table newEntry.
	symbolIndex := elfBuilder indexOfRelocationSymbol: relocation symbol section: (elfBuilder sectionFromContent: relocation section).
	elfReloc
		offset: relocation offset;
		addend: relocation addend.
	(relocation isAbsoluteOffset32 or: [ relocation isSectionRelativeOffset32 ]) ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_32
	].
	relocation isRelativeSOffset32 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_PC32
	].
	(relocation isAbsoluteOffset64 or: [ relocation isSectionRelativeOffset64 ]) ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_64
	].
	relocation isRelativeSOffset64 ifTrue: [
		^ elfReloc symbol: symbolIndex type: R_X86_64_PC64
	].
	self halt.
	

]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> createInstructionLowerer [
	^ SAsmX86InstructionLowerer new target: self
]

{ #category : #'elf constants' }
SAsmCompilationTargetX86_64 >> elfMachine [
	^ 16r3E
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> emitNopOfSize: paddingSize with: writer [
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
SAsmCompilationTargetX86_64 >> framePointerRegister [
	^ RBP
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> gotBaseRegister [
	^ RBX
]

{ #category : #testing }
SAsmCompilationTargetX86_64 >> hasPositionIndependentCode [
	^ positionIndependentCode
]

{ #category : #initialization }
SAsmCompilationTargetX86_64 >> initialize [
	super initialize.
	positionIndependentCode := false
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newDoubleFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 8;
		registerClass: SAsmX86RegisterVector;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 4;
		registerClass: SAsmX86RegisterVector;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newFloatVirtualRegistersForSize: size [
	size = 4 ifTrue: [ ^ { self newFloatVirtualRegister } ].
	size = 8 ifTrue: [ ^ { self newDoubleFloatVirtualRegister } ].
	self error: 'Unsupported float register type'
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newIntegerVirtualRegister [
	^ SAsmIntegerVirtualRegister new size: 8;
		registerClass: SAsmX86RegisterInt64;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newIntegerVirtualRegistersForSize: size [
	^ (1 to: size + 7 // 8) collect: [ :i | self newIntegerVirtualRegister ]
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> pointerSize [
	^ 8
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> setupBinaryObjectWriter: writer [
	writer cpuMode: #long
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> stackPointerRegister [
	^ RSP
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> usesElf64 [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> withPositionIndependentCode [
	self positionIndependentCode: true
]
