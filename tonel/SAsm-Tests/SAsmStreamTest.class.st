"
A SAsmStreamTest is a test class for testing the behavior of SAsmStream
"
Class {
	#name : #SAsmStreamTest,
	#superclass : #TestCase,
	#category : #'SAsm-Tests'
}

{ #category : #tests }
SAsmStreamTest >> testAdd [
	| stream element1 element2 element3 |
	stream := SAsmStream new.
	element1 := SAsmStreamElement new.
	element2 := SAsmStreamElement new.
	element3 := SAsmStreamElement new.
	stream add: element1.
	stream add: element2.
	stream addFirst: element3.
	
	self assert: stream first == element3.
	self assert: stream first next == element1.
	self assert: stream first next next == element2.
	self assert: stream last == element2.
	self assert: stream last previous == element1.
	self assert: stream last previous previous == element3.
	self assert: stream isNotEmpty.
]

{ #category : #tests }
SAsmStreamTest >> testNew [
	| stream |
	stream := SAsmStream new.
	self assert: stream isEmpty.
	self assert: stream isNotEmpty not.
]
