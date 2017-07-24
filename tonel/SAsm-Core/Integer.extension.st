Extension { #name : #Integer }

{ #category : #'*SAsm-Core' }
Integer >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantInteger new value: self
]

{ #category : #'*SAsm-Core' }
Integer >> asSAsmInstructionOperand [
	^ SAsmImmediateConstant new value: self
]

{ #category : #'*SAsm-Core' }
Integer >> sasmOperandHasFixedSize [
	^ true
]
