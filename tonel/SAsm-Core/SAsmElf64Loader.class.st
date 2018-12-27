Class {
	#name : #SAsmElf64Loader,
	#superclass : #SAsmElfLoader,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'format classes' }
SAsmElf64Loader >> headerClass [
	^ SAsmElf64Header
]

{ #category : #'format classes' }
SAsmElf64Loader >> relocationTableWithAddendsClass [
	^ SAsmElf64RelocationTableWithAddend
]

{ #category : #'format classes' }
SAsmElf64Loader >> relocationTableWithoutAddendsClass [
	^ SAsmElf64RelocationTable
]

{ #category : #'format classes' }
SAsmElf64Loader >> sectionHeaderClass [
	^ SAsmElf64SectionHeader
]

{ #category : #'format classes' }
SAsmElf64Loader >> symbolTableClass [
	^ SAsmElf64SymbolTable
]
