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
		rightRegister := self moveMemory: rightPhysical toScratchIndex: 0
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
SAsmX86InstructionLowerer >> emitPrologueLoads [
	self flag: 'TODO'
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
		stackCheckedEntry := streamBuilder newLabel: #stackCheckedEntry.
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
			
			addLabel: stackCheckedEntry.
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

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> moveMemory: rightPhysical toScratchIndex: scratchIndex [
	self halt
]

{ #category : #'abstract instruction generation' }
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

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacAdd: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: ADD float: ADD double: ADD
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacCall: callInstruction [
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacMove: moveInstruction [
	| result value |
	result := moveInstruction result.
	value := moveInstruction value.
	^ self moveValue: value toRegister: result
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturn: returnInstruction [
	self returnValue: returnInstruction left valueHigh: returnInstruction right.
	self leaveFrame.
	streamBuilder x86: RET
]
