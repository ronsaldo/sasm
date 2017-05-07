Class {
	#name : #SAsmConstantExpressionConstantBlob,
	#superclass : #SAsmConstantExpressionConstant,
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmConstantExpressionConstantBlob >> size [
	^ value size
]

{ #category : #writing }
SAsmConstantExpressionConstantBlob >> writeWithSize: size on: writer [
	self assert: value size = size.
	writer nextPutAll: value.
]
