Extension { #name : #Float }

{ #category : #'*SAsm-Core' }
Float >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantFloat new value: self
]

{ #category : #'*SAsm-Core' }
Float >> asSAsmInstructionOperand [
	^ SAsmImmediateConstant new value: self
]
