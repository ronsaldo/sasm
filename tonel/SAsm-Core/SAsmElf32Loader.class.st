Class {
	#name : #SAsmElf32Loader,
	#superclass : #SAsmElfLoader,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'as yet unclassified' }
SAsmElf32Loader >> headerClass [
	^ SAsmElf32Header
]

{ #category : #'format classes' }
SAsmElf32Loader >> relocationTableWithAddendsClass [
	^ SAsmElf32RelocationTableWithAddend
]

{ #category : #'format classes' }
SAsmElf32Loader >> relocationTableWithoutAddendsClass [
	^ SAsmElf32RelocationTable
]

{ #category : #'format classes' }
SAsmElf32Loader >> sectionHeaderClass [
	^ SAsmElf32SectionHeader
]

{ #category : #'format classes' }
SAsmElf32Loader >> symbolTableClass [
	^ SAsmElf32SymbolTable
]
