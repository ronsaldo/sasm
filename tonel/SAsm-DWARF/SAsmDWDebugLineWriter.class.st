Class {
	#name : #SAsmDWDebugLineWriter,
	#superclass : #SAsmDWObject,
	#instVars : [
		'pointerSize',
		'directoryDictionary',
		'directories',
		'fileDictionary',
		'files',
		'lineBase',
		'lineRange',
		'out',
		'regAddress',
		'regOpIndex',
		'regFile',
		'regLine',
		'regColumn',
		'defaultIsStatement',
		'regIsStatement',
		'regBasicBlock',
		'regEndSequence',
		'regPrologueEnd',
		'regISA',
		'regDiscriminator',
		'regAddressSection',
		'outRelocations',
		'programRelocations',
		'regEpìlogueBegin',
		'minimumInstructionLength',
		'maxNumberOfOperationsPerInstructions',
		'opcodeBase'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #adding }
SAsmDWDebugLineWriter >> addSourceDirectory: directory [
	directory ifEmpty: [ ^ 0 ].
	^ directoryDictionary at: directory ifAbsentPut: [ 
		directories add: directory.
		directories size.
	]
	
]

{ #category : #writing }
SAsmDWDebugLineWriter >> addSourceFile: sourceFile [
	| directoryIndex |
	^ fileDictionary at: sourceFile ifAbsentPut: [ 
		directoryIndex := self addSourceDirectory: sourceFile directory.
		files add: {directoryIndex . sourceFile}.
		files size.
	]
	
]

{ #category : #'as yet unclassified' }
SAsmDWDebugLineWriter >> advanceAndEmitLine: lineAdvance pc: pcAdvance operationIndex: operationIndexAdvance [
	| opcode operationAdvance |
	
	self assert: operationIndexAdvance = 0.
	self assert: maxNumberOfOperationsPerInstructions = 1.
	self assert: pcAdvance >= 0.
	
	operationAdvance := pcAdvance / minimumInstructionLength.
	
	opcode := (lineAdvance - lineBase) + (lineRange * operationAdvance) + opcodeBase.
	(opcode <= 255 and: [lineAdvance - lineBase < lineRange and: [lineAdvance >= lineBase ]]) ifTrue: [ 
		self byte: opcode.
		regLine := regLine + lineAdvance.
		regAddress := regAddress + pcAdvance
	] ifFalse: [ 
		self
			advanceLine: lineAdvance;
			advancePC: pcAdvance;
			copyRow
	].

	"Transcript show: 'Advance line: ', lineAdvance asString , ' to: ' , regLine asString;
		show: ' pc: ', pcAdvance asString , ' to: ' , regAddress asString; cr."
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> advanceLine: advance [
	self byte: DW_LNS_advance_line value; sleb128: advance.
	regLine := regLine + advance
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> advancePC: advance [
	self byte: DW_LNS_advance_pc value; uleb128: advance.
	regAddress := regAddress + advance
]

{ #category : #'stream writing' }
SAsmDWDebugLineWriter >> byte: value [
	out nextPut: value & 16rFF
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> constAddPC [
	self byte: DW_LNS_const_add_pc value.
	self halt
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> copyRow [
	self byte: DW_LNS_copy value.
	regDiscriminator := false.
	regBasicBlock := false.
	regPrologueEnd := false.
	regEpìlogueBegin := false.
]

{ #category : #writing }
SAsmDWDebugLineWriter >> cstring: aByteString [
	aByteString do: [ :char | out nextPut: char asInteger ].
	self byte: 0.
]

{ #category : #writing }
SAsmDWDebugLineWriter >> emitLocation: sourceLocation [
	"Set the address whenever we change the section."
	| pcAdvance lineAdvance |
	regAddressSection ~~ sourceLocation section ifTrue: [ 
		self setAddress: sourceLocation
	].

	self
		setFile: (fileDictionary at: sourceLocation data sourceFile);
		setColumn: sourceLocation data startColumn.

	pcAdvance := sourceLocation position - regAddress.
	lineAdvance := sourceLocation data startLine - regLine.

	self advanceAndEmitLine: lineAdvance pc: pcAdvance operationIndex: 0
]

{ #category : #writing }
SAsmDWDebugLineWriter >> endSequence [
	self byte: 0; uleb128: 1; byte: DW_LNE_end_sequence value
]

{ #category : #writing }
SAsmDWDebugLineWriter >> generateProgramFor: sourceLocations [
	^ ByteArray streamContents: [ :o |
		out := o.
		outRelocations := programRelocations := OrderedCollection new.
		
		regAddress := 0.
		regAddressSection := nil.
		regOpIndex := 0.
		regFile := 1.
		regLine := 1.
		regColumn := 0.
		regIsStatement := defaultIsStatement.
		regBasicBlock := false.
		regEndSequence := false.
		regPrologueEnd := false.
		regEpìlogueBegin := false.
		regISA := 0.
		regDiscriminator := 0.
		sourceLocations do: [ :loc |
			self emitLocation: loc
		].
	
		self endSequence
	]
]

{ #category : #writing }
SAsmDWDebugLineWriter >> generateProgramHeader [
	^ ByteArray streamContents: [ :o |
		out := o.
		
		self
			byte: 1 "minimum_instruction_length";
			byte: 1 "maximum_operations_per_instruction";
			byte: defaultIsStatement asBit;
			byte: lineBase;
			byte: lineRange;
			byte: opcodeBase "opcode_base";
			
			byte: 0; "DW_LNS_copy"
			byte: 1; "DW_LNS_advance_pc"
			byte: 1; "DW_LNS_advance_line"
			byte: 1; "DW_LNS_set_file"
			byte: 1; "DW_LNS_set_column"
			byte: 0; "DW_LNS_negate_stmt"
			byte: 0; "DW_LNS_set_basic_block"
			byte: 0; "DW_LNS_const_add_pc"
			byte: 1; "DW_LNS_fixed_advance_pc"
			byte: 0; "DW_LNS_set_prologue_end"
			byte: 0; "DW_LNS_set_epilogue_begin"
			byte: 1; "DW_LNS_set_isa"
			
			yourself.
		
		"Directories"
		directories do: [ :dir | self cstring: dir ].
		self byte: 0.
		
		"Files"
		files do: [ :file |
			self
				cstring: (file second name ifEmpty: ['unknown']);
				uleb128: file first;
				uleb128: 0;
				uleb128: 0.
		].
		self byte: 0.
	]
]

{ #category : #initialization }
SAsmDWDebugLineWriter >> initialize [
	super initialize.
	defaultIsStatement := true.
	maxNumberOfOperationsPerInstructions := 1.
	minimumInstructionLength := 1.
	opcodeBase := 13.
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> negateStatement [
	self byte: DW_LNS_negate_stmt value.
	regIsStatement := regIsStatement not
]

{ #category : #writing }
SAsmDWDebugLineWriter >> relocatableAddress: address [
	outRelocations add: { out position . address }.
	regAddress := address position.
	regAddressSection := address section.
	1 to: pointerSize do: [ :i | out nextPut: 0 ]
]

{ #category : #writing }
SAsmDWDebugLineWriter >> setAddress: address [
	self byte: 0; uleb128: 1 + pointerSize; byte: DW_LNE_set_address value; relocatableAddress: address
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> setBasicBlock [
	self byte: DW_LNS_set_basic_block value.
	regBasicBlock := true
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> setColumn: column [
	regColumn = column ifTrue: [ ^ self ].
	
	self byte: DW_LNS_set_column value; uleb128: column.
	regColumn := column
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> setEpilogueBegin [
	self byte: DW_LNS_set_epilogue_begin value.
	regEpìlogueBegin := true
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> setFile: fileIndex [
	regFile = fileIndex ifTrue: [ ^ self ].
	
	self byte: DW_LNS_set_file value; uleb128: fileIndex.
	regFile := fileIndex
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> setISA: value [
	self byte: DW_LNS_set_isa value; uleb128: value.
	regISA := value
]

{ #category : #opcodes }
SAsmDWDebugLineWriter >> setPrologueEnd [
	self byte: DW_LNS_set_prologue_end value.
	regPrologueEnd := true
]

{ #category : #constants }
SAsmDWDebugLineWriter >> sleb128: value [
	| currentValue more byte |
	more := true.
	currentValue := value.
	[ more ] whileTrue: [ 
		byte := currentValue & 127.
		currentValue := currentValue >> 7.
		
		((currentValue = 0 and: [ byte & 64 = 0]) or:
		[ (currentValue = -1 and: [ byte & 64 ~= 0]) ]) ifTrue: [ 
			more := false.
		] ifFalse: [
			byte := byte | 128
		].
	
		self byte: byte
	]
]

{ #category : #'stream writing' }
SAsmDWDebugLineWriter >> uleb128: value [
	| currentValue nextValue |
	currentValue := value & 16rFFFFFFFFFFFFFFFF.
	[
		nextValue := currentValue >> 7.
		self byte: (currentValue & 127) | (nextValue ~= 0 ifTrue: [128] ifFalse: [0]).
		currentValue := nextValue.
	] doWhileTrue: [ currentValue ~= 0 ].
]

{ #category : #writing }
SAsmDWDebugLineWriter >> writeSourceLocations: sourceLocations with: writer [
	| minLine maxLine program programHeader relocAddressBase objectReloc previousLine lineAdvance |
	pointerSize := writer target pointerSize.
	
	directoryDictionary := Dictionary new.
	directories := OrderedCollection new.
	
	fileDictionary := Dictionary new.
	files := OrderedCollection new.
	
	minLine := SmallInteger maxVal.
	maxLine := SmallInteger minVal.
	previousLine := 1.
	sourceLocations do: [ :loc |
		self addSourceFile: loc data sourceFile.
		lineAdvance := loc data startLine - previousLine.
		previousLine := loc data startLine.
		
		lineAdvance abs < 8 ifTrue: [ 
			minLine := minLine min: lineAdvance.
			maxLine := maxLine max: lineAdvance.
		]
	].

	lineBase := minLine min: 127 max: -128.
	lineRange := maxLine - minLine min: 255.
	
	programHeader := self generateProgramHeader.
	program := self generateProgramFor: sourceLocations.
	
	pointerSize = 4 ifTrue: [ 
		writer
			nextPutC32: programHeader size + program size + pointerSize + 2.
	] ifFalse: [ 
		writer
			nextPutC32: 16rffffffff;
			nextPutC64: programHeader size + program size + pointerSize + 2.
	].
		
	writer
		nextPutC16: 4.
	pointerSize = 4 ifTrue: [
		writer nextPutC32: programHeader size
	] ifFalse: [ 
		writer nextPutC64: programHeader size
	].

	writer nextPutAll: programHeader.
	relocAddressBase := writer currentSectionPosition.
	writer nextPutAll: program.
	
	programRelocations do: [ :reloc |
		objectReloc := writer
			addRelocationAt: reloc first + relocAddressBase
			toSection: reloc second section
			addend: reloc second position.
		pointerSize = 4 ifTrue: [
			objectReloc absoluteOffset32
		] ifFalse: [
			objectReloc absoluteOffset64
		]
	].


]
