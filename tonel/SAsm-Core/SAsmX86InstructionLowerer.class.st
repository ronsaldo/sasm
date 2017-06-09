Class {
	#name : #SAsmX86InstructionLowerer,
	#superclass : #SAsmInstructionLowerer,
	#instVars : [
		'stackSizeToRestoreBeforeReturn'
	],
	#pools : [
		'SAsmX86Constants',
		'SAsmX86Instructions'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> compiledMethodMetaData [
	self flag: 'Implement myself'.
	^ 0
]

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
SAsmX86InstructionLowerer >> emitArithmeticUnaryInto: result value: value integer: integerInstruction float: floatInstruction double: doubleInstruction [
	| resultPhysical |
	self assert: result isRegisterOrRegisterAddress.

	value ~= result ifTrue: [
		self moveValue: value toRegister: result.
	].
	resultPhysical := self virtualToPhysical: result.

	result isIntegerRegister ifTrue: [
		streamBuilder x86: integerInstruction with: resultPhysical
	].
	result isDoubleFloatRegister ifTrue: [
		self halt
	].
	result isFloatRegister ifTrue: [ 
		self halt
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

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> emitIntegerDivisionInto: result dividend: dividend divisor: divisor instruction: x86DivisionInstruction resultRegisterIndex: resultRegisterIndex activeRegisters: activeRegisters [
	| dividendPhysical divisorPhysical resultPhysical dividendUpperRegister dividendLowerRegister touchedRegisters toSpill resultRegister |
	self assert: result isRegisterOrRegisterAddress.

	target pointerSize = 4 ifTrue: [
		dividendUpperRegister := EDX.
		dividendLowerRegister := EAX.
		touchedRegisters := { EDX . EAX }
	] ifFalse: [ 
		dividendUpperRegister := RDX.
		dividendLowerRegister := RAX.
		touchedRegisters := { RDX . RAX }
	].

	toSpill := activeRegisters select: [:reg | touchedRegisters includes: reg register].
	self spillRegisters: toSpill.

	dividendPhysical := self virtualToPhysical: result.
	divisorPhysical := self virtualToPhysical: divisor.
	(touchedRegisters includes: divisorPhysical) ifTrue: [
		self assert: (toSpill includes: divisor).
		divisorPhysical := self virtualRegisterLocationToPhysicalLocation: divisor
	].

	"Move the dividend"
	dividendPhysical ~= dividendLowerRegister ifTrue: [ 
		streamBuilder x86: MOV dst: dividendLowerRegister src: dividendPhysical.
	].
	streamBuilder x86: XOR dst: dividendUpperRegister src: dividendUpperRegister.
	
	"Perform the division"
	streamBuilder x86: x86DivisionInstruction with: divisorPhysical.
	
	"Fetch the result"
	resultRegister := resultRegisterIndex = 1 ifTrue: [ dividendLowerRegister ] ifFalse: [ dividendUpperRegister ].
	resultPhysical := self virtualToPhysical: result.
	
	resultRegister ~= resultPhysical ifTrue: [
		streamBuilder x86: MOV dst: resultPhysical src: resultRegister
	].

	self unspillRegisters: toSpill.
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

{ #category : #casting }
SAsmX86InstructionLowerer >> emitMove: instruction withExtension: extensionInstruction size: operandSize [
	| value result |
	value := self virtualToPhysical: instruction left.
	result := self virtualToPhysical: instruction result.
	(value isRegisterAddress and: [ result isRegisterAddress ]) ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	(operandSize = 1 and: [target pointerSize ~= 8]) ifTrue: [
		(value isRegister and: [ value canBeValidByteRegisters not ]) ifTrue: [ 
			value := self movePhysical: value toScratchRegister: 0
		].
		streamBuilder x86: extensionInstruction dst: result src: value byte.
	] ifFalse: [
		streamBuilder x86: extensionInstruction dst: result src: (value withSize: operandSize).
	].

	
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitPrologueLoads [
	"Spill the arguments that are passed in registers"
	stackFrameLayout arguments do: [:arg |
		arg argumentPassingRegister ifNotNil: [
			self assert: arg virtualRegisters size = 1.
			(arg argumentPassingRegister ~= arg virtualRegisters first register) ifTrue: [
				arg argumentRegisterClass == #integer ifTrue: [
					streamBuilder x86: MOV dst: (self virtualRegisterLocationToPhysicalLocation: arg virtualRegisters first) src: arg argumentPassingRegister
				].
				arg argumentRegisterClass == #float ifTrue: [ 
					self halt
				].
			]
		]
	].

	"Unspill the arguments that are stored in registers during the function duration."
	stackFrameLayout arguments do: [:arg |
		arg virtualRegisters do: [ :virtualRegister |
			(arg argumentPassingRegister isNil or: [ arg argumentPassingRegister ~= virtualRegister register ]) ifTrue: [ 
				self unspillRegister: virtualRegister
			]
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
	(callingConvention hasSegmentedStack and: [false]) ifTrue: [
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
		nilPointer := 0."self nilGlobalSymbol".
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
			x86: PUSH with: nilPointerRegister; "Context object"
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
	stackSizeToRestoreBeforeReturn := nativeSizeToAllocate.

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
	registersToPreserve ifNotEmpty: [
		stackSizeToRestoreBeforeReturn ~= 0 ifTrue: [ 
			streamBuilder x86: ADD dst: target stackPointerRegister src: stackSizeToRestoreBeforeReturn
		].
	
		registersToPreserve reverseDo: [ :reg |
			streamBuilder x86: POP with: reg
		]
	].
	
	streamBuilder
		x86: MOV dst: target stackPointerRegister src: target framePointerRegister;
		x86: POP with: target framePointerRegister.
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> lowerConditional: condition branch: branch [
	condition operation acceptCondition: condition withBranch: branch asConditionWith: self 
]

{ #category : #memory }
SAsmX86InstructionLowerer >> movePhysical: physicalLocations toRegisters: registers [
	self flag: 'Optimize this by avoiding the stack'.
	physicalLocations do: [ :loc | streamBuilder x86: PUSH with: loc ].
	registers reverseDo: [ :loc | streamBuilder x86: POP with: loc ].
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> movePhysical: physicalValue toScratchRegister: scratchIndex [
	| scratchRegister |
	scratchRegister := self scratchRegister: scratchIndex for: physicalValue.
	scratchRegister isVectorRegister ifTrue: [
		self halt
	] ifFalse: [ 
		scratchRegister isIntegerRegister ifTrue: [ 
			streamBuilder x86: MOV dst: scratchRegister src: physicalValue.
			^ scratchRegister
		]
	].

	self error: 'Unsupported move type.'

]

{ #category : #'as yet unclassified' }
SAsmX86InstructionLowerer >> moveSpilledValue: value toIntegerRegister: register [
	value isVirtualRegister ifFalse: [ 
		^ streamBuilder x86: MOV dst: register src: (value copyWithStreamBuilder: streamBuilder)
	].

	^ streamBuilder x86: MOV dst: register src: (self virtualRegisterLocationToPhysicalLocation: value)
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> moveValue: value toRegister: register [
	| physical valuePhysical |
	physical := self virtualToPhysical: register.
	self assert: physical isRegisterOrRegisterAddress.
	value isImmediate ifTrue: [
		^ streamBuilder x86: MOV dst: physical src: (value copyWithStreamBuilder: streamBuilder)
	].

	valuePhysical := self virtualToPhysical: value.
	valuePhysical == physical ifTrue: [ ^ self ].
	(valuePhysical isRegisterAddress and: [ physical isRegisterAddress ]) ifTrue: [
		valuePhysical := self movePhysical: valuePhysical toScratchRegister: 0
	].

	physical isVectorRegister ifTrue: [ 
		self halt
	] ifFalse: [ 
		^ streamBuilder x86: MOV dst: physical src: valuePhysical
	]
	
]

{ #category : #testing }
SAsmX86InstructionLowerer >> needsToSpillThreeAddressInstruction: tacInstruction [
	^ tacInstruction operation isIntegerDivision or: [ tacInstruction operation isIntegerRemainder ]
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
	| variable |
	virtualRegister isVariable ifTrue: [
		variable := stackFrameLayout importVariable: virtualRegister.
		^ (target framePointerRegister asX86PointerOfSize: virtualRegister size) + (variable offset)
	].
	^ (target framePointerRegister asX86PointerOfSize: virtualRegister size) + (virtualRegister spillLocation offset + virtualRegister variableOffset)
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> virtualToPhysical: virtualRegister pointerOfSize: pointerSize scratchIndex: scratchIndex [
	| physicalRegister |
	virtualRegister isVariable ifTrue: [
		physicalRegister := self scratchRegister: scratchIndex for: target framePointerRegister.
		self halt.
	].

	physicalRegister := self virtualToPhysical: virtualRegister.
	physicalRegister isRegisterAddress ifFalse: [ ^ physicalRegister asX86PointerOfSize: pointerSize withBuilder: streamBuilder].
	
	^ (self movePhysical: physicalRegister toScratchRegister: scratchIndex) asX86PointerOfSize: pointerSize
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> virtualToPhysical: virtualRegister pointerValueScratchIndex: scratchIndex [
	| physicalRegister variable |
	virtualRegister isVariable ifTrue: [
		variable := stackFrameLayout importVariable: virtualRegister.
		physicalRegister := self scratchRegister: scratchIndex for: target framePointerRegister.
		streamBuilder x86: LEA dst: physicalRegister src: (target framePointerRegister asX86PointerOfSize: target pointerSize) + variable offset.
		^ physicalRegister
	].

	physicalRegister := self virtualToPhysical: virtualRegister.
	physicalRegister isRegisterAddress ifTrue: [
		^ self movePhysical: physicalRegister toScratchRegister: scratchIndex
	].
	
	^ physicalRegister
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacAdd: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: ADD float: ADD double: ADD
]

{ #category : #'atomic operations' }
SAsmX86InstructionLowerer >> visitTacAtomicCompareAndSwap: instruction [
	self halt
]

{ #category : #'atomic operations' }
SAsmX86InstructionLowerer >> visitTacAtomicFetchAndAdd: instruction [
	| result variable value variablePhysical valuePhysical |
	result := instruction result.
	variable := instruction left.
	value := instruction right.
	self assert: result isRegisterOrRegisterAddress.
	
	value ~= result ifTrue: [
		self moveValue: value toRegister: result.
	].

	self flag: 'Use the correct pointer size'.
	variablePhysical := self virtualToPhysical: variable pointerOfSize: 4 scratchIndex: 0.
	valuePhysical := self virtualToPhysical: result.
	
	self assert: variablePhysical isRegisterAddress.
	valuePhysical isRegister ifFalse: [ 
		self halt.
	].
	
	streamBuilder x86: LOCK;
		x86: XADD dst: variablePhysical src: valuePhysical.
]

{ #category : #'atomic operations' }
SAsmX86InstructionLowerer >> visitTacAtomicSwap: instruction [
	| result variable value variablePhysical valuePhysical |
	result := instruction result.
	variable := instruction left.
	value := instruction right.
	self assert: result isRegisterOrRegisterAddress.
	
	value ~= result ifTrue: [
		self moveValue: value toRegister: result.
	].

	self flag: 'Use the correct pointer size'.
	variablePhysical := self virtualToPhysical: variable pointerOfSize: 4 scratchIndex: 0.
	valuePhysical := self virtualToPhysical: result.
	
	self assert: variablePhysical isRegisterAddress.
	valuePhysical isRegister ifFalse: [ 
		self halt.
	].
	
	streamBuilder x86: LOCK;
		x86: XCHG dst: variablePhysical src: valuePhysical.
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
		conditionRegister := self movePhysical: conditionRegister toScratchRegister: 0.
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
	| calledFunction calledConvention calledRegisters registersToSpill stackCleanUpSize stackElementSize registerArguments stackArguments remainingIntegerRegisters remainingFloatRegisters integerRegisterIndex floatRegisterIndex resultPhysical |

	calledConvention := callInstruction calledConvention.
	calledRegisters := calledConvention calledRegisters.
	registersToSpill := callInstruction activeRegisters select: [ :virtualRegister |
		virtualRegister isVirtualRegister and:
		[ virtualRegister register isNotNil and:
		[ (virtualRegister lastUsage ~= callInstruction index or:
			[ (calledConvention integerArgumentRegisters includes: virtualRegister register) or:
			  [(calledConvention floatArgumentRegisters includes: virtualRegister register)]]) and: 
		[ calledRegisters includes: virtualRegister register ] ] ]
	].

	self spillRegisters: registersToSpill.
	
	registerArguments := OrderedCollection new.
	stackArguments := OrderedCollection new.
	
	remainingIntegerRegisters := calledConvention integerArgumentRegisters size.
	remainingFloatRegisters := calledConvention floatArgumentRegisters size.
	
	callInstruction arguments do: [ :arg |
		(arg isIntegerRegister or: [ arg isImmediate ]) ifTrue: [
			remainingIntegerRegisters > 0 ifTrue: [
				registerArguments add: arg.
				remainingIntegerRegisters := remainingIntegerRegisters - 1
			] ifFalse: [ 
				stackArguments add: arg.
			]
		] ifFalse: [
			self halt.
		]
	].

	"Pass arguments in the stack."	
	stackCleanUpSize := 0.
	stackElementSize := target pointerSize.
	stackArguments reverseDo: [ :arg |
		streamBuilder x86: PUSH with: (self virtualToPhysical: arg).
		stackCleanUpSize := stackCleanUpSize + ((arg isImmediate ifTrue: [target pointerSize] ifFalse: [arg size]) max: stackElementSize)
	].
	
	"Pass some arguments in registers"
	integerRegisterIndex := 1.
	floatRegisterIndex := 1.
	remainingFloatRegisters := calledConvention floatArgumentRegisters size.

	registerArguments do: [ :arg |
		(arg isIntegerRegister or: [ arg isImmediate ]) ifTrue: [
			self moveSpilledValue: arg toIntegerRegister: (calledConvention integerArgumentRegisters at: integerRegisterIndex)
		] ifFalse: [
			(arg isFloatRegister or: [ arg isDoubleFloatRegister ]) ifTrue: [
				self moveSpilledValue: arg toFloatRegister: (calledConvention floatArgumentRegisters at: floatRegisterIndex)
			] ifFalse: [
				self error: 'Unsupported register argument type.'
			]
		]
	].

	calledFunction := self virtualToPhysical: callInstruction called.
	streamBuilder
		x86: CALL with: calledFunction.
	calledConvention isStackCleanedByCaller ifTrue: [ 
		streamBuilder
			x86: ADD dst: target stackPointerRegister src: stackCleanUpSize.
	].
	self unspillRegisters: registersToSpill.
	
	callInstruction result doWithIndex: [ :result :index |
		resultPhysical := self virtualToPhysical: result.
		result isIntegerRegister ifTrue: [
			streamBuilder x86: MOV dst: resultPhysical src: (index = 1 ifTrue: [calledConvention resultIntRegister] ifFalse: [ calledConvention resultInt2Register ])
		] ifFalse: [
			self halt
		]
	]
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacCopyInstruction32: instruction [
	| source destination size requiredRegisters registersToSpill bytes words |
	source := self virtualToPhysical: instruction source pointerValueScratchIndex: 0.
	destination := self virtualToPhysical: instruction destination pointerValueScratchIndex: 1.
	size := self virtualToPhysical: instruction size.
	
	"Spill some registers"
	requiredRegisters := { ESI . EDI . ECX }.
	registersToSpill := instruction activeRegisters select: [ :reg | requiredRegisters includes: reg register ].
	self spillRegisters: registersToSpill.
	
	"Move the arguments"
	size isImmediate ifTrue: [ 
		self movePhysical: {source . destination } toRegisters: { ESI . EDI }.
		streamBuilder x86: CLD.
		bytes := size value & 3.
		bytes > 0 ifTrue: [
			streamBuilder
				x86: MOV dst: ECX src: bytes;
				x86: REP;
				x86: MOVS_B
		].
	
		words := size value // 4.
		words > 0 ifTrue: [ 
			streamBuilder
				x86: MOV dst: ECX src: words;
				x86: REP;
				x86: MOVS_D
		].
	] ifFalse: [ 
		self movePhysical: {source . destination . size } toRegisters: requiredRegisters.
		self halt.
	].
		
	"Unspill the registers"
	self unspillRegisters: registersToSpill.
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacCopyInstruction64: instruction [
	self halt
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacCopyInstruction: instruction [
	target pointerSize = 4 ifTrue: [ self visitTacCopyInstruction32: instruction ]
	ifFalse: [ self visitTacCopyInstruction64: instruction ]
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacDivide: instruction [
	self emitIntegerDivisionInto: instruction result dividend: instruction left divisor: instruction right instruction: IDIV resultRegisterIndex: 1 activeRegisters: instruction activeRegisters
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
		pointer := (self movePhysical: pointer toScratchRegister: 0) asX86PointerOfSize: target pointerSize
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

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacNegate: instruction [
	^ self emitArithmeticUnaryInto: instruction result value: instruction left integer: NEG float: NEG double: NEG
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

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacRemainder: instruction [
	self emitIntegerDivisionInto: instruction result dividend: instruction left divisor: instruction right instruction: IDIV resultRegisterIndex: 2 activeRegisters: instruction activeRegisters
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturn: returnInstruction [
	self returnValue: returnInstruction left valueHigh: returnInstruction right.
	self leaveFrame.
	
	function callingConvention isStackCleanedByCaller ifTrue: [ 
		streamBuilder x86: RET
	] ifFalse: [
		streamBuilder x86: RET with: stackFrameLayout argumentsSize
	]
	
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacSignExtend16: instruction [
	self emitMove: instruction withExtension: MOVSX size: 2
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacSignExtend32: instruction [
	target pointerSize = 4 ifTrue: [ ^ self visitTacMove: instruction ].
	self emitMove: instruction withExtension: MOVSXD size: 4
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacSignExtend8: instruction [
	self emitMove: instruction withExtension: MOVSX size: 1
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStore: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left.
	pointer := (self virtualToPhysical: instruction right) asX86PointerOfSize: target pointerSize.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer src: value
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate16: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left.
	pointer := (self virtualToPhysical: instruction right) asX86PointerOfSize: target pointerSize.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer word src: value
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate32: instruction [
	target pointerSize = 4 ifTrue: [ ^ self visitTacStore: instruction ].
	self halt.
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate8: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left.
	pointer := (self virtualToPhysical: instruction right) asX86PointerOfSize: target pointerSize.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer byte src: value
	
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacSubtract: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: SUB float: SUB double: SUB
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacUDivide: instruction [
	self emitIntegerDivisionInto: instruction result dividend: instruction left divisor: instruction right instruction: DIV resultRegisterIndex: 1 activeRegisters: instruction activeRegisters
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacURemainder: instruction [
	self emitIntegerDivisionInto: instruction result dividend: instruction left divisor: instruction right instruction: DIV resultRegisterIndex: 2 activeRegisters: instruction activeRegisters
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacZeroExtend16: instruction [
	self emitMove: instruction withExtension: MOVZX size: 2
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacZeroExtend32: instruction [
	target pointerSize = 4 ifTrue: [ ^ self visitTacMove: instruction ].
	self emitMove: instruction withExtension: MOV size: 4
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacZeroExtend8: instruction [
	self emitMove: instruction withExtension: MOVZX size: 1
]
