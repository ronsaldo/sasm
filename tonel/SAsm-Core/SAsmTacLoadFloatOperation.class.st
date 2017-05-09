Class {
	#name : #SAsmTacLoadFloatOperation,
	#superclass : #SAsmTacLoadOperation,
	#category : #'SAsm-Core-TAC'
}

{ #category : #visiting }
SAsmTacLoadFloatOperation >> acceptInstruction: anInstruction with: aVisitor [
	^ aVisitor visitTacLoadFloat: anInstruction
]

{ #category : #printing }
SAsmTacLoadFloatOperation >> mnemonic [
	^ #loadf
]
