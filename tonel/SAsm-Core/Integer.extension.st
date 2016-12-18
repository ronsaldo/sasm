Extension { #name : #Integer }

{ #category : #'*SAsm-Core' }
Integer >> asSAsmConstantExpression [
	^ SAsmConstantExpressionConstantInteger new value: self
]
