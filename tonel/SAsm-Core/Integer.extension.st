Extension { #name : #Integer }

{ #category : #'*SAsm-Core' }
Integer >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantInteger new value: self
]

{ #category : #'*SAsm-Core' }
Integer >> asSAsmInstructionOperand [
	^ SAsmImmediate new value: self
]
