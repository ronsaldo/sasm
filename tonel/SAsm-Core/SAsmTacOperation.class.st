Class {
	#name : #SAsmTacOperation,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacOperation >> acceptCondition: aCondition withBranch: aBranch asConditionWith: aVisitor [
	self subclassResponsibility
]

{ #category : #visiting }
SAsmTacOperation >> acceptInstruction: anInstruction with: aVisitor [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
SAsmTacOperation >> isCondition [
	^ false
]

{ #category : #testing }
SAsmTacOperation >> isIntegerDivision [
	^ false
]

{ #category : #testing }
SAsmTacOperation >> isIntegerRemainder [
	^ false
]

{ #category : #testing }
SAsmTacOperation >> isReturn [
	^ false
]

{ #category : #printing }
SAsmTacOperation >> mnemonic [
	^ self subclassResponsibility
]

{ #category : #printing }
SAsmTacOperation >> prettyPrintOn: aStream [
	aStream putKeyword: self mnemonic
]

{ #category : #printing }
SAsmTacOperation >> printOn: aStream [
	aStream nextPutAll: self mnemonic
]
