Class {
	#name : #SAsmX86Register,
	#superclass : #SAsmRegister,
	#instVars : [
		'name',
		'value'
	],
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-X86'
}

{ #category : #testing }
SAsmX86Register >> isHighRegister [
	^ value > 7
]

{ #category : #testing }
SAsmX86Register >> isLowRegister [
	^ value <= 7
]

{ #category : #accessing }
SAsmX86Register >> name [
	^ name
]

{ #category : #accessing }
SAsmX86Register >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SAsmX86Register >> size [
	^ self subclassResponsibility
]

{ #category : #accessing }
SAsmX86Register >> value [
	^ value
]

{ #category : #accessing }
SAsmX86Register >> value: anObject [
	value := anObject
]
