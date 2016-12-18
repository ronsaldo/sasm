Class {
	#name : #SAsmVirtualRegister,
	#superclass : #SAsmRegister,
	#instVars : [
		'registerClass',
		'index',
		'firstUsage',
		'lastUsage',
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmVirtualRegister >> firstUsage [
	^ firstUsage
]

{ #category : #accessing }
SAsmVirtualRegister >> firstUsage: anObject [
	firstUsage := anObject
]

{ #category : #accessing }
SAsmVirtualRegister >> index [
	^ index
]

{ #category : #accessing }
SAsmVirtualRegister >> index: anObject [
	index := anObject
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

{ #category : #accessing }
SAsmVirtualRegister >> prettyPrintOn: aStream [
	aStream putKeyword: '<'; putKeyword: self typeName; putKeyword: size asString;putKeyword: '>'; print: index
]

{ #category : #accessing }
SAsmVirtualRegister >> printOn: aStream [
	aStream nextPut: $<; nextPutAll: self typeName; print:size; nextPut: $>; print: index
]

{ #category : #accessing }
SAsmVirtualRegister >> registerClass [
	^ registerClass
]

{ #category : #accessing }
SAsmVirtualRegister >> registerClass: anObject [
	registerClass := anObject
]

{ #category : #accessing }
SAsmVirtualRegister >> size [
	^ size
]

{ #category : #accessing }
SAsmVirtualRegister >> size: anObject [
	size := anObject
]
