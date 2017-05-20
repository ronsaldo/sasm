Class {
	#name : #SAsmX86InstructionLowerer,
	#superclass : #SAsmInstructionLowerer,
	#pools : [
		'SAsmX86Constants',
		'SAsmX86Instructions'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitArithmeticInto: result left: left right: right integer: integerInstruction float: floatInstruction double: doubleInstruction [
	| resultPhysical rightPhysical rightRegister |
	self assert: result isRegisterOrRegisterAddress.

	left ~= result ifTrue: [
		self moveValue: left toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	rightPhysical := self virtualToPhysical: right.
	rightRegister := rightPhysical.
	(resultPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 0
	].

	result isIntegerRegister ifTrue: [
		streamBuilder x86: integerInstruction with: resultPhysical with: rightRegister.
	].
	result isDoubleFloatRegister ifTrue: [
		streamBuilder x86: floatInstruction with: resultPhysical with: rightRegister.
	].
	result isFloatRegister ifTrue: [ 
		streamBuilder x86: doubleInstruction with: resultPhysical with: rightRegister.
	]

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitBitwiseInto: result left: left right: right integer: integerInstruction float: floatInstruction double: doubleInstruction [
	| resultPhysical rightPhysical rightRegister |
	self assert: result isRegisterOrRegisterAddress.

	left ~= result ifTrue: [
		self moveValue: left toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	rightPhysical := self virtualToPhysical: right.
	rightRegister := rightPhysical.
	(resultPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 0
	].

	result isIntegerRegister ifTrue: [
		streamBuilder x86: integerInstruction with: resultPhysical with: rightRegister.
	].
	result isDoubleFloatRegister ifTrue: [
		streamBuilder x86: floatInstruction with: resultPhysical with: rightRegister.
	].
	result isFloatRegister ifTrue: [ 
		streamBuilder x86: doubleInstruction with: resultPhysical with: rightRegister.
	]

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparison: instruction left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination [
	| rightPhysical rightRegister leftPhysical falseLabel trueLabel |
	leftPhysical := self virtualToPhysical: left.
	rightPhysical := self virtualToPhysical: right.
	
	rightRegister := rightPhysical.
	(leftPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 0
	].

	left isIntegerRegister ifTrue: [
		streamBuilder x86: CMP with: leftPhysical with: rightRegister.
	].
	
	left isDoubleFloatRegister ifTrue: [
		self halt.
		"streamBuilder x86: floatInstruction with: resultPhysical with: rightRegister."
	].
	left isFloatRegister ifTrue: [ 
		self halt.
		"streamBuilder x86: doubleInstruction with: resultPhysical with: rightRegister."
	].

	falseLabel := streamBuilder findSymbolForObject: falseDestination.
	trueLabel := streamBuilder findSymbolForObject: trueDestination.
	
	instruction trueDestination index = (instruction index + 1) ifTrue: [ 
		"Fallthrough to the true destination"
		streamBuilder
			x86: branchFalse with: falseLabel;
			x86: JMP with: trueLabel.
	] ifFalse: [ 
		"Fallthrough to the false destination"
		streamBuilder
			x86: branchTrue with: trueLabel;
			x86: JMP with: falseLabel.
	]
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparisonInto: result left: left right: right branchTrue: branchTrue branchFalse: branchFalse [
	| resultPhysical rightPhysical rightRegister leftPhysical cmpResult |
	self assert: result isRegisterOrRegisterAddress.

	leftPhysical := self virtualToPhysical: left.
	rightPhysical := self virtualToPhysical: right.

	rightRegister := rightPhysical.
	(leftPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 0
	].

	resultPhysical := self virtualToPhysical: result.
	streamBuilder x86: MOV dst: resultPhysical src: 1.
	
	left isIntegerRegister ifTrue: [
		streamBuilder x86: CMP with: leftPhysical with: rightRegister.
	].
	
	left isDoubleFloatRegister ifTrue: [
		self halt.
		"streamBuilder x86: floatInstruction with: resultPhysical with: rightRegister."
	].
	left isFloatRegister ifTrue: [ 
		self halt.
		"streamBuilder x86: doubleInstruction with: resultPhysical with: rightRegister."
	].

	cmpResult := streamBuilder newPrivateSymbol: #cmpResult.
	streamBuilder
		x86: branchTrue with: cmpResult;
		x86: MOV dst: resultPhysical src: 0;
		label: cmpResult

]

{ #category : #memory }
SAsmX86InstructionLowerer >> emitLoad: instruction withExtension: extensionInstruction pointerSize: pointerSize [
	| value pointer resultTemp |
	value := self virtualToPhysical: instruction result.
	pointer := self virtualToPhysical: instruction left pointerOfSize: pointerSize scratchIndex: 0.
	
	resultTemp := value.
	value isRegisterAddress ifTrue: [
		resultTemp := self scratchRegister: 1 for: value.
	].

	streamBuilder x86: extensionInstruction dst: resultTemp src: pointer.
	resultTemp ~= value ifTrue: [  streamBuilder x86: MOV dst: value src: resultTemp ]
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitPrologueLoads [
	self flag: 'TODO: Support parameters passed in arguments.'.
	stackFrameLayout arguments doWithIndex: [:arg :index |
		arg virtualRegisters do: [ :virtualRegister |
			self unspillRegister: virtualRegister
		]
	].
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> enterFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self enterFramefullMethod
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> enterFramefullMethod [
	"Compute some sizes."
	| pointerSize dynamicObjectSize callingConvention totalFrameSize nativeSizeToAllocate argumentDescriptor scratchRegister stackSizeRequirement stackCheckedEntry stackLimitTrap nilPointerRegister nilPointer |
	pointerSize := target pointerSize.
	callingConvention := function callingConvention.
	
	dynamicObjectSize := stackFrameLayout dynamicRootCount * pointerSize.
	totalFrameSize := stackFrameLayout size + dynamicObjectSize alignedTo: callingConvention stackAlignment.
	nativeSizeToAllocate := totalFrameSize - dynamicObjectSize - stackFrameLayout reservedLocalsSpace.
	argumentDescriptor := self computeArgumentDescriptor.
	
	scratchRegister := callingConvention scratchRegisters first.
	
	"Compute the stack size requirements."
	callingConvention hasSegmentedStack ifTrue: [
		stackSizeRequirement := totalFrameSize + maxCallStackSize + (pointerSize * StackSwitchPointerRequired) - ( "Return pointer" pointerSize * 1).
		stackCheckedEntry := streamBuilder newPrivateSymbol: #stackCheckedEntry.
		stackLimitTrap := self stackLimitTrapSymbol.
		streamBuilder
			"Check if we have hitten the stack limit."
			x86: MOV with: scratchRegister with: self stackPointerRegister;
			x86: AND with: scratchRegister with: StackPageSize - 1;
			x86: CMP with: scratchRegister with: stackSizeRequirement;
			x86: JA with: stackCheckedEntry;
			
			"We have hit the stack limit, mov the argument description to EAX"
			x86: MOV with: scratchRegister with: argumentDescriptor;
			x86: CALL with: stackLimitTrap;
			
			label: stackCheckedEntry.
	].
	
	streamBuilder
		x86: PUSH with: target framePointerRegister;
		x86: MOV dst: target framePointerRegister src: target stackPointerRegister.
		
	"Fetch the nil pointer"
	nilPointerRegister := nil.
	(stackFrameLayout dynamicRootCount ~= 0 or: [callingConvention hasContextMetadata]) ifTrue: [
		nilPointer := self nilGlobalSymbol.
		nilPointerRegister := scratchRegister.
		streamBuilder
			x86: MOV with: nilPointerRegister with: nilPointer.
	].

	"Context meta data"
	callingConvention hasContextMetadata ifTrue: [
		self assert: totalFrameSize <= 16rFFFF.
		self assert: stackFrameLayout dynamicRootCount <= 16rfff.
		
		streamBuilder
			x86: PUSH with: (self compiledMethodMetaData);
			x86: PUSH with: nilPointerRegister;
			x86: PUSH with: argumentDescriptor;
			x86: PUSH with: ((totalFrameSize << 16) | (stackFrameLayout dynamicRootCount) | (registersToPreserve size << 12))
	].

	"Initialize the object variables with nil."
	1 to: stackFrameLayout dynamicRootCount do: [ :i |
		streamBuilder x86: PUSH with: nilPointerRegister
	].

	"Store the registers that have to be preserved."
	registersToPreserve do: [ :register |
		streamBuilder x86: PUSH with: register
	].

	"Allocate the native size."
	nativeSizeToAllocate ~= 0 ifTrue: [
		streamBuilder x86: SUB with: target stackPointerRegister with: nativeSizeToAllocate.
	].

	"Emit the argument loads."
	self emitPrologueLoads
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> leaveFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self leaveFramefullMethod.
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> leaveFramefullMethod [
	streamBuilder
		x86: MOV dst: target stackPointerRegister src: target framePointerRegister;
		x86: POP with: target framePointerRegister.
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> lowerConditional: condition branch: branch [
	condition operation acceptCondition: condition withBranch: branch asConditionWith: self 
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> movePhysical: physicalValue toScratchRegister: scratchIndex [
	| scratchRegister |
	scratchRegister := self scratchRegister: scratchIndex for: physicalValue.
	scratchRegister isVectorRegister ifTrue: [ 
	] ifFalse: [ 
		scratchRegister isIntegerRegister ifTrue: [ 
			^ streamBuilder x86: MOV dst: scratchRegister src: physicalValue
		]
	].

	self error: 'Unsupported move type.'

]

{ #category : #spilling }
SAsmX86InstructionLowerer >> moveValue: value toRegister: register [
	| physical valuePhysical |
	physical := self virtualToPhysical: register.
	self assert: physical isRegisterOrRegisterAddress.
	value isImmediate ifTrue: [
		^ streamBuilder x86: MOV dst: physical src: value
	].

	valuePhysical := self virtualToPhysical: value.
	valuePhysical == physical ifTrue: [ ^ self ].
	(valuePhysical isRegisterAddress and: [ register isRegisterAddress ]) ifTrue: [
		"TODO: Move temporarily to a scratch register"
		self halt.
	] ifFalse: [ 
		^ streamBuilder x86: MOV dst: physical src: valuePhysical
	]
	
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> returnValue: value [
	value ifNil: [ ^ self ].
	self moveValue: value toRegister: function callingConvention resultIntRegister secondRegister: function callingConvention resultInt2Register
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> returnValue: value valueHigh: valueHigh [
	value ifNil: [ ^ self ].
	self
		moveValue: value toRegister: function callingConvention resultIntRegister.
	valueHigh ifNotNil: [ 
		self moveValue: value toRegister: function callingConvention resultInt2Register
	]
	
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> scratchRegister: scratchIndex for: value [
	^ (scratchRegisterClases at: value registerClass)  at: scratchIndex + 1
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> spillRegister: virtualRegister [
	virtualRegister isVirtualRegister ifFalse: [ ^ self ].
	virtualRegister register ifNil: [ ^ self ].
	
	virtualRegister isVectorRegister ifTrue: [ 
		self halt
	] ifFalse: [ 
		virtualRegister isIntegerRegister ifTrue: [ 
			^ streamBuilder x86: MOV dst: (self virtualRegisterLocationToPhysicalLocation: virtualRegister) src: virtualRegister register
		].
		virtualRegister isFloatRegister  ifTrue: [ 
			self halt.
		].
		virtualRegister isDoubleFloatRegister  ifTrue: [ 
			self halt.
		].
	].

	self error: 'Unsupported virtual register type.'
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> spillRegisters: registers [
	registers do: [ :reg | self spillRegister: reg ].
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> unspillRegister: virtualRegister [
	virtualRegister isVirtualRegister ifFalse: [ ^ self ].
	virtualRegister register ifNil: [ ^ self ].
	
	virtualRegister isVectorRegister ifTrue: [ 
		self halt
	] ifFalse: [ 
		virtualRegister isIntegerRegister ifTrue: [ 
			^ streamBuilder x86: MOV dst: virtualRegister register src: (self virtualRegisterLocationToPhysicalLocation: virtualRegister)
		].
		virtualRegister isFloatRegister  ifTrue: [ 
			self halt.
		].
		virtualRegister isDoubleFloatRegister  ifTrue: [ 
			self halt.
		].
	].

	self error: 'Unsupported virtual register type.'
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> unspillRegisters: registers [
	registers do: [ :reg | self unspillRegister: reg ].
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualRegisterLocationToPhysicalLocation: virtualRegister [
	^ (target framePointerRegister asPointerOfSize: virtualRegister size) + (virtualRegister spillLocation offset + virtualRegister variableOffset)
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> virtualToPhysical: virtualRegister pointerOfSize: pointerSize scratchIndex: scratchIndex [
	| physicalRegister |
	physicalRegister := self virtualToPhysical: virtualRegister.
	physicalRegister isRegisterAddress ifFalse: [ ^ physicalRegister asPointerOfSize: pointerSize ].
	
	^ (self movePhysical: physicalRegister toScratchRegister: scratchIndex) asPointerOfSize: pointerSize
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacAdd: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: ADD float: ADD double: ADD
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacBitAnd: instruction [
	^ self emitBitwiseInto: instruction result left: instruction left right: instruction right 
			integer: AND float: AND double: AND
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacBranchInstruction: branch [
	| conditionRegister trueDestination falseDestination |
	conditionRegister := self virtualToPhysical: branch condition.
	conditionRegister isRegisterAddress ifTrue: [
		conditionRegister := self movePhysical: conditionRegister toScratchRegister: 1.
	].

	trueDestination := streamBuilder findSymbolForObject: branch trueDestination.
	falseDestination := streamBuilder findSymbolForObject: branch falseDestination.
	
	streamBuilder
		x86: TEST with: conditionRegister with: conditionRegister;
		x86: JZ with: falseDestination;
		x86: JMP with: trueDestination.
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacCallInstruction: callInstruction [
	| calledFunction calledConvention calledRegisters registersToSpill stackCleanUpSize stackElementSize |
	self flag: 'TODO: Support the different calling conventions'.
	
	calledConvention := callInstruction calledConvention.
	calledRegisters := calledConvention calledRegisters.
	registersToSpill := callInstruction activeRegisters select: [ :virtualRegister |
		virtualRegister isVirtualRegister and:
		[ virtualRegister register isNotNil and:
		[ virtualRegister lastUsage ~= callInstruction index and: 
		[ calledRegisters includes: virtualRegister register ] ] ]
	].

	self spillRegisters: registersToSpill.
	stackCleanUpSize := 0.
	stackElementSize := target pointerSize.
	callInstruction arguments reverseDo: [ :arg |
		streamBuilder x86: PUSH with: (self virtualToPhysical: arg).
		stackCleanUpSize := arg size max: stackElementSize
	].
	
	calledFunction := self virtualToPhysical: callInstruction called.
	streamBuilder
		x86: CALL with: calledFunction.
	calledConvention isStackCleanedByCaller ifTrue: [ 
		streamBuilder
			x86: ADD dst: target stackPointerRegister src: stackCleanUpSize.
	].
	self unspillRegisters: registersToSpill.
	
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacEqual: instruction [
	^ self emitComparisonInto: instruction result left: instruction left right: instruction right 
			branchTrue: JE branchFalse: JNE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JE destination: branch trueDestination branchFalse: JNE destination: branch falseDestination
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacGreater: instruction [
	^ self emitComparisonInto: instruction result left: instruction left right: instruction right 
			branchTrue: JG branchFalse: JLE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacGreater: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JG destination: branch trueDestination branchFalse: JLE destination: branch falseDestination
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacGreaterOrEqual: instruction [
	^ self emitComparisonInto: instruction result left: instruction left right: instruction right 
			branchTrue: JGE branchFalse: JL
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacGreaterOrEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JGE destination: branch trueDestination branchFalse: JL destination: branch falseDestination
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacJumpInstruction: branch [
	| destination |
	destination := streamBuilder findSymbolForObject: branch destination.
	
	streamBuilder
		x86: JMP with: destination.
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacLess: instruction [
	^ self emitComparisonInto: instruction result left: instruction left right: instruction right 
			branchTrue: JL branchFalse: JGE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacLess: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JL destination: branch trueDestination branchFalse: JGE destination: branch falseDestination
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacLessOrEqual: instruction [
	^ self emitComparisonInto: instruction result left: instruction left right: instruction right 
			branchTrue: JLE branchFalse: JE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacLessOrEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JLE destination: branch trueDestination branchFalse: JG destination: branch falseDestination
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoad: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction result.
	pointer := self virtualToPhysical: instruction left pointerOfSize: target pointerSize scratchIndex: 0.
	(value isRegisterAddress and: [ pointer isRegisterAddress ]) ifTrue: [ 
		pointer := (self movePhysical: pointer toScratchRegister: 0) asPointerOfSize: target pointerSize
	].

	self assert: value isRegisterOrRegisterAddressWord.
	streamBuilder x86: MOV dst: value src: pointer
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadSignExtend16: instruction [
	self emitLoad: instruction withExtension: MOVSX pointerSize: 2
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadSignExtend32: instruction [
	target pointerSize = 4 ifTrue: [ ^ self visitTacLoad: instruction ].
	self emitLoad: instruction withExtension: MOVSXD pointerSize: 4
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadSignExtend8: instruction [
	self emitLoad: instruction withExtension: MOVSX pointerSize: 1
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadZeroExtend16: instruction [
	self emitLoad: instruction withExtension: MOVZX pointerSize: 2
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadZeroExtend32: instruction [
	target pointerSize = 4 ifTrue: [ ^ self visitTacLoad: instruction ].
	self emitLoad: instruction withExtension: MOV pointerSize: 4
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadZeroExtend8: instruction [
	self emitLoad: instruction withExtension: MOVZX pointerSize: 1
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacMove: moveInstruction [
	| result value |
	result := moveInstruction result.
	value := moveInstruction value.
	^ self moveValue: value toRegister: result
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacMultiply: instruction [
	| resultPhysical rightPhysical resultTemp |
	self assert: instruction result isRegisterOrRegisterAddress.

	instruction left ~= instruction result ifTrue: [
		self moveValue: instruction left toRegister: instruction result.
	].

	resultPhysical := self virtualToPhysical: instruction result.
	rightPhysical := self virtualToPhysical: instruction right.
	
	resultTemp := resultPhysical.
	resultPhysical isRegisterAddress ifTrue: [
		resultTemp := self movePhysical: resultPhysical toScratchRegister: 0.
	].

	rightPhysical isImmediate ifTrue: [ 
		streamBuilder x86: IMUL with: resultTemp with: resultTemp with: rightPhysical
	] ifFalse: [
		streamBuilder x86: IMUL with: resultTemp with: rightPhysical
	].
	
	resultPhysical ~= resultTemp ifTrue: [ 
		streamBuilder x86: MOV dst: resultPhysical src: resultTemp
	].

]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacNotEqual: instruction [
	^ self emitComparisonInto: instruction result left: instruction left right: instruction right 
			branchTrue: JNE branchFalse: JE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacNotEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JNE destination: branch trueDestination branchFalse: JE destination: branch falseDestination
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturn: returnInstruction [
	self returnValue: returnInstruction left valueHigh: returnInstruction right.
	self leaveFrame.
	streamBuilder x86: RET
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStore: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left.
	pointer := (self virtualToPhysical: instruction right) asPointerOfSize: target pointerSize.
	value isRegisterAddress ifTrue: [ 
		self halt.
	] ifFalse: [ 
		self assert: value isRegister.
		streamBuilder x86: MOV dst: pointer src: value
	]
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate32: instruction [
	target pointerSize = 4 ifTrue: [ ^ self visitTacStore: instruction ].
	self halt.
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacSubtract: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: SUB float: SUB double: SUB
]
