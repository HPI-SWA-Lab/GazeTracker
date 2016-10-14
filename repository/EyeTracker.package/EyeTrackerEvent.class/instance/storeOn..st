printing
storeOn: aStream

	aStream nextPutAll: type.
	aStream space.
	self timeStamp storeOn: aStream.
	aStream space.
	position x storeOn: aStream.
	aStream space.
	position y storeOn: aStream.
	aStream space.
	aStream nextPutAll: mode.
	aStream space.
	buttons storeOn: aStream.