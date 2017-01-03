Class {
	#name : #SAsmVirtualRegister,
	#superclass : #SAsmRegister,
	#instVars : [
		'registerClass',
		'index',
		'firstUsage',
		'lastUsage',
		'size',
		'register',
		'spillLocation',
		'variable',
		'variableOffset',
		'dynamicRoot'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmVirtualRegister >> < other [
	firstUsage == other firstUsage ifTrue: [ 
		^ lastUsage < other lastUsage
	].

	^ firstUsage < other firstUsage
]

{ #category : #testing }
SAsmVirtualRegister >> <= other [
	firstUsage == other firstUsage ifTrue: [ 
		^ lastUsage <= other lastUsage
	].

	^ firstUsage <= other firstUsage
]

{ #category : #accessing }
SAsmVirtualRegister >> end [
	^ lastUsage
]

{ #category : #accessing }
SAsmVirtualRegister >> firstUsage [
	^ firstUsage
]

{ #category : #accessing }
SAsmVirtualRegister >> firstUsage: anObject [
	firstUsage := anObject
]

{ #category : #testing }
SAsmVirtualRegister >> hasValidLiveRange [
	^ firstUsage isNotNil and: [ lastUsage isNotNil ]
]

{ #category : #accessing }
SAsmVirtualRegister >> index [
	^ index
]

{ #category : #accessing }
SAsmVirtualRegister >> index: anObject [
	index := anObject
]

{ #category : #initialization }
SAsmVirtualRegister >> initialize [
	super initialize.
	dynamicRoot := false.
	variableOffset := 0.
]

{ #category : #testing }
SAsmVirtualRegister >> isVirtualRegister [
	^ true
]

{ #category : #accessing }
SAsmVirtualRegister >> lastUsage [
	^ lastUsage
]

{ #category : #accessing }
SAsmVirtualRegister >> lastUsage: anObject [
	lastUsage := anObject
]

{ #category : #'live ranges' }
SAsmVirtualRegister >> markVirtualRegisterLiveRangePosition: position [
	firstUsage ifNil: [
		firstUsage := position.
		lastUsage := position.
	] ifNotNil: [
		firstUsage := firstUsage min: position.
		lastUsage := lastUsage max: position
	]
]

{ #category : #accessing }
SAsmVirtualRegister >> prettyPrintOn: aStream [
	aStream putKeyword: '<'; putKeyword: self typeName; putKeyword: size asString;putKeyword: '>'; print: index
]

{ #category : #accessing }
SAsmVirtualRegister >> printOn: aStream [
	aStream nextPut: $<; nextPutAll: self typeName; print:size; nextPut: $>; print: index
]

{ #category : #accessing }
SAsmVirtualRegister >> register [
	^ register
]

{ #category : #accessing }
SAsmVirtualRegister >> register: anObject [
	register := anObject
]

{ #category : #accessing }
SAsmVirtualRegister >> registerClass [
	^ registerClass
]

{ #category : #accessing }
SAsmVirtualRegister >> registerClass: anObject [
	registerClass := anObject
]

{ #category : #'live ranges' }
SAsmVirtualRegister >> resetRange [
	firstUsage := lastUsage := nil.
]

{ #category : #accessing }
SAsmVirtualRegister >> size [
	^ size
]

{ #category : #accessing }
SAsmVirtualRegister >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmVirtualRegister >> spillLocation [
	^ spillLocation
]

{ #category : #accessing }
SAsmVirtualRegister >> spillLocation: anObject [
	spillLocation := anObject.
	spillLocation ifNotNil: [ spillLocation addVirtualRegister: self ]
]

{ #category : #accessing }
SAsmVirtualRegister >> spillingClass [
	^ {size . size . dynamicRoot }
]

{ #category : #accessing }
SAsmVirtualRegister >> start [
	^ firstUsage
]

{ #category : #accessing }
SAsmVirtualRegister >> variable [
	^ variable
]

{ #category : #accessing }
SAsmVirtualRegister >> variable: anObject [
	variable := anObject
]

{ #category : #accessing }
SAsmVirtualRegister >> variableOffset [
	^ variableOffset
]

{ #category : #accessing }
SAsmVirtualRegister >> variableOffset: anObject [
	variableOffset := anObject
]
