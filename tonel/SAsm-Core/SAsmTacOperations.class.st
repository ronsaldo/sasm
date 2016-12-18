Class {
	#name : #SAsmTacOperations,
	#superclass : #SharedPool,
	#classVars : [
		'TacAdd',
		'TacCall',
		'TacDivide',
		'TacMove',
		'TacMultiply',
		'TacReturn',
		'TacSubtract'
	],
	#category : #'SAsm-Core-TAC'
}

{ #category : #'class initialization' }
SAsmTacOperations class >> initialize [
	super initialize.
	
	TacAdd := SAsmTacOperationAdd new.
	TacDivide := SAsmTacOperationDivide new.
	TacMultiply := SAsmTacOperationMultiply new.
	TacSubtract := SAsmTacOperationSubtract new.
	
	TacCall := SAsmTacCallOperation new.
	TacMove := SAsmTacMoveOperation new.
	TacReturn := SAsmTacReturnOperation new.
]
