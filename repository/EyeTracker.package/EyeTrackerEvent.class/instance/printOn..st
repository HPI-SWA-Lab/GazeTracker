printing
printOn: aStream

	aStream nextPut: $[.
	aStream nextPutAll: self position printString; space.
	aStream nextPutAll: type; space.
	aStream nextPutAll: mode; space.
	aStream nextPutAll: self modifierString.
	aStream nextPutAll: timeStamp printString.
	aStream nextPut: $].