Class {
	#name : #'SAsmCompilationTargetX86_64',
	#superclass : #SAsmCompilationTarget,
	#instVars : [
		'positionIndependentCode'
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
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> cFunctionPrefix [
	(#(osx) includes: operatingSystemName)  ifTrue: [^ #_ ].
	^ ''
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> cVariablePrefix [
	(#(osx) includes: operatingSystemName)  ifTrue: [^ #_ ].
	^ ''
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
	relocation isRelativeSOffset32OrBranch32 ifTrue: [
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
	relocation isRelativeBranch32 ifTrue: [
		(self hasPositionIndependentCode and: [relocation symbol isNotNil]) ifTrue: [ 
			^ elfReloc symbol: symbolIndex type: R_X86_64_PLT32
		].
		^ elfReloc symbol: symbolIndex type: R_X86_64_PC32
	].
	relocation isRelativeSOffset32AtGOT ifTrue: [
		self assert: self hasPositionIndependentCode.
		^ elfReloc symbol: symbolIndex type: R_X86_64_GOTPCREL
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

	self error: 'Unsupported relocation type.'
	

]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86_64 >> convertRelocation: relocation section: section machoBuilder: machBuilder [
	| table machReloc pcrel length machSection extern symbolnum machRelocatedSection type |
	relocation applyImplicitAddendIn: section relativeWithExtraAddend: 4.
	(relocation isSectionRelativeOffset32 or: [ relocation isSectionRelativeOffset64 ]) ifTrue: [
		"Do not emit a relocation for this case."
		^ self
	].

	machSection := machBuilder sectionFromContent: relocation section.
	machRelocatedSection := machBuilder sectionFromContent: section.

	table := machBuilder relocationTableFor: section.
	
	extern := relocation symbol isNotNil.
	symbolnum := machBuilder indexOfRelocationSymbol: relocation symbol section: machSection.
	self assert: symbolnum isNotNil.
	
	machReloc := table newEntry.
	type := SAsmMachConstants X86_64_RELOC_UNSIGNED.
	(relocation isRelativeSOffset32 or: [ relocation isRelativeSOffset64 ]) ifTrue: [ 
		type := SAsmMachConstants X86_64_RELOC_SIGNED.
	].

	(relocation isAbsoluteOffset32 or: [relocation isRelativeSOffset32OrBranch32 ]) ifTrue: [
		pcrel := relocation isRelativeSOffset32OrBranch32.	
		length := 2.
		relocation isRelativeBranch32 ifTrue: [
			type := SAsmMachConstants X86_64_RELOC_BRANCH
		].
	] ifFalse: [
		(relocation isAbsoluteOffset64 or: [relocation isRelativeSOffset64 ]) ifTrue: [
			pcrel := relocation isRelativeSOffset64.
			length := 3.
		] ifFalse: [
			self error: 'Unsupported relocation type'
		]
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

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> gotBaseRegister [
	^ R15
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

{ #category : #'mach-o' }
SAsmCompilationTargetX86_64 >> machCPUSubType [
	^ SAsmMachConstants CPU_SUBTYPE_I386_ALL
]

{ #category : #'mach-o' }
SAsmCompilationTargetX86_64 >> machCPUType [
	^ SAsmMachConstants CPU_TYPE_X86_64
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newDoubleFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 8;
		alignment: 8;
		registerClass: SAsmX86RegisterVector;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newFloatVirtualRegister [
	^ SAsmFloatVirtualRegister new
		size: 4;
		alignment: 4;
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
		alignment: 8;
		registerClass: SAsmX86RegisterInt64;
		yourself
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newIntegerVirtualRegistersForSize: size [
	^ self newIntegerVirtualRegistersForSize: size dynamicRoot: false
]

{ #category : #'virtual registers' }
SAsmCompilationTargetX86_64 >> newIntegerVirtualRegistersForSize: size dynamicRoot: dynamicRoot [
	^ (1 to: size + 7 // 8) collect: [ :i | self newIntegerVirtualRegister dynamicRoot: dynamicRoot ]
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> pointerSize [
	^ 8
]

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> positionIndependentCode: anObject [
	positionIndependentCode := anObject
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

{ #category : #accessing }
SAsmCompilationTargetX86_64 >> usesMachO64 [
	^ true
]

{ #category : #'as yet unclassified' }
SAsmCompilationTargetX86_64 >> withPositionIndependentCode [
	self positionIndependentCode: true
]
