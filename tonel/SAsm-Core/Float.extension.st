Extension { #name : #Float }

{ #category : #'*SAsm-Core' }
Float >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantFloat new value: self
]
