Class {
	#name : #SAsmCompilationTargetX86,
	#superclass : #SAsmCompilationTarget,
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
	aCallingConventionName == #apicall ifTrue: [
	].

	self error: 'Unknown calling convention ' , aCallingConventionName
]

{ #category : #'elf relocations' }
SAsmCompilationTargetX86 >> convertRelocation: relocation section: section elfBuilder: elfBuilder [
	| table elfReloc symbolIndex |
	relocation applyImplicitAddendIn: section.
	table := elfBuilder relocationSectionFor: section.
	elfReloc := table newEntry.
	symbolIndex := elfBuilder indexOfRelocationSymbol: relocation symbol section: (elfBuilder sectionFromContent: relocation section).
	elfReloc offset: relocation offset.
	relocation isAbsoluteOffset32 ifTrue: [
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

{ #category : #'elf constants' }
SAsmCompilationTargetX86 >> elfMachine [
	^ 3
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> framePointerRegister [
	^ EBP
]

{ #category : #accessing }
SAsmCompilationTargetX86 >> pointerSize [
	^ 4
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
