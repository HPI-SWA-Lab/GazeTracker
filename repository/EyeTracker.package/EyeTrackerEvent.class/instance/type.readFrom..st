initialize
type: eventType readFrom: aStream
	| x y m |
	type := eventType.
	
	timeStamp := Integer readFrom: aStream.
	aStream skip: 1.
	
	x := Integer readFrom: aStream.
	aStream skip: 1.
	y := Integer readFrom: aStream.
	aStream skip: 1.
	position := x@y.
	
	m := String streamContents:
		[:s | | c |   [(c := aStream next) isLetter] whileTrue: [s nextPut: c]].
	mode := m asSymbol.
	
	buttons := Integer readFrom: aStream.