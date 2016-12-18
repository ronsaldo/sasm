Class {
	#name : #SAsmConstantExpressionConstantInteger,
	#superclass : #SAsmConstantExpressionConstant,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmConstantExpressionConstantInteger >> writeWithSize: size on: writer [
	| temp |
	temp := value.
	1 to: size do: [ :i |
		writer nextPut: temp & 16rff.
		temp := temp >> 8
	].
]
