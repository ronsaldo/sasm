Class {
	#name : #SAsmTacBranchOperation,
	#superclass : #SAsmTacOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #'as yet unclassified' }
SAsmTacBranchOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacBranch: anInstruction
]

{ #category : #'as yet unclassified' }
SAsmTacBranchOperation >> mnemonic [
	^ #branch
]
