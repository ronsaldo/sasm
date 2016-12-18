Class {
	#name : #SAsmModuleElement,
	#superclass : #SAsmObject,
	#category : #'SAsm-Core-Generic'
}

{ #category : #'as yet unclassified' }
SAsmModuleElement >> writeToStream: aStreamBuilder [
	self subclassResponsibility
]
