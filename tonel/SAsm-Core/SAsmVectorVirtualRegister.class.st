Class {
	#name : #SAsmVectorVirtualRegister,
	#superclass : #SAsmVirtualRegister,
	#instVars : [
		'elementSize'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #testing }
SAsmVectorVirtualRegister >> isVectorRegister [
	^ true
]
