Class {
	#name : #SAsmElf64Builder,
	#superclass : #SAsmElfBuilder,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'format classes' }
SAsmElf64Builder >> headerClass [
	^ SAsmElf64Header
]

{ #category : #'as yet unclassified' }
SAsmElf64Builder >> pointerAlignment [
	^ 8
]

{ #category : #'format classes' }
SAsmElf64Builder >> programHeaderClass [
	^ SAsmElf64ProgramHeader
]

{ #category : #'format classes' }
SAsmElf64Builder >> relocationTableClass [
	^ SAsmElf64RelocationTable
]

{ #category : #'format classes' }
SAsmElf64Builder >> relocationWithAddendTableClass [
	^ SAsmElf64RelocationTableWithAddend
]

{ #category : #'format classes' }
SAsmElf64Builder >> sectionHeaderClass [
	^ SAsmElf64SectionHeader
]

{ #category : #'format classes' }
SAsmElf64Builder >> stringTableClass [
	^ SAsmElfStringTable
]

{ #category : #'format classes' }
SAsmElf64Builder >> symbolTableClass [
	^ SAsmElf64SymbolTable
]

{ #category : #'format classes' }
SAsmElf64Builder >> symbolTableEntryClass [
	^ SAsmElf64SymbolTableEntry
]
