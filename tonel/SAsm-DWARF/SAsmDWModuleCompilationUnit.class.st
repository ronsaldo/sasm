Class {
	#name : #SAsmDWModuleCompilationUnit,
	#superclass : #SAsmModuleElement,
	#instVars : [
		'compilationUnit'
	],
	#category : #'SAsm-DWARF'
}

{ #category : #building }
SAsmDWModuleCompilationUnit >> build: aBlock [
	compilationUnit := SAsmDWBuilder new compileUnit: aBlock
]

{ #category : #accessing }
SAsmDWModuleCompilationUnit >> compilationUnit [
	^ compilationUnit
]

{ #category : #accessing }
SAsmDWModuleCompilationUnit >> compilationUnit: anObject [
	compilationUnit := anObject
]

{ #category : #testing }
SAsmDWModuleCompilationUnit >> isLastElement [
	^ true
]

{ #category : #writing }
SAsmDWModuleCompilationUnit >> prepareWriteToStream: streamBuilder [
]

{ #category : #writing }
SAsmDWModuleCompilationUnit >> writeToStream: streamBuilder [
	SAsmDWModuleCompilationUnitWriter new writeCompilationUnit: compilationUnit toStream: streamBuilder pointerSize: target pointerSize

]
