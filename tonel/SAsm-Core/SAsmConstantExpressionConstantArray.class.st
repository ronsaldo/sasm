Class {
	#name : #SAsmConstantExpressionConstantArray,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'size',
		'elementSize',
		'elementAlignment',
		'slots'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #copying }
SAsmConstantExpressionConstantArray >> copyWithStreamBuilder: aStreamBuilder [
	^ self copy slots: (slots collect: [:slot | slot copyWithStreamBuilder: aStreamBuilder ])
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> elementAlignment [
	^ elementAlignment
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> elementAlignment: anObject [
	elementAlignment := anObject
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> elementSize [
	^ elementSize
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> elementSize: anObject [
	elementSize := anObject
]

{ #category : #'public access' }
SAsmConstantExpressionConstantArray >> evaluate [
	^ self
]

{ #category : #printing }
SAsmConstantExpressionConstantArray >> fullPrintOn: aStream [
	aStream putKeyword: 'array'; nextPutAll: ' {'; lf.
	aStream withExtraIndentationLevel: [
		slots do: [ :slot | slot fullPrintOn: aStream. aStream nextPutAll: ', ' ]
	].
	aStream lf; nextPutAll: '}'.
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> slots [
	^ slots
]

{ #category : #accessing }
SAsmConstantExpressionConstantArray >> slots: anObject [
	slots := anObject
]

{ #category : #writing }
SAsmConstantExpressionConstantArray >> writeWithSize: valueSize on: writer [
	| currentPosition slotSize slotAlignment alignedPosition |
	currentPosition := 0.
	slots doWithIndex: [ :slot :index |
		slotSize := slot size.
		self assert: slotSize <= elementSize.
		
		"Align the slot"
		alignedPosition := currentPosition alignedTo: elementAlignment.
		writer nextPutZeros: alignedPosition - currentPosition.
		currentPosition := alignedPosition.
		
		"Write the slot"
		slot writeWithSize: slotSize on: writer.
		currentPosition := currentPosition + slotSize.
	].

	"Extra padding"
	alignedPosition := currentPosition alignedTo: elementAlignment.
	writer nextPutZeros: alignedPosition - currentPosition.
]
