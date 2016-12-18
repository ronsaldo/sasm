"
A SAsmModuleTest is a test class for testing the behavior of SAsmModule
"
Class {
	#name : #SAsmModuleTest,
	#superclass : #TestCase,
	#category : #'SAsm-Tests'
}

{ #category : #'as yet unclassified' }
SAsmModuleTest >> testNew [
	| module |
	module := SAsmModule new.
	self assert: module elements isEmpty.
]
