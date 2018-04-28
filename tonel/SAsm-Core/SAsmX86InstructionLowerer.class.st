Class {
	#name : #SAsmX86InstructionLowerer,
	#superclass : #SAsmInstructionLowerer,
	#instVars : [
		'stackSizeToRestoreBeforeReturn',
		'gotBaseRegister',
		'contextMetadataOffset'
	],
	#pools : [
		'SAsmX86Constants',
		'SAsmX86Instructions'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> alignmentOfValuePushedToTheStack: value calledConvention: calledConvention [
	^ (value isImmediate ifTrue: [target pointerSize] ifFalse: [value alignment]) max: calledConvention stackArgumentAlignment
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> compiledMethodMetaData [
	^ function contextMetaData asSAsmInstructionOperand copyWithStreamBuilder: streamBuilder
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> emitArithmeticInto: result left: left right: right float: floatInstruction double: doubleInstruction [
	| resultPhysical rightPhysical rightRegister |
	self assert: result isRegisterOrRegisterAddress.

	left ~= result ifTrue: [
		self moveValue: left toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	rightPhysical := self virtualToPhysical: right scratchRegisterIndex: 0.
	rightRegister := rightPhysical.
	(resultPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 0
	].

	result isDoubleFloatRegister ifTrue: [
		streamBuilder x86: doubleInstruction with: resultPhysical with: rightRegister.
	].
	result isFloatRegister ifTrue: [ 
		streamBuilder x86: floatInstruction with: resultPhysical with: rightRegister.
	]

]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> emitArithmeticInto: result left: left right: right integer: integerInstruction [
	| resultPhysical rightPhysical rightRegister |
	self assert: result isRegisterOrRegisterAddress.

	left ~= result ifTrue: [
		self moveValue: left toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	rightPhysical := self virtualToPhysical: right scratchRegisterIndex: 0 signExtendedImmediate: true.
	rightRegister := rightPhysical.
	(resultPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 0
	].

	streamBuilder x86: integerInstruction with: resultPhysical with: rightRegister.

]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> emitArithmeticUnaryInto: result value: value float: floatInstruction double: doubleInstruction [
	| resultPhysical |
	value ~= result ifTrue: [
		self moveValue: value toRegister: result.
	].
	resultPhysical := self virtualToPhysical: result.
	self assert: resultPhysical isRegisterOrRegisterAddress.

	result isDoubleFloatRegister ifTrue: [
		^ streamBuilder x86: doubleInstruction with: resultPhysical
	].
	result isFloatRegister ifTrue: [ 
		^ streamBuilder x86: floatInstruction with: resultPhysical
	].

	self error: 'Not yet supported'

]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> emitArithmeticUnaryInto: result value: value integer: integerInstruction [
	| resultPhysical |
	value ~= result ifTrue: [
		self moveValue: value toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	self assert: resultPhysical isRegisterOrRegisterAddress.
	result isIntegerRegister ifTrue: [
		^ streamBuilder x86: integerInstruction with: resultPhysical
	].
	self error: 'Not yet supported'

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitBitwiseInto: result left: left right: right integer: integerInstruction float: floatInstruction double: doubleInstruction [
	| resultPhysical rightPhysical rightRegister |
	self assert: result isRegisterOrRegisterAddress.

	left ~= result ifTrue: [
		self moveValue: left toRegister: result.
	].

	resultPhysical := self virtualToPhysical: result.
	rightPhysical := self virtualToPhysical: right scratchRegisterIndex: 0.
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

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> emitBitwiseShiftInto: result value: value amount: amount instruction: instruction [
	| amountRegister amountPhysical resultPhysical |
	amountRegister := target pointerSize = 4 ifTrue: [ ECX ] ifFalse: [ RCX ].
	
	result ~= value ifTrue: [ 
		self moveValue: value toRegister: result
	].

	resultPhysical := self virtualToPhysical: result.
	amount isImmediate ifTrue: [ 
		streamBuilder x86: instruction dst: resultPhysical src: (amount value bitAnd: 63)
	] ifFalse: [ 
		amountPhysical := self virtualToPhysical: amount.
		amountPhysical ~= amountRegister ifTrue: [
			streamBuilder x86: MOV dst: amountRegister src: amountPhysical
		].
	
		streamBuilder x86: instruction dst: resultPhysical src: CL
	].

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparison: comparisonInstruction into: result left: left right: right branchTrue: branchTrue branchFalse: branchFalse [
	| resultPhysical rightPhysical rightRegister leftPhysical cmpResult |
	self assert: result isRegisterOrRegisterAddress.

	leftPhysical := self virtualToPhysical: left scratchRegisterIndex: 0 notImmediate: true.
	rightPhysical := self virtualToPhysical: right scratchRegisterIndex: 1.

	rightRegister := rightPhysical.
	(leftPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 1
	].

	resultPhysical := self virtualToPhysical: result.
	streamBuilder x86: MOV dst: resultPhysical src: 1.

	streamBuilder x86: comparisonInstruction with: leftPhysical with: rightRegister.

	cmpResult := streamBuilder newPrivateSymbol: #cmpResult.
	streamBuilder
		x86: branchTrue with: cmpResult;
		x86: MOV dst: resultPhysical src: 0;
		label: cmpResult

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparison: instruction left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination [
	self assert: left isIntegerRegister.
	^ self emitComparison: instruction with: CMP left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparison: instruction with: comparisonInstruction left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination [
	| rightPhysical rightRegister leftPhysical falseLabel trueLabel |
	leftPhysical := self virtualToPhysical: left scratchRegisterIndex: 0 notImmediate: true.
	rightPhysical := self virtualToPhysical: right scratchRegisterIndex: 1.
	
	rightRegister := rightPhysical.
	(leftPhysical isRegisterAddress and: [ rightPhysical isRegisterAddress ]) ifTrue: [ 
		rightRegister := self movePhysical: rightPhysical toScratchRegister: 1
	].

	streamBuilder x86: comparisonInstruction with: leftPhysical with: rightRegister.

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
SAsmX86InstructionLowerer >> emitComparisonFloat: isOrdered into: result left: left right: right branchTrue: branchTrue branchFalse: branchFalse [

	left isFloatOperand ifTrue: [ 
		^ self emitComparison: (isOrdered ifTrue: [ COMISS ] ifFalse: [ UCOMISS ])
			into: result left: left right: right branchTrue: branchTrue branchFalse: branchFalse
	] ifFalse: [
		self assert: left isDoubleFloatOperand.
		^ self emitComparison: (isOrdered ifTrue: [ COMISD ] ifFalse: [ UCOMISD ])
			into: result left: left right: right branchTrue: branchTrue branchFalse: branchFalse
	].

]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparisonFloat: instruction ordered: ordered left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination [
	self assert: left isFloatingPointRegister.
	left isFloatRegister ifTrue: [ 
		^ self emitComparison: instruction with: (ordered ifTrue: [ COMISS ] ifFalse: [ UCOMISS ])
			left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination	
	] ifFalse: [ 
		self assert: left isDoubleFloatRegister.
		^ self emitComparison: instruction with: (ordered ifTrue: [ COMISD ] ifFalse: [ UCOMISD ])
			left: left right: right branchTrue: branchTrue destination: trueDestination branchFalse: branchFalse destination: falseDestination	
	].


]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> emitComparisonIntegerInto:result left: left right: right branchTrue: branchTrue branchFalse: branchFalse [
	^ self emitComparison: CMP into: result left: left right: right branchTrue: branchTrue branchFalse: branchFalse
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> emitExitPoint [
	self leaveFrame.
	
	function callingConvention isStackCleanedByCaller ifTrue: [ 
		streamBuilder x86: RET
	] ifFalse: [
		streamBuilder x86: RET with: stackFrameLayout argumentsSize
	]

]

{ #category : #casting }
SAsmX86InstructionLowerer >> emitFloatCast: instruction withInstruction: castInstruction [
	| operand resultPhysical resultRegister result |
	operand := self virtualToPhysical: instruction left.
	result := instruction result.
	resultPhysical := self virtualToPhysical: instruction result.
	
	resultRegister := resultPhysical.
	resultPhysical isRegisterAddress ifTrue: [
		resultRegister := self scratchRegister: 0 for: resultPhysical.
	].

	streamBuilder x86: castInstruction dst: resultRegister src: operand.
	
	resultPhysical ~~ resultRegister ifTrue: [
		result isFloatRegister ifTrue: [
			streamBuilder x86: MOVSS dst: resultPhysical src: resultRegister
		].
		result isDoubleFloatRegister ifTrue: [
			streamBuilder x86: MOVSD dst: resultPhysical src: resultRegister
		].
	]
]

{ #category : #casting }
SAsmX86InstructionLowerer >> emitFloatToIntCast: instruction withInstruction: castInstruction [
	| operand resultPhysical resultRegister result |
	operand := self virtualToPhysical: instruction left.
	result := instruction result.
	resultPhysical := self virtualToPhysical: instruction result.
	
	resultRegister := resultPhysical.
	resultPhysical isRegisterAddress ifTrue: [ 
		resultRegister := self scratchRegister: 0 for: resultPhysical
	].

	streamBuilder x86: castInstruction dst: resultRegister src: operand.
	
	resultPhysical ~~ resultRegister ifTrue: [
		streamBuilder x86: MOV dst: resultPhysical src: resultRegister
	]
]

{ #category : #casting }
SAsmX86InstructionLowerer >> emitIntToFloatCast: instruction withInstruction: castInstruction [
	^ self emitFloatCast: instruction withInstruction: castInstruction
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> emitIntegerDivisionInto: result dividend: dividend divisor: divisor instruction: x86DivisionInstruction resultRegisterIndex: resultRegisterIndex activeRegisters: activeRegisters [
	| dividendPhysical divisorPhysical resultPhysical dividendUpperRegister dividendLowerRegister touchedRegisters toSpill resultRegister divisorRegister |
	self assert: result isRegisterOrRegisterAddress.

	target pointerSize = 4 ifTrue: [
		dividendUpperRegister := EDX.
		dividendLowerRegister := EAX.
		divisorRegister := ECX.
		touchedRegisters := { EDX . EAX }
	] ifFalse: [ 
		dividendUpperRegister := RDX.
		dividendLowerRegister := RAX.
		divisorRegister := RCX.
		touchedRegisters := { RDX . RAX }
	].

	toSpill := activeRegisters select: [:reg |
		(reg ~= result or: [reg = dividend or: [reg = divisor]])
		and: [touchedRegisters includes: reg register]].
	self spillRegisters: toSpill.

	dividendPhysical := self virtualToPhysical: dividend.
	divisorPhysical := self virtualToPhysical: divisor.
	divisorPhysical isImmediate ifTrue: [ 
		streamBuilder x86: MOV dst: divisorRegister src: divisorPhysical.
		divisorPhysical := divisorRegister
	].

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
	| value result extensionResult valueRegister |
	result := self virtualToPhysical: instruction result.
	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	value isImmediateConstant ifTrue: [
		valueRegister := self scratchRegister: 0 for: result.
		streamBuilder x86: MOV dst: valueRegister src: value.
		value := valueRegister
	].
 
	extensionResult := result.
	result isRegisterAddress ifTrue: [ 
		extensionResult := self scratchRegister: 1 for: result.
	].

	(operandSize = 1 and: [target pointerSize ~= 8]) ifTrue: [
		(value isRegister and: [ value canBeValidByteRegisters not ]) ifTrue: [ 
			value := self movePhysical: value toScratchRegister: 0
		].
		streamBuilder x86: extensionInstruction dst: extensionResult src: value byte.
	] ifFalse: [
		streamBuilder x86: extensionInstruction dst: extensionResult src: (value withSize: operandSize).
	].

	
	result ~= extensionResult ifTrue: [
		streamBuilder x86: MOV dst: result src: extensionResult
	]
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
					arg size = 4 ifTrue: [ 
						streamBuilder x86: MOVSS dst: (self virtualRegisterLocationToPhysicalLocation: arg virtualRegisters first) src: arg argumentPassingRegister
					] ifFalse: [
						arg size = 8 ifTrue: [ 
							streamBuilder x86: MOVSD dst: (self virtualRegisterLocationToPhysicalLocation: arg virtualRegisters first) src: arg argumentPassingRegister
						] ifFalse: [
							self assert: (arg size = 8 and: [ arg alignment >= 16 ]).
							streamBuilder x86: MOVAPD dst: (self virtualRegisterLocationToPhysicalLocation: arg virtualRegisters first) src: arg argumentPassingRegister
						]
					]
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
	| pointerSize dynamicObjectSize callingConvention totalFrameSize nativeSizeToAllocate argumentDescriptor scratchRegister stackSizeRequirement stackCheckedEntry stackLimitTrap nilPointerRegister nilPointer stackDescriptorRegisterCount |
	pointerSize := target pointerSize.
	callingConvention := function callingConvention.
	
	dynamicObjectSize := stackFrameLayout dynamicRootCount * pointerSize.
	totalFrameSize := stackFrameLayout size + dynamicObjectSize alignedTo: callingConvention stackAlignment.
	nativeSizeToAllocate := totalFrameSize - dynamicObjectSize - stackFrameLayout reservedLocalsSpace.
	argumentDescriptor := self computeArgumentDescriptor.
	
	scratchRegister := callingConvention enterFrameScratchRegister.

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
	(stackFrameLayout dynamicRootCount ~= 0 or: [callingConvention hasContextMetadata or: [function contextMetaData isNotNil]]) ifTrue: [
		nilPointer := 0."self nilGlobalSymbol".
		nilPointer ~= 0 ifTrue: [ 
			nilPointerRegister := scratchRegister.
			streamBuilder
				x86: MOV with: nilPointerRegister with: nilPointer.
		] ifFalse: [ 
			nilPointerRegister := 0
		]
	].

	gotBaseRegister := nil.
	contextMetadataOffset := 0.
	(target needsSlotForGOTPointer and: [target hasPositionIndependentCode]) ifTrue: [
		gotBaseRegister := target gotBaseRegister.
		streamBuilder
			x86: PUSH with: gotBaseRegister.
			
		self fetchGOTPointerInto: gotBaseRegister.
		contextMetadataOffset := target pointerSize negated.
	].

	"Context meta data"
	(callingConvention hasContextMetadata or: [function contextMetaData isNotNil]) ifTrue: [
		self assert: totalFrameSize <= 16rFFFF.
		self assert: stackFrameLayout dynamicRootCount <= 16rfff.
		
		"Save the GOT base register on its slot, even if it is not used for PIC code."
		(target needsSlotForGOTPointer and: [gotBaseRegister isNil]) ifTrue: [ 
			self assert: gotBaseRegister isNil.
			gotBaseRegister := target gotBaseRegister.
			streamBuilder
				x86: PUSH with: gotBaseRegister.
			contextMetadataOffset := target pointerSize negated.
		].
		
		self pushPhysicalIntegerToTheStack: self compiledMethodMetaData scratchIndex: 0.
		streamBuilder
			x86: PUSH with: nilPointerRegister; "Context object"
			x86: PUSH with: argumentDescriptor.

		stackDescriptorRegisterCount := registersToPreserve size.
		target needsSlotForGOTPointer ifTrue: [
			"Do not count the mandatory GOT pointer register."
			self assert: (registersToPreserve includes: gotBaseRegister).
			stackDescriptorRegisterCount := stackDescriptorRegisterCount - 1.
		].
	
		target objectModel isReferenceCounted ifTrue: [
			streamBuilder
				x86: PUSH with: ((totalFrameSize << 16) | (stackFrameLayout explicitDynamicRootCount) | (stackDescriptorRegisterCount << 12)).
		] ifFalse: [ 
			streamBuilder
				x86: PUSH with: ((totalFrameSize << 16) | (stackFrameLayout dynamicRootCount) | (stackDescriptorRegisterCount << 12))
		].
	].

	"Store the registers that have to be preserved."
	registersToPreserve do: [ :register |
		register ~~ gotBaseRegister ifTrue: [ 
			streamBuilder x86: PUSH with: register
		]
	].

	"Initialize the object variables with nil."
	1 to: stackFrameLayout dynamicRootCount do: [ :i |
		streamBuilder x86: PUSH with: nilPointerRegister
	].

	"Allocate the native size."
	nativeSizeToAllocate ~= 0 ifTrue: [
		streamBuilder x86: SUB with: target stackPointerRegister with: nativeSizeToAllocate.
	].
	stackSizeToRestoreBeforeReturn := nativeSizeToAllocate + (stackFrameLayout dynamicRootCount*target pointerSize).

	"Emit the argument loads."
	self emitPrologueLoads
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> fetchGOTPointerInto: targetRegister [
	| extraOffset |
	self assert: target pointerSize = 4.
	extraOffset := self moveInstructionPointerInto: targetRegister.
	streamBuilder x86: ADD dst: targetRegister src: (streamBuilder globalOffsetTableSymbol immediateRelativeGlobalOffsetTable: 4) + "ADD EBX size" 2 + "POP EBX" extraOffset
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionLowerer >> immediateConstant64ToConstantZone: immediateConstant orToScratchRegister: scratchIndex [
	| scratchRegister symbol |
	symbol := streamBuilder newPrivateSymbol: #constantI64.
	streamBuilder withNewSection: [
		streamBuilder rodataSection;
			label: symbol;
			constI64: (immediateConstant copyWithStreamBuilder: streamBuilder).
	].

	^ (symbol immediate: 8) asX86PointerOfSize: 8 withBuilder: streamBuilder
"	self assert: target pointerSize = 8.
	self assert: target hasPositionIndependentCode not.
	scratchRegister := self scratchRegister: scratchIndex for: SAsmX86RegisterInt64.
	streamBuilder x86: MOV dst: scratchRegister src: immediateConstant.
	^ scratchRegister
"
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> leaveFrame [
	function callingConvention isNaked ifTrue: [ ^ self ].
	self leaveFramefullMethod.
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> leaveFramefullMethod [
	| pointerSize |
	registersToPreserve ifNotEmpty: [
		stackSizeToRestoreBeforeReturn ~= 0 ifTrue: [ 
			streamBuilder x86: ADD dst: target stackPointerRegister src: stackSizeToRestoreBeforeReturn
		].
	
		registersToPreserve reverseDo: [ :reg |
			reg ~~ gotBaseRegister ifTrue: [ 
				streamBuilder x86: POP with: reg
			]
		]
	].

	gotBaseRegister ifNotNil: [
		(function callingConvention hasContextMetadata or: [function contextMetaData isNotNil]) ifTrue: [
			pointerSize := target pointerSize.
			streamBuilder x86: MOV dst: gotBaseRegister src: (target framePointerRegister asX86PointerOfSize: pointerSize) - pointerSize
		 ] ifFalse: [ 
			streamBuilder x86: POP with: gotBaseRegister
		].
		
	].
	
	streamBuilder
		x86: MOV dst: target stackPointerRegister src: target framePointerRegister;
		x86: POP with: target framePointerRegister.
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> loadI386SymbolWithAddend: symbolWithAddend viaGOTInto: destination [
	| register convertedSymbol |
	register := destination.
	destination isRegister ifFalse: [ 
		register := self scratchRegister: 0 for: destination.
	].

	convertedSymbol := symbolWithAddend copyWithStreamBuilder: streamBuilder.	
	(self shouldSymbolBeLoadedThroughLoadFromGOT: symbolWithAddend symbol) ifTrue: [
		streamBuilder x86: MOV dst: register src: (gotBaseRegister asX86PointerOfSize: target pointerSize) + convertedSymbol asGOTReference.
		convertedSymbol addend ~= 0 ifTrue: [
			streamBuilder x86: ADD dst: register src: convertedSymbol addend.
		]
	] ifFalse: [
		streamBuilder x86: LEA dst: register src: (gotBaseRegister asX86PointerOfSize: target pointerSize) + convertedSymbol makeGOTOffset.
	].

	register ~~ destination ifTrue: [ 
		streamBuilder x86: MOV dst: destination src: register
	]
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> loadSymbolWithAddend: symbolWithAddend viaGOTAsPointerOfSize: pointerSize scratchIndex: scratchIndex [
	| scratchRegister |
	target hasPositionIndependentCode ifFalse: [
		^ symbolWithAddend asX86PointerOfSize: pointerSize withBuilder: streamBuilder
	].

	(target pointerSize = 8 and: [(self shouldSymbolBeLoadedThroughLoadFromGOT: symbolWithAddend symbol) not]) ifTrue: [
		^ symbolWithAddend asX86PointerOfSize: pointerSize withBuilder: streamBuilder
	].

	scratchRegister := self scratchRegister: scratchIndex for: target framePointerRegister.
	self loadSymbolWithAddend: symbolWithAddend viaGOTInto: scratchRegister.
	^ scratchRegister asX86PointerOfSize: pointerSize withBuilder: streamBuilder
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> loadSymbolWithAddend: symbolWithAddend viaGOTInto: destination [
	^ target pointerSize = 4
		ifTrue: [self loadI386SymbolWithAddend: symbolWithAddend viaGOTInto: destination]
		ifFalse: [self loadX86_64SymbolWithAddend: symbolWithAddend viaGOTInto: destination]
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> loadX86_64SymbolWithAddend: symbolWithAddend viaGOTInto: destination [
	| register convertedSymbol |
	register := destination.
	destination isRegister ifFalse: [ 
		register := self scratchRegister: 0 for: destination.
	].

	convertedSymbol := symbolWithAddend copyWithStreamBuilder: streamBuilder.	
	(self shouldSymbolBeLoadedThroughLoadFromGOT: symbolWithAddend symbol) ifTrue: [
		streamBuilder x86: MOV dst: register src: (convertedSymbol asGOTReference asX86PointerOfSize: 8 withBuilder: streamBuilder).
		symbolWithAddend addend ~= 0 ifTrue: [
			streamBuilder x86: ADD dst: register src: convertedSymbol addend.
		]
	] ifFalse: [
		streamBuilder x86: LEA dst: register src: (convertedSymbol asX86PointerOfSize: 8 withBuilder: streamBuilder).
	].

	register ~~ destination ifTrue: [ 
		streamBuilder x86: MOV dst: destination src: register
	]
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> lowerConditional: condition branch: branch [
	condition operation acceptCondition: condition withBranch: branch asConditionWith: self 
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionLowerer >> moveImmediateConstant64: immediate toScratchRegister: scratchRegisterIndex [
	self halt
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> moveInstructionPointerInto: targetRegister [
	| label |
	target pointerSize = 8 ifTrue: [ 
		self halt
	] ifFalse: [
		label := streamBuilder newPrivateSymbol: #'.getEIP'.
		streamBuilder
			x86: CALL with: label;
			label: label;
			x86: POP with: targetRegister.
		^ 1
	]
]

{ #category : #memory }
SAsmX86InstructionLowerer >> movePhysical: physicalLocations toRegisters: registers [
	self flag: 'Optimize this by avoiding the stack'.
	physicalLocations do: [ :loc | streamBuilder x86: PUSH with: loc ].
	registers reverseDo: [ :loc | streamBuilder x86: POP with: loc ].
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> movePhysical: physicalValue toScratchRegister: scratchIndex [
	^ self movePhysical: physicalValue toScratchRegister: scratchIndex classOf: physicalValue
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> movePhysical: physicalValue toScratchRegister: scratchIndex classOf: registerClassSource [
	| scratchRegister |
	scratchRegister := self scratchRegister: scratchIndex for: registerClassSource.
	scratchRegister isVectorRegister ifTrue: [
		physicalValue size = 4 ifTrue: [
			streamBuilder x86: MOVSS dst: scratchRegister src: physicalValue.
			^ scratchRegister
		].
		physicalValue size = 8 ifTrue: [ 
			streamBuilder x86: MOVSD dst: scratchRegister src: physicalValue.
			^ scratchRegister
		].
		physicalValue size = 16 ifTrue: [ 
			streamBuilder x86: MOVAPS dst: scratchRegister src: physicalValue.
			^ scratchRegister
		].
		self error: 'Unsupported vector register.'
	] ifFalse: [ 
		scratchRegister isIntegerRegister ifTrue: [ 
			streamBuilder x86: MOV dst: scratchRegister src: physicalValue.
			^ scratchRegister
		]
	].

	self error: 'Unsupported move type.'

]

{ #category : #'as yet unclassified' }
SAsmX86InstructionLowerer >> moveSpilledValue: value toFloatRegister: register [
	| location |
	value isVirtualRegister ifFalse: [
		self halt.
	].

	location := (self virtualRegisterLocationToPhysicalLocation: value).
	value size = 4 ifTrue: [
		^ streamBuilder x86: MOVSS dst: register src: location
	].
	value size = 8 ifTrue: [ 
		^ streamBuilder x86: MOVSD dst: register src: location
	].

	self error: 'Unsupported value'
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionLowerer >> moveSpilledValue: value toIntegerRegister: register [
	value isVirtualRegister ifFalse: [ 
		^ streamBuilder x86: MOV dst: register src: (value copyWithStreamBuilder: streamBuilder)
	].

	^ streamBuilder x86: MOV dst: register src: (self virtualRegisterLocationToPhysicalLocation: value)
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> moveValue: value toFloatRegister: register [
	| valuePhysical |
	valuePhysical := self virtualToPhysical: value.
	valuePhysical isRegister ifTrue: [ 
		^ streamBuilder x86: MOVAPD dst: register src: valuePhysical 
	] ifFalse: [
		value size = 4 ifTrue: [
			^ streamBuilder x86: MOVSS dst: register src: valuePhysical 
		].
		value size = 8 ifTrue: [ 
			^ streamBuilder x86: MOVSD dst: register src: valuePhysical 
		].	
	].
	self error: 'Unsupported value for moving'
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> moveValue: value toIntegerRegister: register [
	| valuePhysical |
	target pointerSize = 8 ifTrue: [ 
		value isImmediateSymbolWithAddend ifTrue: [ 
			^ streamBuilder x86: LEA dst: register src: (value asX86PointerOfSize: 8 withBuilder: streamBuilder)
		].
	].

	valuePhysical := self virtualToPhysical: value.
	valuePhysical ~= register ifTrue: [ streamBuilder x86: MOV dst: register src: valuePhysical ]

]

{ #category : #spilling }
SAsmX86InstructionLowerer >> moveValue: value toRegister: register [
	| physical valuePhysical |
	physical := self virtualToPhysical: register.
	self assert: physical isRegisterOrRegisterAddress.
	value isImmediate ifTrue: [
		register isFloatingPointRegister ifTrue: [
			self error: 'Cannot move an immediate toward a float register directly.'		
		].
	
		(value isImmediateSymbolWithAddend and: [ target hasPositionIndependentCode ]) ifTrue: [ 
			^ self loadSymbolWithAddend: value viaGOTInto: physical
		].
	
		^ streamBuilder x86: MOV dst: physical src: (value copyWithStreamBuilder: streamBuilder)
	].

	valuePhysical := self virtualToPhysical: value scratchRegisterIndex: 0.
	valuePhysical == physical ifTrue: [ ^ self ].
	(valuePhysical isRegisterAddress and: [ physical isRegisterAddress ]) ifTrue: [
		valuePhysical := self movePhysical: valuePhysical toScratchRegister: 0
	].

	physical isVectorRegister ifTrue: [
		valuePhysical isVectorRegister ifTrue: [
			^ streamBuilder x86: MOVAPS dst: physical src: valuePhysical
		].
	
		value size = 4 ifTrue: [ 
			^ streamBuilder x86: MOVSS dst: physical src: valuePhysical
		].
		value size = 8 ifTrue: [
			^ streamBuilder x86: MOVSD dst: physical src: valuePhysical
		].
		value size = 16 ifTrue: [
			^ streamBuilder x86: MOVAPD dst: physical src: valuePhysical
		].
	] ifFalse: [
		^ streamBuilder x86: MOV dst: physical src: valuePhysical
	].
	
	self error: 'Unsupported value to move'
]

{ #category : #testing }
SAsmX86InstructionLowerer >> needsToSpillReturnFromFrame: instruction [
	^ function callingConvention hasContextMetadata or: [function contextMetaData isNotNil]
]

{ #category : #testing }
SAsmX86InstructionLowerer >> needsToSpillThreeAddressInstruction: tacInstruction [
	(tacInstruction operation isReturn and: [ (function callingConvention hasContextMetadata or: [function contextMetaData isNotNil])]) ifTrue: [ ^ true ].
	^ tacInstruction operation isIntegerDivision or: [ tacInstruction operation isIntegerRemainder ]
]

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> pushFloatValueToTheStack: value scratchIndex: scratchIndex [
	| valuePhysical |
	valuePhysical := self virtualToPhysical: value.
	target pointerSize = 4 ifTrue: [
		valuePhysical isRegisterAddress ifTrue: [
			value isDoubleFloatOperand ifTrue: [ 
				streamBuilder x86: PUSH with: valuePhysical dword + 4.
			].
		
			^ streamBuilder x86: PUSH with: valuePhysical dword.
		] ifFalse: [ 
			value isDoubleFloatOperand ifTrue: [ 
				^ streamBuilder
					x86: SUB dst: target stackPointerRegister src: 8;
					x86: MOVSD dst: (target stackPointerRegister asX86PointerOfSize: 8) src: valuePhysical.
			].
			^ streamBuilder
					x86: SUB dst: target stackPointerRegister src: 4;
					x86: MOVSS dst: (target stackPointerRegister asX86PointerOfSize: 4) src: valuePhysical.
		]
	] ifFalse: [
		valuePhysical isRegisterAddress ifTrue: [
			value isDoubleFloatRegister ifTrue: [ 
				^ streamBuilder x86: PUSH with: valuePhysical qword.
			] ifFalse: [ 
				self halt
			]		
		] ifFalse: [ 
			value isDoubleFloatRegister ifTrue: [ 
				^ streamBuilder
					x86: SUB dst: target stackPointerRegister src: 8;
					x86: MOVSD dst: (target stackPointerRegister asX86PointerOfSize: 8) src: valuePhysical.
			].
			^ streamBuilder
					x86: SUB dst: target stackPointerRegister src: 8;
					x86: MOVSS dst: (target stackPointerRegister asX86PointerOfSize: 4) src: valuePhysical.
		]
	].

]

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> pushIntegerToTheStack: value scratchIndex: scratchIndex [
	| valuePhysical |
	valuePhysical := self virtualToPhysical: value scratchRegisterIndex: scratchIndex.
	(target pointerSize = 8 and: [valuePhysical isImmediate and: [valuePhysical isImmediateS32 not]]) ifTrue: [
		^ streamBuilder x86: PUSH with: (self immediateConstant64ToConstantZone: valuePhysical orToScratchRegister: scratchIndex)
		].
		
	streamBuilder x86: PUSH with: valuePhysical.
]

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> pushPhysicalIntegerToTheStack: valuePhysical scratchIndex: scratchIndex [
	| register |
	(valuePhysical isImmediateSymbolWithAddend and: [ target hasPositionIndependentCode or: [ target pointerSize = 8] ]) ifTrue: [ 
		register := self scratchRegister: scratchIndex for: target stackPointerRegister.
		self loadSymbolWithAddend: valuePhysical viaGOTInto: register.
		^ streamBuilder x86: PUSH with: register.
	].

	(target pointerSize = 8 and: [valuePhysical isImmediate and: [valuePhysical isImmediateS32 not]]) ifTrue: [
		^ streamBuilder x86: PUSH with: (self immediateConstant64ToConstantZone: valuePhysical orToScratchRegister: scratchIndex)
	].
		
	streamBuilder x86: PUSH with: valuePhysical.
	
]

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> pushValueToTheStack: value scratchIndex: scratchIndex [
	value isFloatingPointOperand ifTrue: [
		self pushFloatValueToTheStack: value scratchIndex: scratchIndex.
	] ifFalse: [
		self pushIntegerToTheStack: value scratchIndex: scratchIndex
	]
	
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> returnValue: value valueHigh: valueHigh [
	| valuePhysical |
	value ifNil: [ ^ self ].
	value isFloatingPointOperand ifTrue: [ 
		function callingConvention resultFloatRegister ifNil: [ 
			valuePhysical := self virtualToPhysical: value.
			valuePhysical isRegisterAddress ifTrue: [ 
				streamBuilder x86: FLD with: valuePhysical
			] ifFalse: [ 
				self pushValueToTheStack: value scratchIndex: 0.
				streamBuilder
					x86: FLD with: (target stackPointerRegister asX86PointerOfSize: value size);
					x86: ADD dst: target stackPointerRegister src: value size.
			]
		] ifNotNil: [
			self
				moveValue: value toRegister: function callingConvention resultFloatRegister.
		]
		
	] ifFalse: [ 
		self
			moveValue: value toRegister: function callingConvention resultIntRegister.
	].

	valueHigh ifNotNil: [ 
		valueHigh isFloatingPointOperand ifTrue: [ 
			self error: 'Not yet supported.'.
		] ifFalse: [ 
			self moveValue: value toRegister: function callingConvention resultInt2Register
		]
	]
	
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> scratchRegister: scratchIndex for: value [
	^ (scratchRegisterClases at: value registerClass) at: scratchIndex + 1
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> shouldSymbolBeLoadedThroughLoadFromGOT: symbol [
	target hasPositionIndependentCode ifFalse: [ ^ false ].
	symbol isExternal ifTrue: [ ^ true ].
	(symbol isPublic and: [ target executable not ]) ifTrue: [ ^ true ].
	^ false
]

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> sizeOfValuePushedToTheStack: value calledConvention: calledConvention [
	^ (value isImmediate ifTrue: [target pointerSize] ifFalse: [value size]) max: calledConvention stackArgumentAlignment
]

{ #category : #spilling }
SAsmX86InstructionLowerer >> spillRegister: virtualRegister [
	virtualRegister isVirtualRegister ifFalse: [ ^ self ].
	virtualRegister register ifNil: [ ^ self ].
	
	virtualRegister isVectorRegister ifTrue: [ 
		self halt
	] ifFalse: [ 
		virtualRegister isIntegerRegister ifTrue: [
			self assert: virtualRegister size = target pointerSize.
			^ streamBuilder x86: MOV dst: (self virtualRegisterLocationToPhysicalLocation: virtualRegister) src: virtualRegister register
		].
		virtualRegister isFloatRegister  ifTrue: [
			^ streamBuilder x86: MOVSS dst: (self virtualRegisterLocationToPhysicalLocation: virtualRegister) src: virtualRegister register
		].
		virtualRegister isDoubleFloatRegister  ifTrue: [ 
			^ streamBuilder x86: MOVSD dst: (self virtualRegisterLocationToPhysicalLocation: virtualRegister) src: virtualRegister register
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
			self assert: virtualRegister size = target pointerSize.
			^ streamBuilder x86: MOV dst: virtualRegister register src: (self virtualRegisterLocationToPhysicalLocation: virtualRegister)
		].
		virtualRegister isFloatRegister  ifTrue: [ 
			^ streamBuilder x86: MOVSS dst: virtualRegister register src: (self virtualRegisterLocationToPhysicalLocation: virtualRegister)
		].
		virtualRegister isDoubleFloatRegister  ifTrue: [ 
			^ streamBuilder x86: MOVSD dst: virtualRegister register src: (self virtualRegisterLocationToPhysicalLocation: virtualRegister)
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
		^ (target framePointerRegister asX86PointerOfSize: virtualRegister size vectorRegister: virtualRegister isFloatingPointOperand) + (variable offset)
	].
	^ (target framePointerRegister asX86PointerOfSize: virtualRegister size vectorRegister: virtualRegister isFloatingPointOperand) + (virtualRegister spillLocation offset + virtualRegister variableOffset)
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: virtualRegister [
	virtualRegister isConstantPointer ifTrue: [
		(target hasPositionIndependentCode and: [target pointerSize = 4]) ifTrue: [ 
			^ virtualRegister asX86PointerWithBuilder: streamBuilder gotPointer: gotBaseRegister
		].
	].

	target pointerSize = 8 ifTrue: [ 
		virtualRegister isImmediateSymbolWithAddend ifTrue: [ 
			self error: 'Cannot access directly to immediate symbol with addend in position independent code.'
			"self flag: 'Load the virtual register address in a register'.
			^ 0 asSAsmInstructionOperand"
		].
	].

	^ super virtualToPhysical: virtualRegister
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: virtualRegister pointerOfSize: pointerSize scratchIndex: scratchIndex [
	| physicalRegister |
	self assert: virtualRegister isVariable not.
	virtualRegister isImmediateSymbolWithAddend ifTrue: [
		^ self loadSymbolWithAddend: virtualRegister viaGOTAsPointerOfSize: pointerSize scratchIndex: scratchIndex
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

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex [
	^ self virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex signExtendedImmediate: false notImmediate: false
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex notImmediate: notImmediate [
	^ self virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex signExtendedImmediate: false notImmediate: notImmediate
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex signExtendedImmediate: signExtendedImmediate [
	^ self virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex signExtendedImmediate: signExtendedImmediate notImmediate: false
]

{ #category : #'abstract instruction generation' }
SAsmX86InstructionLowerer >> virtualToPhysical: register scratchRegisterIndex: scratchRegisterIndex signExtendedImmediate: signExtendedImmediate notImmediate: notImmediate [
	| scratchRegister |
	(notImmediate or: [target pointerSize = 8 or: [target hasPositionIndependentCode]]) ifTrue: [
		register isImmediateSymbolWithAddend ifTrue: [
			scratchRegister := self scratchRegister: scratchRegisterIndex for: target stackPointerRegister.
			self loadSymbolWithAddend: register viaGOTInto: scratchRegister.
			^ scratchRegister
		].
	
		(register isImmediateConstant and:
		[ notImmediate or: [
		  (signExtendedImmediate not and: [register isImmediate32 not]) or:
		  (signExtendedImmediate and: [register isImmediateS32 not]) ]]) ifTrue: [
			scratchRegister := self scratchRegister: scratchRegisterIndex for: target stackPointerRegister.
			streamBuilder x86: MOV dst: scratchRegister src: register.
			^ scratchRegister
		].
	].

	^ self virtualToPhysical: register
]

{ #category : #'as yet unclassified' }
SAsmX86InstructionLowerer >> virtualToPhysicalDirectRelativeImmediate: virtualRegister [
	^ super virtualToPhysical: virtualRegister
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacAbove: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JA branchFalse: JBE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacAbove: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JA destination: branch trueDestination branchFalse: JBE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacAboveOrEqual: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JAE branchFalse: JB
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacAboveOrEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JAE destination: branch trueDestination branchFalse: JB destination: branch falseDestination
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacAdd: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: ADD
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacArithmeticShiftRight: instruction [
	self emitBitwiseShiftInto: instruction result value: instruction left amount: instruction right instruction: SAR
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
	valuePhysical := self virtualToPhysical: result scratchRegisterIndex: 1.
	
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
	valuePhysical := self virtualToPhysical: result scratchRegisterIndex: 1.
	
	self assert: variablePhysical isRegisterAddress.
	valuePhysical isRegister ifFalse: [ 
		self halt.
	].
	
	streamBuilder x86: LOCK;
		x86: XCHG dst: variablePhysical src: valuePhysical.
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacBelow: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JB branchFalse: JAE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacBelow: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JB destination: branch trueDestination branchFalse: JAE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacBelowOrEqual: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JBE branchFalse: JB
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacBelowOrEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JBE destination: branch trueDestination branchFalse: JA destination: branch falseDestination
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacBitAnd: instruction [
	^ self emitBitwiseInto: instruction result left: instruction left right: instruction right 
			integer: AND float: ANDPS double: ANDPD
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacBitNot: instruction [
	^ self emitArithmeticUnaryInto: instruction result value: instruction value integer: NOT
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacBitOr: instruction [
	^ self emitBitwiseInto: instruction result left: instruction left right: instruction right 
			integer: OR float: ORPS double: ORPD
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacBitXor: instruction [
	^ self emitBitwiseInto: instruction result left: instruction left right: instruction right 
			integer: XOR float: XORPS double: XORPD
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacBranchInstruction: branch [
	| conditionRegister trueDestination falseDestination |
	conditionRegister := self virtualToPhysical: branch condition scratchRegisterIndex: 0.
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

{ #category : #'procedure call' }
SAsmX86InstructionLowerer >> visitTacCallInstruction: callInstruction [
	| calledFunction calledConvention calledRegisters registersToSpill stackCleanUpSize registerArguments stackArguments remainingIntegerRegisters remainingFloatRegisters integerRegisterIndex floatRegisterIndex resultPhysical stackPushedSize stackPaddingSize stackArgumentsPadding |

	calledConvention := callInstruction calledConvention.
	calledRegisters := calledConvention calledRegisters.
	
	registersToSpill := callInstruction activeRegisters select: [ :virtualRegister |
		virtualRegister isVirtualRegister and:
		[ virtualRegister register isNotNil and:
		[ (virtualRegister lastUsage ~= callInstruction index or:
			[ (calledConvention integerArgumentRegisters includes: virtualRegister register) or:
			  [(calledConvention floatArgumentRegisters includes: virtualRegister register)]]) and: 
		[ (calledRegisters includes: virtualRegister register) ] ] ]
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
			arg isFloatingPointOperand ifTrue: [ 
				remainingFloatRegisters > 0 ifTrue: [
					registerArguments add: arg.
					remainingFloatRegisters := remainingFloatRegisters - 1
				] ifFalse: [ 
					stackArguments add: arg.
				]
			] ifFalse: [ 
				self halt.
			]
		]
	].

	"Compute the size of the arguments passed in the stack."	
	stackPushedSize := calledConvention shadowCallSpaceSize.
	stackArgumentsPadding := stackArguments collect: [ :arg |
		| oldSize padding argumentAlignment |
		oldSize := stackPushedSize.
		argumentAlignment:= self alignmentOfValuePushedToTheStack: arg calledConvention: calledConvention.
		
		stackPushedSize := stackPushedSize alignedTo: argumentAlignment.
		
		padding := stackPushedSize - oldSize.
		stackPushedSize := stackPushedSize + (self sizeOfValuePushedToTheStack: arg calledConvention: calledConvention).
		padding.
	].

	stackCleanUpSize := stackPushedSize alignedTo: calledConvention stackAlignment.
	stackPaddingSize := stackCleanUpSize - stackPushedSize.
	stackPaddingSize ~= 0 ifTrue: [
		streamBuilder x86: SUB dst: target stackPointerRegister src: stackPaddingSize
	].

	"Pass arguments in the stack."	
	stackArguments size to: 1 by: -1 do: [ :index |
		| arg padding |
		arg := stackArguments at: index.
		self pushValueToTheStack: arg scratchIndex: 0.
		padding := stackArgumentsPadding at: index.
		padding ~= 0 ifTrue: [ 
			streamBuilder x86: SUB dst: target stackPointerRegister src: padding
		].
	].
	
	"Pass some arguments in registers"
	integerRegisterIndex := 1.
	floatRegisterIndex := 1.
	remainingFloatRegisters := calledConvention floatArgumentRegisters size.

	registerArguments do: [ :arg |
		(arg isIntegerRegister or: [ arg isImmediate ]) ifTrue: [
			(registersToSpill includes: arg) ifTrue: [ 
				self moveSpilledValue: arg toIntegerRegister: (calledConvention integerArgumentRegisters at: integerRegisterIndex)
			] ifFalse: [ 
				self moveValue: arg toIntegerRegister: (calledConvention integerArgumentRegisters at: integerRegisterIndex)
			].
			integerRegisterIndex := integerRegisterIndex + 1
		] ifFalse: [
			arg isFloatingPointOperand ifTrue: [
				(registersToSpill includes: arg) ifTrue: [ 
					self moveSpilledValue: arg toFloatRegister: (calledConvention floatArgumentRegisters at: floatRegisterIndex)
				] ifFalse: [
					self moveValue: arg toFloatRegister: (calledConvention floatArgumentRegisters at: floatRegisterIndex)
				].
				floatRegisterIndex := floatRegisterIndex + 1
			] ifFalse: [
				self error: 'Unsupported register argument type.'
			]
		]
	].

	"Mandatory shadow space allocation"
	calledConvention shadowCallSpaceSize ~= 0 ifTrue: [ 
		streamBuilder x86: SUB dst: target stackPointerRegister src: calledConvention shadowCallSpaceSize
	].

	callInstruction isVarArgs ifTrue: [
		calledConvention variadicVectorCountRegister ifNotNil: [:vectorCountRegister |
			streamBuilder x86: MOV dst: vectorCountRegister src: floatRegisterIndex - 1
		]
	].
	
	calledFunction := self virtualToPhysicalDirectRelativeImmediate: callInstruction called.
	streamBuilder
		x86: CALL with: calledFunction.
	(calledConvention isStackCleanedByCaller and: [stackCleanUpSize ~= 0]) ifTrue: [ 
		streamBuilder
			x86: ADD dst: target stackPointerRegister src: stackCleanUpSize.
	].
	self unspillRegisters: registersToSpill.
	
	callInstruction result doWithIndex: [ :result :index |
		(result firstUsage ~= callInstruction index or: [ result lastUsage ~= callInstruction index]) ifTrue: [ 
			resultPhysical := self virtualToPhysical: result.
			result isIntegerRegister ifTrue: [
				streamBuilder x86: MOV dst: resultPhysical src: (index = 1 ifTrue: [calledConvention resultIntRegister] ifFalse: [ calledConvention resultInt2Register ])
			] ifFalse: [
				result isFloatingPointOperand ifTrue: [ 
					calledConvention resultFloatRegister ifNotNil: [ :resultFloatRegister |
						resultPhysical isRegisterAddress ifTrue: [ 
							result size = 4 ifTrue: [
								streamBuilder x86: MOVSS dst: resultPhysical src: resultFloatRegister
							].
							result size = 8 ifTrue: [
								streamBuilder x86: MOVSD dst: resultPhysical src: resultFloatRegister
							].
						] ifFalse: [
							streamBuilder x86: MOVAPS dst: resultPhysical src: resultFloatRegister
						]
					] ifNil: [
						resultPhysical isRegisterAddress ifTrue: [
							streamBuilder x86: FSTP with: (resultPhysical asX86PointerOfSize: result size)
						] ifFalse: [
							streamBuilder
								x86: SUB dst: target stackPointerRegister src: result size;
								x86: FSTP with: (target stackPointerRegister asX86PointerOfSize: result size);
								x86: (result size = 4 ifTrue: [MOVSS] ifFalse: [MOVSD]) dst: resultPhysical src: (target stackPointerRegister asX86PointerOfSize: result size);
								x86: ADD dst: target stackPointerRegister src: result size.
						].
					]
				] ifFalse: [ 
					self halt
				]
			]
		]
	]
	
]

{ #category : #context }
SAsmX86InstructionLowerer >> visitTacContextReplaceFunction: instruction [
	| functionRegister newFunction |
	"Move the function into a register."
	newFunction := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	functionRegister := function callingConvention resultIntRegister.
	newFunction ~= functionRegister ifTrue: [ streamBuilder x86: MOV dst: functionRegister src: newFunction ].
	
	"Leave the frame"
	self leaveFrame.
	
	"Jump into the new function"
	streamBuilder x86: JMP with: functionRegister

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
	| source destination size requiredRegisters registersToSpill bytes words |
	source := self virtualToPhysical: instruction source pointerValueScratchIndex: 0.
	destination := self virtualToPhysical: instruction destination pointerValueScratchIndex: 1.
	size := self virtualToPhysical: instruction size.
	
	"Spill some registers"
	requiredRegisters := { RSI . RDI . RCX }.
	registersToSpill := instruction activeRegisters select: [ :reg | requiredRegisters includes: reg register ].
	self spillRegisters: registersToSpill.
	
	"Move the arguments"
	size isImmediate ifTrue: [ 
		self movePhysical: {source . destination } toRegisters: { RSI . RDI }.
		streamBuilder x86: CLD.
		bytes := size value & 7.
		bytes > 0 ifTrue: [
			streamBuilder
				x86: MOV dst: RCX src: bytes;
				x86: REP;
				x86: MOVS_B
		].
	
		words := size value // 8.
		words > 0 ifTrue: [ 
			streamBuilder
				x86: MOV dst: RCX src: words;
				x86: REP;
				x86: MOVS_Q
		].
	] ifFalse: [ 
		self movePhysical: {source . destination . size } toRegisters: requiredRegisters.
		self halt.
	].
		
	"Unspill the registers"
	self unspillRegisters: registersToSpill.
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

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacDoubleToFloat: instruction [
	^ self emitFloatCast: instruction withInstruction: CVTSD2SS
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacDoubleToInt32: instruction [
	^ self emitFloatToIntCast: instruction withInstruction: CVTTSD2SI
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacDoubleToInt64: instruction [
	target pointerSize = 8 ifTrue: [ 
		^ self emitFloatToIntCast: instruction withInstruction: CVTTSD2SI
	].
	self halt

]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacEqual: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JE branchFalse: JNE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacEqual: instruction withBranch: branch [
	instruction left isIntegerRegister ifFalse: [ 
		self assert: instruction right isIntegerRegister.
		^ self emitComparison: branch left: instruction right right: instruction left 
			branchTrue: JE destination: branch trueDestination branchFalse: JNE destination: branch falseDestination		
	].

	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JE destination: branch trueDestination branchFalse: JNE destination: branch falseDestination
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacFloatAdd: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			float: ADDSS double: ADDSD
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacFloatDivide: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			float: DIVSS double: DIVSD

]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacFloatMultiply: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			float: MULSS double: MULSD
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacFloatNegate: instruction [
	| result value resultPhysical valuePhysical |
	result := instruction result.
	value := instruction left.
	self assert: result isRegisterOrRegisterAddress.

	resultPhysical := self virtualToPhysical: result.
	valuePhysical := self virtualToPhysical: value.
		
	(valuePhysical = resultPhysical or: [ valuePhysical isRegisterAddress and: [ resultPhysical isRegisterAddress ]]) ifTrue: [ 			valuePhysical := self movePhysical: valuePhysical toScratchRegister: 0 classOf: result
	].
		
	^ streamBuilder
		x86: XORPD dst: resultPhysical src: resultPhysical;
		x86: (value isDoubleFloatOperand ifTrue: [ SUBSD ] ifFalse: [ SUBSS ]) dst: resultPhysical src: valuePhysical
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatOrderedEqual: instruction [
	^ self emitComparisonFloat: true into: instruction result left: instruction left right: instruction right
			branchTrue: JE branchFalse: JNE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatOrderedEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: true left: instruction left right: instruction right 
			branchTrue: JE destination: branch trueDestination
			branchFalse: JNE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatOrderedGreater: instruction [
	^ self emitComparisonFloat: true into: instruction result left: instruction left right: instruction right
			branchTrue: JA branchFalse: JBE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatOrderedGreater: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: true left: instruction left right: instruction right 
			branchTrue: JA destination: branch trueDestination
			branchFalse: JBE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatOrderedGreaterOrEqual: instruction [
	^ self emitComparisonFloat: true into: instruction result left: instruction left right: instruction right
			branchTrue: JAE branchFalse: JB
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatOrderedGreaterOrEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: true left: instruction left right: instruction right 
			branchTrue: JAE destination: branch trueDestination
			branchFalse: JB destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatOrderedLess: instruction [
	^ self emitComparisonFloat: true into: instruction result left: instruction left right: instruction right 
			branchTrue: JB branchFalse: JAE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatOrderedLess: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: true left: instruction left right: instruction right 
			branchTrue: JB destination: branch trueDestination
			branchFalse: JAE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatOrderedLessOrEqual: instruction [
	^ self emitComparisonFloat: true into: instruction result left: instruction left right: instruction right
			branchTrue: JBE branchFalse: JA
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatOrderedLessOrEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: true left: instruction left right: instruction right 
			branchTrue: JBE destination: branch trueDestination
			branchFalse: JA destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatOrderedNotEqual: instruction [
	^ self emitComparisonFloat: true into: instruction result left: instruction left right: instruction right
			branchTrue: JNE branchFalse: JE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatOrderedNotEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: true left: instruction left right: instruction right 
			branchTrue: JNE destination: branch trueDestination
			branchFalse: JE destination: branch falseDestination
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacFloatSqrt: instruction [
	| result operand resultPhysical operandPhysical resultRegister |
	result := instruction result.
	operand := instruction left.
	
	resultPhysical := self virtualToPhysical: result.
	operandPhysical := self virtualToPhysical: operand.
	
	resultRegister := resultPhysical.
	resultPhysical isRegisterAddress ifTrue: [
		resultRegister := self scratchRegister: 0 for: resultPhysical
	].

	operand isFloatRegister ifTrue: [ 
		streamBuilder x86: SQRTSS dst: resultRegister src: operandPhysical.
		resultPhysical ~~ resultRegister ifTrue: [
			streamBuilder x86: MOVSS dst: resultPhysical src: resultRegister
		]
	].
	operand isDoubleFloatOperand ifTrue: [ 
		streamBuilder x86: SQRTSD dst: resultRegister src: operandPhysical.
		resultPhysical ~~ resultRegister ifTrue: [
			streamBuilder x86: MOVSD dst: resultPhysical src: resultRegister
		]
	].

	
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacFloatSubtract: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			float: SUBSS double: SUBSD
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacFloatToDouble: instruction [
	^ self emitFloatCast: instruction withInstruction: CVTSS2SD
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacFloatToInt32: instruction [
	^ self emitFloatToIntCast: instruction withInstruction: CVTTSS2SI
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacFloatToInt64: instruction [
	target pointerSize = 8 ifTrue: [ 
		^ self emitFloatToIntCast: instruction withInstruction: CVTTSS2SI
	].
	self halt

]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedEqual: instruction [
	^ self emitComparisonFloat: false into: instruction result left: instruction left right: instruction right
			branchTrue: JE branchFalse: JNE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: false left: instruction left right: instruction right 
			branchTrue: JE destination: branch trueDestination
			branchFalse: JNE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedGreater: instruction [
	^ self emitComparisonFloat: false into: instruction result left: instruction left right: instruction right
			branchTrue: JA branchFalse: JBE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedGreater: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: false left: instruction left right: instruction right 
			branchTrue: JA destination: branch trueDestination
			branchFalse: JBE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedGreaterOrEqual: instruction [
	^ self emitComparisonFloat: false into: instruction result left: instruction left right: instruction right
			branchTrue: JAE branchFalse: JB
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedGreaterOrEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: false left: instruction left right: instruction right 
			branchTrue: JAE destination: branch trueDestination
			branchFalse: JB destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedLess: instruction [
	^ self emitComparisonFloat: false into: instruction result left: instruction left right: instruction right 
			branchTrue: JB branchFalse: JAE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedLess: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: false left: instruction left right: instruction right 
			branchTrue: JB destination: branch trueDestination
			branchFalse: JAE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedLessOrEqual: instruction [
	^ self emitComparisonFloat: false into: instruction result left: instruction left right: instruction right
			branchTrue: JBE branchFalse: JA
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedLessOrEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: false left: instruction left right: instruction right 
			branchTrue: JBE destination: branch trueDestination
			branchFalse: JA destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedNotEqual: instruction [
	^ self emitComparisonFloat: false into: instruction result left: instruction left right: instruction right
			branchTrue: JNE branchFalse: JE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacFloatUnorderedNotEqual: instruction withBranch: branch [
	^ self emitComparisonFloat: branch ordered: false left: instruction left right: instruction right 
			branchTrue: JNE destination: branch trueDestination
			branchFalse: JE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacGreater: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JG branchFalse: JLE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacGreater: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JG destination: branch trueDestination branchFalse: JLE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacGreaterOrEqual: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JGE branchFalse: JL
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacGreaterOrEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JGE destination: branch trueDestination branchFalse: JL destination: branch falseDestination
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacInt32ToDouble: instruction [
	^ self emitIntToFloatCast: instruction withInstruction: CVTSI2SD
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacInt32ToFloat: instruction [
	^ self emitIntToFloatCast: instruction withInstruction: CVTSI2SS
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacInt64ToDouble: instruction [
	target pointerSize = 8 ifTrue: [ 
		^ self emitIntToFloatCast: instruction withInstruction: CVTSI2SD
	].
	self halt

]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacInt64ToFloat: instruction [
	target pointerSize = 8 ifTrue: [ 
		^ self emitIntToFloatCast: instruction withInstruction: CVTSI2SS
	].
	self halt

]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacJumpInstruction: branch [
	| destination |
	destination := streamBuilder findSymbolForObject: branch destination.
	
	streamBuilder
		x86: JMP with: destination.
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacLess: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JL branchFalse: JGE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacLess: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JL destination: branch trueDestination branchFalse: JGE destination: branch falseDestination
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacLessOrEqual: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JLE branchFalse: JE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacLessOrEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JLE destination: branch trueDestination branchFalse: JG destination: branch falseDestination
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoad: instruction [
	| value pointer valueTemp |
	value := self virtualToPhysical: instruction result.
	pointer := self virtualToPhysical: instruction left pointerOfSize: target pointerSize scratchIndex: 0.
	(value isRegisterAddress and: [ pointer isRegisterAddress ]) ifTrue: [ 
		valueTemp := self scratchRegister: 0 for: value.
		streamBuilder
			x86: MOV dst: valueTemp src: pointer;
			x86: MOV dst: value src: valueTemp
	] ifFalse: [ 
		self assert: value isRegisterOrRegisterAddressWord.
		streamBuilder x86: MOV dst: value src: pointer
	]

	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadDouble: instruction [
	| value pointer valueTemp |
	value := self virtualToPhysical: instruction result.
	pointer := self virtualToPhysical: instruction left pointerOfSize: 8 scratchIndex: 0.
	pointer vectorRegister: true.
	(value isRegisterAddress and: [ pointer isRegisterAddress ]) ifTrue: [
		valueTemp := self scratchRegister: 0 for: value.
		streamBuilder
			x86: MOVSD dst: valueTemp src: pointer;
			x86: MOVSD dst: value src: valueTemp
	] ifFalse: [ 
		self assert: value isRegisterOrRegisterAddress.
		streamBuilder x86: MOVSD dst: value src: pointer
	]

	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadFloat: instruction [
	| value pointer valueTemp |
	value := self virtualToPhysical: instruction result.
	pointer := self virtualToPhysical: instruction left pointerOfSize: 4 scratchIndex: 0.
	pointer vectorRegister: true.
	(value isRegisterAddress and: [ pointer isRegisterAddress ]) ifTrue: [
		valueTemp := self scratchRegister: 0 for: value.
		streamBuilder
			x86: MOVSS dst: valueTemp src: pointer;
			x86: MOVSS dst: value src: valueTemp
	] ifFalse: [ 
		self assert: value isRegisterOrRegisterAddress.
		streamBuilder x86: MOVSS dst: value src: pointer
	]

	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadLocalAddress: instruction [
	| result variable scratch |
	result := self virtualToPhysical: instruction result.
	variable := self virtualToPhysical: instruction left.
	self assert: variable isRegisterAddress.
	result isRegisterAddress ifTrue: [ 
		scratch := self scratchRegister: 0 for: instruction result.
		streamBuilder
			x86: LEA dst: scratch src: variable;
			x86: MOV dst: result src: scratch
	] ifFalse: [ 
		streamBuilder x86: LEA dst: result src: variable
	]
	
	
	
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
	self emitLoad: instruction withExtension: MOVZX pointerSize: 4
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacLoadZeroExtend8: instruction [
	self emitLoad: instruction withExtension: MOVZX pointerSize: 1
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacLogicalNot: instruction [
	| resultPhysical tempRegister |
	instruction value ~= instruction result ifTrue: [
		self moveValue: instruction value toRegister: instruction result.
	].

	resultPhysical := self virtualToPhysical: instruction result.
	self assert: resultPhysical isRegisterOrRegisterAddress.

	instruction result isIntegerRegister ifTrue: [
		tempRegister := resultPhysical.
		resultPhysical isRegisterAddress ifTrue: [
			tempRegister := target pointerSize = 4 ifTrue: [ EAX ] ifFalse: [ RAX ].
			streamBuilder x86: MOV dst: tempRegister src: resultPhysical.
		].
		
		streamBuilder
			x86: NEG with: tempRegister;
			x86: SBB dst: tempRegister src: tempRegister;
			x86: INC with: tempRegister.
		resultPhysical isRegisterAddress ifTrue: [
			streamBuilder x86: MOV dst: resultPhysical src: tempRegister.
		].
		^ self
	].
	self error: 'Not yet supported'

]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacLogicalShiftLeft: instruction [
	self emitBitwiseShiftInto: instruction result value: instruction left amount: instruction right instruction: SHL
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacLogicalShiftRight: instruction [
	self emitBitwiseShiftInto: instruction result value: instruction left amount: instruction right instruction: SHR
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
	rightPhysical := self virtualToPhysical: instruction right scratchRegisterIndex: 1.
	
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
	^ self emitArithmeticUnaryInto: instruction result value: instruction value integer: NEG
]

{ #category : #comparisons }
SAsmX86InstructionLowerer >> visitTacNotEqual: instruction [
	^ self emitComparisonIntegerInto: instruction result left: instruction left right: instruction right 
			branchTrue: JNE branchFalse: JE
]

{ #category : #'conditional branchs' }
SAsmX86InstructionLowerer >> visitTacNotEqual: instruction withBranch: branch [
	^ self emitComparison: branch left: instruction left right: instruction right 
			branchTrue: JNE destination: branch trueDestination branchFalse: JE destination: branch falseDestination
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacReinterpretFloatAsInteger: instruction [
	| result value floatValue moveTemp |
	floatValue := instruction left.
	
	result := self virtualToPhysical: instruction result.
	value := self virtualToPhysical: floatValue.

	floatValue isFloatOperand ifTrue: [
		self halt
	].

	floatValue isDoubleFloatOperand ifTrue: [ 
		target pointerSize = 8 ifTrue: [
			result isRegister ifTrue: [
				streamBuilder x86: MOVD dst: result qword src: value.
			] ifFalse: [
				(value isRegisterAddress and: [result isRegisterAddress]) ifTrue: [
					moveTemp := self scratchRegister: 0 for: result.
					streamBuilder x86: MOV dst: moveTemp src: value.
					value := moveTemp
				].

				streamBuilder x86: MOV dst: result src: value
			].
		] ifFalse: [ 
			self halt
		]
	].

]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacReinterpretIntegerAsFloat: instruction [
	| result value floatValue moveTemp |
	floatValue := instruction result.
	
	result := self virtualToPhysical: floatValue.
	value := self virtualToPhysical: instruction left.

	floatValue isFloatOperand ifTrue: [
		self halt
	].

	floatValue isDoubleFloatOperand ifTrue: [ 
		target pointerSize = 8 ifTrue: [
			result isRegister ifTrue: [
				streamBuilder x86: MOVD dst: result src: value qword.
			] ifFalse: [
				(value isRegisterAddress and: [result isRegisterAddress]) ifTrue: [
					moveTemp := self scratchRegister: 0 for: result.
					streamBuilder x86: MOV dst: moveTemp src: value.
					value := moveTemp
				].

				streamBuilder x86: MOV dst: result src: value
			].
		] ifFalse: [ 
			self halt
		]
	].

]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacRemainder: instruction [
	self emitIntegerDivisionInto: instruction result dividend: instruction left divisor: instruction right instruction: IDIV resultRegisterIndex: 2 activeRegisters: instruction activeRegisters
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturn: returnInstruction [
	(function callingConvention hasContextMetadata or: [function contextMetaData isNotNil]) ifTrue: [
		self widowThisContextSpilling: (returnInstruction activeRegisters ifNil: [#()]).
	].

	self returnValue: returnInstruction left valueHigh: returnInstruction right.
	function exitPoint ifNil: [ 
		self emitExitPoint
	] ifNotNil: [
		streamBuilder x86: JMP with: (streamBuilder findSymbolForObject: function exitPoint)
	].
	
]

{ #category : #visiting }
SAsmX86InstructionLowerer >> visitTacReturnFromFrame: returnInstruction [
	| newFrame exitPoint returnValues physicalFrame |
	(function callingConvention hasContextMetadata or: [function contextMetaData isNotNil]) ifTrue: [
		self widowThisContextSpilling: returnInstruction activeRegisters.
	].

	newFrame := returnInstruction newFrame.
	exitPoint := returnInstruction exitPoint.
	returnValues := returnInstruction returnValues.
	
	returnValues size = 1 ifTrue: [ 
		self returnValue: returnValues first valueHigh: nil.
	] ifFalse: [
		self assert: returnValues size = 2.
		self returnValue: returnValues first valueHigh: returnValues second.
	].
	
	self pushValueToTheStack: exitPoint scratchIndex: 1.
	physicalFrame := self virtualToPhysical: newFrame.
	
	self flag: 'TODO: Allow adjusting the stack pointer'.
	streamBuilder
		x86: MOV dst: target framePointerRegister src: physicalFrame;
		x86: RET.

]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacRotateLeft: instruction [
	self emitBitwiseShiftInto: instruction result value: instruction left amount: instruction right instruction: ROL
]

{ #category : #'bitwise operations' }
SAsmX86InstructionLowerer >> visitTacRotateRight: instruction [
	self emitBitwiseShiftInto: instruction result value: instruction left amount: instruction right instruction: ROR
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
	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	pointer := self virtualToPhysical: instruction right pointerOfSize: target pointerSize scratchIndex: 1.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer src: value
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreDouble: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	pointer := self virtualToPhysical: instruction right pointerOfSize: target pointerSize scratchIndex: 1.
	pointer vectorRegister: true.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	self assert: value isRegisterAddress not.
	streamBuilder x86: MOVSD dst: pointer src: value
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreFloat: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	pointer := self virtualToPhysical: instruction right pointerOfSize: target pointerSize scratchIndex: 1.
	pointer vectorRegister: true.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	self assert: value isRegisterAddress not.
	streamBuilder x86: MOVSS dst: pointer src: value
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate16: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	pointer := self virtualToPhysical: instruction right pointerOfSize: 2 scratchIndex: 1.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	value isRegister ifTrue: [ value := value word ].
	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer word src: value
	
]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate32: instruction [
	| value pointer |
	target pointerSize = 4 ifTrue: [ ^ self visitTacStore: instruction ].

	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	pointer := self virtualToPhysical: instruction right pointerOfSize: 4 scratchIndex: 1.
	value isRegisterAddress ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	value isRegister ifTrue: [ value := value dword ].
	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer dword src: value

]

{ #category : #memory }
SAsmX86InstructionLowerer >> visitTacStoreTruncate8: instruction [
	| value pointer |
	value := self virtualToPhysical: instruction left scratchRegisterIndex: 0.
	pointer := self virtualToPhysical: instruction right pointerOfSize: 1 scratchIndex: 1.
	(value isRegisterAddress or: [ value isRegister and: [value canBeValidByteRegisters not ]]) ifTrue: [
		value := self movePhysical: value toScratchRegister: 0
	].

	value isRegister ifTrue: [ value := value byte ].
	self assert: value isRegisterAddress not.
	streamBuilder x86: MOV dst: pointer byte src: value
	
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacSubtract: instruction [
	^ self emitArithmeticInto: instruction result left: instruction left right: instruction right 
			integer: SUB
]

{ #category : #arithmetic }
SAsmX86InstructionLowerer >> visitTacUDivide: instruction [
	self emitIntegerDivisionInto: instruction result dividend: instruction left divisor: instruction right instruction: DIV resultRegisterIndex: 1 activeRegisters: instruction activeRegisters
]

{ #category : #casting }
SAsmX86InstructionLowerer >> visitTacUInt32ToDouble: instruction [
	self halt
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

{ #category : #visiting }
SAsmX86InstructionLowerer >> widowThisContextSpilling: activeRegisters [
	| doReturn widowThisContextFunction widowThisContextConvention registerArguments shadowSpace stackPadding stackRestoreSize |
	doReturn := streamBuilder newPrivateSymbol: #doReturn.
	widowThisContextFunction := self runtimeProvidedFunction: target objectModel widowThisContextFunction.
	streamBuilder
		x86: CMP dst: (target framePointerRegister asX86PointerOfSize: target pointerSize) + (ThisContextPointerIndex * target pointerSize) + contextMetadataOffset src: 0;
		x86: JZ with: doReturn.
	
	"Call the widowing function"	
	self spillRegisters: activeRegisters.
	widowThisContextConvention := target callingConventionNamed: #cdecl.
	registerArguments := widowThisContextConvention integerArgumentRegisters .
	registerArguments ifEmpty: [
		stackPadding := widowThisContextConvention stackAlignment - target pointerSize max: 0.
		stackRestoreSize := stackPadding + target pointerSize.
		stackPadding > 0 ifTrue: [ 
		streamBuilder
			x86: SUB dst: target stackPointerRegister src: stackPadding.
		].
	
		streamBuilder
			x86: PUSH with: target framePointerRegister;
			x86: CALL with: widowThisContextFunction;
			x86: ADD dst: target stackPointerRegister src: stackRestoreSize.
	] ifNotEmpty: [
		shadowSpace := widowThisContextConvention shadowCallSpaceSize.
		shadowSpace ~= 0 ifTrue: [
			streamBuilder x86: SUB dst: target stackPointerRegister src: shadowSpace.
		].

		streamBuilder
			x86: MOV dst: registerArguments first src: target framePointerRegister;
			x86: CALL with: widowThisContextFunction.
	
		shadowSpace ~= 0 ifTrue: [ 
			streamBuilder x86: ADD dst: target stackPointerRegister src: shadowSpace.
		].
	].
	self unspillRegisters: activeRegisters.
	
	streamBuilder
		label: doReturn
		
]
