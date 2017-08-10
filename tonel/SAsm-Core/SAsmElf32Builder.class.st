Class {
	#name : #SAsmElf32Builder,
	#superclass : #SAsmElfBuilder,
	#category : #'SAsm-Core-Elf'
}

{ #category : #'format classes' }
SAsmElf32Builder >> headerClass [
	^ SAsmElf32Header
]

{ #category : #accessing }
SAsmElf32Builder >> pointerAlignment [
	^ 4
]

{ #category : #'format classes' }
SAsmElf32Builder >> programHeaderClass [
	^ SAsmElf32ProgramHeader
]

{ #category : #'format classes' }
SAsmElf32Builder >> relocationTableClass [
	^ SAsmElf32RelocationTable
]

{ #category : #'format classes' }
SAsmElf32Builder >> relocationWithAddendTableClass [
	^ SAsmElf32RelocationTableWithAddend
]

{ #category : #'format classes' }
SAsmElf32Builder >> sectionHeaderClass [
	^ SAsmElf32SectionHeader
]

{ #category : #'format classes' }
SAsmElf32Builder >> stringTableClass [
	^ SAsmBinaryFileCStringTable
]

{ #category : #'format classes' }
SAsmElf32Builder >> symbolTableClass [
	^ SAsmElf32SymbolTable
]

{ #category : #'format classes' }
SAsmElf32Builder >> symbolTableEntryClass [
	^ SAsmElf32SymbolTableEntry
]
