Class {
	#name : #SAsmConstantExpressionCodeSize,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'value'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #copying }
SAsmConstantExpressionCodeSize >> copyWithStreamBuilder: aStreamBuilder [
	^ self copy value: (value copyWithStreamBuilder: aStreamBuilder)
]

{ #category : #'public access' }
SAsmConstantExpressionCodeSize >> evaluate [
	^ SAsmConstantExpressionConstantInteger new value: (value symbol size)
]

{ #category : #accessing }
SAsmConstantExpressionCodeSize >> value [
	^ value
]

{ #category : #accessing }
SAsmConstantExpressionCodeSize >> value: anObject [
	value := anObject asSAsmInstructionOperand
]
