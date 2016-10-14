printing
storeOn: aStream
	super storeOn: aStream.
	aStream space.
	self fixationPoint x storeOn: aStream.
	aStream space.
	self fixationPoint y storeOn: aStream.
	aStream space.
