Class {
	#name : #SAsmConstantExpressionConstantStructure,
	#superclass : #SAsmConstantExpression,
	#instVars : [
		'size',
		'alignment',
		'slots',
		'slotAlignments'
	],
	#category : #'SAsm-Core-Generic'
}

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> alignment [
	^ alignment
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> alignment: anObject [
	alignment := anObject
]

{ #category : #copying }
SAsmConstantExpressionConstantStructure >> copyWithStreamBuilder: aStreamBuilder [
	^ self copy slots: (slots collect: [:slot | slot copyWithStreamBuilder: aStreamBuilder ])
]

{ #category : #'public access' }
SAsmConstantExpressionConstantStructure >> evaluate [
	^ self
]

{ #category : #printing }
SAsmConstantExpressionConstantStructure >> fullPrintOn: aStream [
	aStream putKeyword: 'structure'; nextPutAll: ' {'; lf.
	aStream withExtraIndentationLevel: [
		slots do: [ :slot | slot fullPrintOn: aStream. aStream nextPutAll: ', ' ]
	].
	aStream lf; nextPutAll: '}'.
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> size [
	^ size
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> size: anObject [
	size := anObject
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> slotAlignments [
	^ slotAlignments
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> slotAlignments: anObject [
	slotAlignments := anObject
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> slots [
	^ slots
]

{ #category : #accessing }
SAsmConstantExpressionConstantStructure >> slots: anObject [
	slots := anObject
]

{ #category : #writing }
SAsmConstantExpressionConstantStructure >> writeWithSize: valueSize on: writer [
	| currentPosition slotSize slotAlignment alignedPosition |
	currentPosition := 0.
	slots doWithIndex: [ :slot :index |
		slotSize := slot size.
		slotAlignment := slotAlignments at: index.
		
		"Align the slot"
		alignedPosition := currentPosition alignedTo: slotAlignment.
		writer nextPutZeros: alignedPosition - currentPosition.
		currentPosition := alignedPosition.
		
		"Write the slot"
		slot writeWithSize: slotSize on: writer.
		currentPosition := currentPosition + slotSize.
	].

	"Extra padding"
	alignedPosition := currentPosition alignedTo: alignment.
	writer nextPutZeros: alignedPosition - currentPosition.
]
