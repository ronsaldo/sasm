Class {
	#name : #SAsmTacOperations,
	#superclass : #SharedPool,
	#classVars : [
		'TacAdd',
		'TacCall',
		'TacDivide',
		'TacEqual',
		'TacGreater',
		'TacGreaterOrEqual',
		'TacLess',
		'TacLessOrEqual',
		'TacMove',
		'TacMultiply',
		'TacNotEqual',
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

	TacEqual := SAsmTacComparisonOperationEqual new.
	TacNotEqual := SAsmTacComparisonOperationNotEqual new.
	TacGreater := SAsmTacComparisonOperationGreater new.
	TacGreaterOrEqual := SAsmTacComparisonOperationGreaterOrEqual new.	
	TacLess := SAsmTacComparisonOperationLess new.
	TacLessOrEqual := SAsmTacComparisonOperationLessOrEqual new.
]
