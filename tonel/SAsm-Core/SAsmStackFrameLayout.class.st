Class {
	#name : #SAsmStackFrameLayout,
	#superclass : #Object,
	#instVars : [
		'localVariables',
		'alignment',
		'size',
		'arguments',
		'argumentsBaseOffset',
		'localsBaseOffset',
		'frameLessMethod',
		'argumentsSize',
		'dynamicRootCount',
		'reservedLocalsSpace',
		'optimizedLocalVariables',
		'stackAlignment',
		'argumentsAlignment',
		'explicitDynamicRootCount'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #adding }
SAsmStackFrameLayout >> addLocalReservedSpace: extraReservedSpace [
	reservedLocalsSpace := reservedLocalsSpace + extraReservedSpace
]

{ #category : #accessing }
SAsmStackFrameLayout >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmStackFrameLayout >> arguments [
	^ arguments
]

{ #category : #accessing }
SAsmStackFrameLayout >> argumentsBaseOffset [
	^ argumentsBaseOffset
]

{ #category : #accessing }
SAsmStackFrameLayout >> argumentsBaseOffset: anObject [
	argumentsBaseOffset := anObject
]

{ #category : #accessing }
SAsmStackFrameLayout >> argumentsSize [
	^ argumentsSize
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> buildArgumentLayout [
	argumentsSize := 0.
	argumentsAlignment := stackAlignment.
	arguments select: [:arg | arg argumentPassingRegister isNil] thenDo: [ :var |
		argumentsAlignment := argumentsAlignment max: var alignment.
		argumentsSize := argumentsSize alignedTo: var alignment.
		var offset: argumentsSize + argumentsBaseOffset.
		argumentsSize := argumentsSize + var size.
	].
	argumentsSize := argumentsSize alignedTo: argumentsAlignment
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> buildLayout [
	self
		buildArgumentLayout;
		buildLocalLayout
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> buildLocalLayout [
	optimizedLocalVariables sort: [ :a :b |
		a dynamicRoot ~= b dynamicRoot ifTrue: [ 
			a dynamicRoot asBit >= b dynamicRoot asBit
		] ifFalse: [ 
			a explicitLocalVariable ~= b explicitLocalVariable ifTrue: [ 
				a explicitLocalVariable asBit >= b explicitLocalVariable asBit
			] ifFalse: [ 
				a alignment <= b alignment
			]
		]
	].

	alignment := stackAlignment.
	size := reservedLocalsSpace.
	dynamicRootCount := 0.
	explicitDynamicRootCount := 0.
	optimizedLocalVariables do: [ :var |
		var dynamicRoot ifTrue: [ 
			dynamicRootCount := dynamicRootCount + 1.
			var explicitLocalVariable ifTrue: [ 
				explicitDynamicRootCount := explicitDynamicRootCount + 1.
			].
		].
	
		alignment := alignment max: var alignment.
		size := size alignedTo: var alignment.
		size := size + var size.
		var offset: (size - localsBaseOffset) negated.
	].

	size := size alignedTo: stackAlignment.
	(dynamicRootCount > 0 and: [dynamicRootCount ~= localVariables size ]) ifTrue: [
		self assert: optimizedLocalVariables first dynamicRoot
	]

]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> createArgument: argSize alignment: argAlignment dynamicRoot: dynamicRoot registerClass: argumentRegisterClass [
	| result |
	result := SAsmVariable new
		index: arguments size + 1;
		size: argSize;
		alignment: argAlignment;
		dynamicRoot: dynamicRoot;
		argumentRegisterClass: argumentRegisterClass;
		argument: true;
		yourself.
	arguments add: result.
	^ result
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> createArgument: spillingClass registerClass: argumentRegisterClass [
	^ self createArgument: spillingClass first alignment: spillingClass second dynamicRoot: spillingClass third registerClass: argumentRegisterClass
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> createArgument: spillingClass registerClass: argumentRegisterClass dynamicRoot: dynamicRootOverride [
	^ self createArgument: spillingClass first alignment: spillingClass second dynamicRoot: (spillingClass third or: [dynamicRootOverride]) registerClass: argumentRegisterClass
]

{ #category : #'register allocation' }
SAsmStackFrameLayout >> createLocal: spillingClass [
	^ self createLocalSize: spillingClass first alignment: spillingClass second dynamicRoot: spillingClass third
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> createLocalSize: localSize alignment: localAlignment dynamicRoot: dynamicRoot [
	| result |
	result := SAsmVariable new
		index: localVariables size + 1;
		size: localSize;
		alignment: localAlignment;
		dynamicRoot: dynamicRoot;
		yourself.
	localVariables add: result.
	^ result
]

{ #category : #accessing }
SAsmStackFrameLayout >> dynamicRootCount [
	^ dynamicRootCount
]

{ #category : #accessing }
SAsmStackFrameLayout >> explicitDynamicRootCount [
	^ explicitDynamicRootCount
]

{ #category : #accessing }
SAsmStackFrameLayout >> frameLessMethod [
	^ frameLessMethod
]

{ #category : #accessing }
SAsmStackFrameLayout >> frameLessMethod: anObject [
	frameLessMethod := anObject
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> importVariable: variable [
	variable argument ifTrue: [ 
		^ arguments at: variable index.
	] ifFalse: [ 
		^ localVariables at: variable index.
	]
]

{ #category : #initialization }
SAsmStackFrameLayout >> initialize [
	localVariables := OrderedCollection new.
	arguments := OrderedCollection new.
	argumentsBaseOffset := 0.
	reservedLocalsSpace := 0.
	localsBaseOffset := 0.
	frameLessMethod := false.
]

{ #category : #accessing }
SAsmStackFrameLayout >> localVariables [
	^ localVariables
]

{ #category : #accessing }
SAsmStackFrameLayout >> localsBaseOffset [
	^ localsBaseOffset
]

{ #category : #accessing }
SAsmStackFrameLayout >> localsBaseOffset: anObject [
	localsBaseOffset := anObject
]

{ #category : #optimizing }
SAsmStackFrameLayout >> optimize [
	optimizedLocalVariables := (arguments select: [:arg | arg argumentPassingRegister isNotNil]) , (localVariables select: #actuallyUsed)
]

{ #category : #'as yet unclassified' }
SAsmStackFrameLayout >> optimizeAndBuildLayout [
	self
		optimize;
		buildLayout
]

{ #category : #accessing }
SAsmStackFrameLayout >> optimizedLocalVariables [
	^ optimizedLocalVariables
]

{ #category : #copying }
SAsmStackFrameLayout >> postCopy [
	arguments := arguments collect: #copy.
	localVariables := localVariables collect: #copy
]

{ #category : #accessing }
SAsmStackFrameLayout >> reservedLocalsSpace [
	^ reservedLocalsSpace
]

{ #category : #accessing }
SAsmStackFrameLayout >> reservedLocalsSpace: anObject [
	reservedLocalsSpace := anObject
]

{ #category : #accessing }
SAsmStackFrameLayout >> size [
	^ size
]

{ #category : #accessing }
SAsmStackFrameLayout >> stackAlignment [
	^ stackAlignment
]

{ #category : #accessing }
SAsmStackFrameLayout >> stackAlignment: anObject [
	stackAlignment := anObject
]
