Class {
	#name : #SAsmElfMachineRelocationParser,
	#superclass : #Object,
	#pools : [
		'SAsmX86Constants'
	],
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElfMachineRelocationParser class >> machineType [
	^ nil
]

{ #category : #'as yet unclassified' }
SAsmElfMachineRelocationParser >> compilationTargetForElfHeader: elfHeader [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SAsmElfMachineRelocationParser >> convertElfRelocation: elfRelocation typeInto: relocation [
	self subclassResponsibility
]
