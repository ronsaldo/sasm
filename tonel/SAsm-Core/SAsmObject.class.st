Class {
	#name : #SAsmObject,
	#superclass : #Object,
	#category : #'SAsm-Core-Generic'
}

{ #category : #printing }
SAsmObject >> fullPrintOn: aStream [
	self printOn: aStream
]

{ #category : #printing }
SAsmObject >> fullPrintString [
	^ SAsmPrintingStream fullPrintString: self
]

{ #category : #printing }
SAsmObject >> fullPrintText [
	^ SAsmPrintingTextStream fullPrintString: self
]
