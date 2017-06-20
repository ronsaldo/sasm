Class {
	#name : #SAsmConstantExpressionConstantIntegerSLEB128,
	#superclass : #SAsmConstantExpressionConstant,
	#instVars : [
		'size'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #printing }
SAsmConstantExpressionConstantIntegerSLEB128 >> fullPrintOn: aStream [
	aStream putKeyword: #sleb128; space; putNumber: value
]
