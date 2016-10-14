printing
printOn: aStream

	aStream nextPut: $[.
	aStream nextPutAll: self fixationPoint printString; space.
	aStream nextPutAll: self position printString; space.
	aStream nextPutAll: self type; space.
	aStream nextPutAll: self mode; space.	
	aStream nextPutAll: self modifierString.
	aStream nextPutAll: timeStamp printString.
	aStream nextPut: $].