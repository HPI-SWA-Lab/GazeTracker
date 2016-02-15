as yet unclassified
readLineFromStdIn
	|a s lineEndFound |
	s := ''.
	lineEndFound := false.
	[lineEndFound] whileFalse: [
		a := FileStream stdin next.
		a ifNotNil: [
			a = Character cr
				ifTrue: [lineEndFound := true.]
				ifFalse: [s := s , a asString] ] ].
	^ s