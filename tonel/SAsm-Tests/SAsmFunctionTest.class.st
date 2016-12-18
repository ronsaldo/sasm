"
A SAsmFunctionTest is a test class for testing the behavior of SAsmFunction
"
Class {
	#name : #SAsmFunctionTest,
	#superclass : #TestCase,
	#category : #'SAsm-Tests'
}

{ #category : #tests }
SAsmFunctionTest >> testNew [
	| function |
	function := SAsmFunction new.
	self assert: function basicBlocks isEmpty.
]
