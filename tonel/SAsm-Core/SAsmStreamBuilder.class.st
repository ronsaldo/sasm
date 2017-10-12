Class {
	#name : #SAsmStreamBuilder,
	#superclass : #Object,
	#instVars : [
		'stream',
		'localScope',
		'currentSection',
		'sectionStack',
		'localVariableToGeneratedMap'
	],
	#pools : [
		'SAsmTacOperations'
	],
	#category : #'SAsm-Core-Builder'
}

{ #category : #constants }
SAsmStreamBuilder >> add: value [
	^ stream add: value
]

{ #category : #constants }
SAsmStreamBuilder >> addConstantExpressionValue: constantExpression [
	^ self add: (SAsmConstantExpressionValue new
		size: constantExpression size;
		value: constantExpression;
		yourself)
]

{ #category : #symbols }
SAsmStreamBuilder >> addPrivateSymbol: name for: anObject [
	^ (self addSymbol: name for: anObject)
		makePrivate;
		yourself
]

{ #category : #symbols }
SAsmStreamBuilder >> addSymbol: name for: anObject [
	| symbol |
	symbol := SAsmSymbol new name: name.
	localScope addMapToObject: anObject symbol: symbol.
	^ symbol
]

{ #category : #symbols }
SAsmStreamBuilder >> addSymbolCopy: aSymbol [
	localScope findMappedSymbolRecursively: aSymbol ifAbsent: [
		localScope addMapToObject: aSymbol symbol: aSymbol copy
	]
]

{ #category : #constants }
SAsmStreamBuilder >> align: alignment [
	^ self alignData: alignment
]

{ #category : #constants }
SAsmStreamBuilder >> alignCode: alignment [
	^ self add: (SAsmAlignInstruction new
		alignment: alignment;
		isCodeAlignment: true;
		yourself).
]

{ #category : #constants }
SAsmStreamBuilder >> alignData: alignment [
	^ self add: (SAsmAlignInstruction new
		alignment: alignment;
		isCodeAlignment: false;
		yourself).
]

{ #category : #sections }
SAsmStreamBuilder >> bssSection [
	^ self startSection: #'.bss' attributes: [ :section |
		section 
			loaded: false;
			executable: false;
			readable: true;
			writeable: true
	]
]

{ #category : #constants }
SAsmStreamBuilder >> const: value size: size [
	^ self add: (SAsmConstantExpressionValue new
		size: size;
		value: value asSAsmConstantExpression;
		yourself).
]

{ #category : #constants }
SAsmStreamBuilder >> constI16: value [
	^ self const: value size: 2
]

{ #category : #constants }
SAsmStreamBuilder >> constI32: value [
	^ self const: value size: 4
]

{ #category : #constants }
SAsmStreamBuilder >> constI64: value [
	^ self const: value size: 8
]

{ #category : #constants }
SAsmStreamBuilder >> constI8: value [
	^ self const: value size: 1
]

{ #category : #constants }
SAsmStreamBuilder >> constSectionRelative: value size: size [
	^ self add: (SAsmConstantExpressionValue new
		size: size;
		value: value asSAsmConstantExpression;
		yourself).
]

{ #category : #constants }
SAsmStreamBuilder >> cstring: aString [
	^ self addConstantExpressionValue: (SAsmConstantExpressionString new data: aString; hasExtraNullCharacter: true)
]

{ #category : #sections }
SAsmStreamBuilder >> currentSectionName [
	currentSection ifNil: [ ^ #'..nil..' ].
	^ currentSection name
]

{ #category : #sections }
SAsmStreamBuilder >> dataSection [
	^ self dataSectionNamed: nil
]

{ #category : #sections }
SAsmStreamBuilder >> dataSectionNamed: customSectionName [
	^ self startSection: (customSectionName ifNil: [#'.data']) attributes: [ :section |
		section 
			loaded: true;
			executable: false;
			readable: true;
			writeable: true
	]
]

{ #category : #'debug information' }
SAsmStreamBuilder >> debugSourceLocation: debugInformation [
	self add: (SAsmDebugLocation new data: debugInformation)
]

{ #category : #symbols }
SAsmStreamBuilder >> findOrCreateExternalSymbol: aSymbol type: symbolType [
	| scope |
	scope := self topLocalScope.
	^ scope findNamedSymbolRecursively: aSymbol ifAbsent: [
		scope addNamedSymbol: (SAsmSymbol new name: aSymbol;
			type: symbolType;
			makeExternal) 
	]

]

{ #category : #symbols }
SAsmStreamBuilder >> findSymbolForObject: anObject [
	anObject ifNil: [ ^ nil ].
	^ localScope findMappedSymbolRecursively: anObject
]

{ #category : #symbols }
SAsmStreamBuilder >> findSymbolForObject: anObject ifAbsent: aBlock [
	^ localScope findMappedSymbolRecursively: anObject ifAbsent: aBlock
]

{ #category : #symbols }
SAsmStreamBuilder >> findSymbolWithName: aName [
	^ self findSymbolWithName: aName ifAbsent: [self error: 'Failed to find symbol named: aName']
]

{ #category : #symbols }
SAsmStreamBuilder >> findSymbolWithName: aName ifAbsent: aBlock [
	^ localScope findNamedSymbolRecursively: aName ifAbsent: aBlock
]

{ #category : #initialization }
SAsmStreamBuilder >> initialize [
	super initialize.
	localScope := SAsmStreamBuilderLocalScope empty.
	sectionStack := Stack new.
]

{ #category : #symbols }
SAsmStreamBuilder >> label: aSymbol [
	^ self add: (SAsmLabel new symbol: aSymbol)
]

{ #category : #symbols }
SAsmStreamBuilder >> labelEnd: aSymbol [
	^ self add: (SAsmLabelEnd new symbol: aSymbol)
]

{ #category : #accessing }
SAsmStreamBuilder >> localScope [
	^ localScope
]

{ #category : #accessing }
SAsmStreamBuilder >> localVariableToGeneratedMap [
	^ localVariableToGeneratedMap ifNil: [ localVariableToGeneratedMap := IdentityDictionary new ].
]

{ #category : #symbols }
SAsmStreamBuilder >> newPrivateSymbol: name [
	^ SAsmSymbol new
		name: name;
		makePrivate;
		yourself
]

{ #category : #sections }
SAsmStreamBuilder >> popSection [
	| oldSection |
	oldSection := sectionStack pop.
	^ self startSection: oldSection name attributes: [ :sec | ]
]

{ #category : #sections }
SAsmStreamBuilder >> pushSection [
	sectionStack add: currentSection
]

{ #category : #sections }
SAsmStreamBuilder >> rodataSection [
	^ self startSection: #'.rodata' attributes: [ :section |
		section 
			loaded: true;
			executable: false;
			readable: true;
			writeable: false
	]
]

{ #category : #constants }
SAsmStreamBuilder >> sleb128: value [
	^ self addConstantExpressionValue: (SAsmConstantExpressionConstantIntegerSLEB128 new value: value)
]

{ #category : #constants }
SAsmStreamBuilder >> sleb128Size: value [
	^ (SAsmConstantExpressionConstantIntegerSLEB128 new value: value) size
]

{ #category : #sections }
SAsmStreamBuilder >> startSection: sectionName attributes: aBlock [
	self currentSectionName = sectionName ifTrue: [ ^ currentSection ].
	currentSection := SAsmSection new name: sectionName.
	aBlock value: currentSection.
	^ self add: currentSection
]

{ #category : #accessing }
SAsmStreamBuilder >> stream [
	^ stream
]

{ #category : #accessing }
SAsmStreamBuilder >> stream: anObject [
	stream := anObject
]

{ #category : #constants }
SAsmStreamBuilder >> string: aString [
	^ self addConstantExpressionValue: (SAsmConstantExpressionString new data: aString)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacAdd: left with: right into: result [
	^ self tacOperation: TacAdd result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacArithmeticShiftRight: left with: right into: result [
	^ self tacOperation: TacArithmeticShiftRight  result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacAtomicCompareAndSwap: left with: right into: result [
	^ self tacOperation: TacAtomicCompareAndSwap result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacAtomicFetchAndAdd: left with: right into: result [
	^ self tacOperation: TacAtomicFetchAndAdd result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacAtomicSwap: left with: right into: result [
	^ self tacOperation: TacAtomicSwap result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBitAnd: left with: right into: result [
	^ self tacOperation: TacBitAnd result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBitNot: value into: result [
	^ self tacOperation: TacBitNot result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBitOr: left with: right into: result [
	^ self tacOperation: TacBitOr result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBitXor: left with: right into: result [
	^ self tacOperation: TacBitXor result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBoolRegister [
	^ stream function newIntegerVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacBranch: condition true: trueDestination false: falseDestination [
	^ self add: (SAsmTacBranchInstruction new
		condition: condition asSAsmInstructionOperand;
		trueDestination: trueDestination asSAsmInstructionOperand;
		falseDestination: falseDestination asSAsmInstructionOperand;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacCall: called arguments: arguments into: result convention: convention [
	^ self add: (SAsmTacCallInstruction new
		called: called asSAsmInstructionOperand;
		arguments: (arguments collect: #asSAsmInstructionOperand);
		result: (result collect: #asSAsmInstructionOperand);
		calledConvention: convention;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacContextReplaceFunction: newFunction [
	^ self tacOperation: TacContextReplaceFunction value: newFunction
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacCopy: source to: destination size: size alignment: alignment [
	^ self add: (SAsmTacCopyInstruction new
		source: source asSAsmInstructionOperand;
		destination: destination asSAsmInstructionOperand;
		size: size asSAsmInstructionOperand;
		alignment: alignment;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDivide: left with: right into: result [
	^ self tacOperation: TacDivide result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDouble: value intoFloat: result [
	^ self tacOperation: TacDoubleToFloat result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDouble: value intoInt32: result [
	^ self tacOperation: TacDoubleToInt32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDouble: value intoInt64: result [
	^ self tacOperation: TacDoubleToInt64 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDouble: value intoUInt32: result [
	^ self tacOperation: TacDoubleToUInt32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDouble: value intoUInt64: result [
	^ self tacOperation: TacDoubleToUInt64 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacDoubleFloatRegister [
	^ stream function newDoubleFloatVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacEqual: left with: right into: result [
	^ self tacOperation: TacEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloat: value intoDouble: result [
	^ self tacOperation: TacFloatToDouble result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloat: value intoInt32: result [
	^ self tacOperation: TacFloatToInt32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloat: value intoInt64: result [
	^ self tacOperation: TacFloatToInt64 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloat: value intoUInt32: result [
	^ self tacOperation: TacFloatToUInt32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloat: value intoUInt64: result [
	^ self tacOperation: TacFloatToUInt64 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacFloatRegister [
	^ stream function newFloatVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacGreater: left with: right into: result [
	^ self tacOperation: TacGreater result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacGreaterOrEqual: left with: right into: result [
	^ self tacOperation: TacGreaterOrEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacInt32: value intoDouble: result [
	^ self tacOperation: TacInt32ToDouble result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacInt32: value intoFloat: result [
	^ self tacOperation: TacInt32ToFloat result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacInt64: value intoDouble: result [
	^ self tacOperation: TacInt64ToDouble result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacInt64: value intoFloat: result [
	^ self tacOperation: TacInt64ToFloat result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacIntRegister [
	^ stream function newIntegerVirtualRegister.
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacJump: destination [
	^ self add: (SAsmTacJumpInstruction new
		destination: destination;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLess: left with: right into: result [
	^ self tacOperation: TacLess result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLessOrEqual: left with: right into: result [
	^ self tacOperation: TacLessOrEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoad: pointer into: result [
	^ self tacOperation: TacLoad result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadDouble: pointer into: result [
	^ self tacOperation: TacLoadDouble result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadFloat: pointer into: result [
	^ self tacOperation: TacLoadFloat result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadLocalAddress: variable into: destination [
	^ self tacOperation: TacLoadLocalAddress result: destination value: variable
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadSignExtend16: pointer into: result [
	^ self tacOperation: TacLoadSignExtend16 result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadSignExtend32: pointer into: result [
	^ self tacOperation: TacLoadSignExtend32 result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadSignExtend8: pointer into: result [
	^ self tacOperation: TacLoadSignExtend8 result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadZeroExtend16: pointer into: result [
	^ self tacOperation: TacLoadZeroExtend16 result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadZeroExtend32: pointer into: result [
	^ self tacOperation: TacLoadZeroExtend32 result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLoadZeroExtend8: pointer into: result [
	^ self tacOperation: TacLoadZeroExtend8 result: result value: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLogicalShiftLeft: left with: right into: result [
	^ self tacOperation: TacLogicalShiftLeft result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacLogicalShiftRight: left with: right into: result [
	^ self tacOperation: TacLogicalShiftRight  result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacMove: source into: destination [
	self assert: destination asSAsmInstructionOperand isImmediate not.
	^ self tacOperation: TacMove result: destination value: source
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacMultiply: left with: right into: result [
	^ self tacOperation: TacMultiply result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacNegate: value into: result [
	^ self tacOperation: TacNegate result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacNotEqual: left with: right into: result [
	^ self tacOperation: TacNotEqual result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation [
	^ self tacOperation: operation result: nil left: nil right: nil
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation left: left right: right [
	^ self tacOperation: operation result: nil left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation result: result left: left right: right [
	^ self add: (SAsmTacInstruction new
		operation: operation;
		result: result asSAsmInstructionOperand;
		left: left asSAsmInstructionOperand;
		right: right asSAsmInstructionOperand;
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation result: result value: value [
	^ self tacOperation: operation result: result left: value right: nil
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacOperation: operation value: value [
	^ self tacOperation: operation result: nil left: value right: nil
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReinterpretFloat: value asIntegerInto: result [
	^ self tacOperation: TacReinterpretFloatAsInteger result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReinterpretInteger: value asFloatInto: result [
	^ self tacOperation: TacReinterpretIntegerAsFloat result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReturn: value [
	^ self tacOperation: TacReturn value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReturnFromFrame: newFrame exitPoint: exitPoint value: returnValue [
	^ self add: (SAsmTacReturnFromFrame new
		newFrame: newFrame asSAsmInstructionOperand;
		exitPoint: exitPoint asSAsmInstructionOperand;
		returnValues: (returnValue collect: #asSAsmInstructionOperand);
		yourself)
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacReturnVoid [
	^ self tacOperation: TacReturn
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSign: signed extend16: source into: result [
	^ signed ifTrue: [
		self tacSignExtend16: source into: result
	] ifFalse: [
		self tacZeroExtend16: source into: result
	]
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSign: signed extend32: source into: result [
	^ signed ifTrue: [
		self tacSignExtend32: source into: result
	] ifFalse: [
		self tacZeroExtend32: source into: result
	]
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSign: signed extend8: source into: result [
	^ signed ifTrue: [
		self tacSignExtend8: source into: result
	] ifFalse: [
		self tacZeroExtend8: source into: result
	]
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSignExtend16: value into: result [
	^ self tacOperation: TacSignExtend16 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSignExtend32: value into: result [
	^ self tacOperation: TacSignExtend32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSignExtend8: value into: result [
	^ self tacOperation: TacSignExtend8 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacStore: value into: pointer [
	^ self tacOperation: TacStore left: value right: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacStoreDouble: value into: pointer [
	^ self tacOperation: TacStoreDouble left: value right: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacStoreFloat: value into: pointer [
	^ self tacOperation: TacStoreFloat left: value right: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacStoreTruncate16: value into: pointer [
	^ self tacOperation: TacStoreTruncate16 left: value right: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacStoreTruncate32: value into: pointer [
	^ self tacOperation: TacStoreTruncate32 left: value right: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacStoreTruncate8: value into: pointer [
	^ self tacOperation: TacStoreTruncate8 left: value right: pointer
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacSubtract: left with: right into: result [
	^ self tacOperation: TacSubtract result: result left: left right: right
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacTruncate16: value into: result [
	^ self tacOperation: TacTruncate16 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacTruncate32: value into: result [
	^ self tacOperation: TacTruncate32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacTruncate8: value into: result [
	^ self tacOperation: TacTruncate8 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacUInt32: value intoDouble: result [
	^ self tacOperation: TacUInt32ToDouble result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacUInt32: value intoFloat: result [
	^ self tacOperation: TacUInt32ToFloat result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacUInt64: value intoDouble: result [
	^ self tacOperation: TacUInt64ToDouble result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacUInt64: value intoFloat: result [
	^ self tacOperation: TacUInt64ToFloat result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacZeroExtend16: value into: result [
	^ self tacOperation: TacZeroExtend16 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacZeroExtend32: value into: result [
	^ self tacOperation: TacZeroExtend32 result: result value: value
]

{ #category : #'three address code' }
SAsmStreamBuilder >> tacZeroExtend8: value into: result [
	^ self tacOperation: TacZeroExtend8 result: result value: value
]

{ #category : #accessing }
SAsmStreamBuilder >> target [
	^ stream target
]

{ #category : #sections }
SAsmStreamBuilder >> textSection [
	^ self startSection: #'.text' attributes: [ :section |
		section 
			loaded: true;
			executable: true;
			readable: true;
			writeable: false
	]
]

{ #category : #symbols }
SAsmStreamBuilder >> topLocalScope [
	^ localScope topScope
]

{ #category : #constants }
SAsmStreamBuilder >> uleb128: value [
	^ self addConstantExpressionValue: (SAsmConstantExpressionConstantIntegerULEB128 new value: value)
]

{ #category : #constants }
SAsmStreamBuilder >> uleb128Size: value [
	^ (SAsmConstantExpressionConstantIntegerULEB128 new value: value) size
]

{ #category : #symbols }
SAsmStreamBuilder >> withNewLocalScope: aBlock [
	| oldLocalScope |
	oldLocalScope := localScope.
	localScope  := SAsmStreamBuilderLocalScope parent: localScope.
	aBlock ensure: [ localScope := oldLocalScope ]
]

{ #category : #sections }
SAsmStreamBuilder >> withNewSection: aBlock [
	self pushSection.
	aBlock ensure: [ self popSection ]
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation [
	^ self x86: operation withOperands: #()
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation dst: operand1 src: operand2 [
	^ self x86: operation with: operand1 with: operand2
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation dst: operand1 src: operand2 with: operand3 [
	^ self x86: operation with: operand1 with: operand2 with: operand3
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation src: operand1 dst: operand2 [
	^ self x86: operation with: operand2 with: operand1
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation src: operand1 dst: operand2 with: operand3 [
	^ self x86: operation with: operand2 with: operand1 with: operand3
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation with: operand1 [
	^ self x86: operation withOperands: { operand1 asSAsmInstructionOperand }
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation with: operand1 with: operand2 [
	| sop1 sop2 |
	sop1 := operand1 asSAsmInstructionOperand.
	sop2 := operand2 asSAsmInstructionOperand.
	self assert: (sop1 isRegisterAddress not or: [ sop2 isRegisterAddress not ]).
	^ self x86: operation withOperands: { sop1 . sop2 }
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation with: operand1 with: operand2 with: operand3 [
	^ self x86: operation withOperands: { operand1 asSAsmInstructionOperand . operand2 asSAsmInstructionOperand . operand3 asSAsmInstructionOperand }
]

{ #category : #x86 }
SAsmStreamBuilder >> x86: operation withOperands: operands [
	^ self add: (
		SAsmInstruction new
			template: operation;
			arguments: operands;
			yourself)
]

{ #category : #constants }
SAsmStreamBuilder >> zeros: size [
	^ self add: (SAsmConstantZeros new
		size: size;
		yourself).
]
