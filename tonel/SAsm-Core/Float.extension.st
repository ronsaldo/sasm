Extension { #name : #Float }

{ #category : #'*SAsm-Core' }
Float >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantFloat new value: self
]

{ #category : #'*SAsm-Core' }
Float >> asSAsmInstructionOperand [
	^ SAsmImmediate new value: self
]
