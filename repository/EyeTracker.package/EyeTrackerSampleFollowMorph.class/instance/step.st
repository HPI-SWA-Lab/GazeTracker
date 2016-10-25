submorphs-add/remove
step

	| direction |
	direction :=  (self fixationPoint - self center).
	direction isZero ifTrue: [^ self].

	(self boundsInWorld containsPoint: self fixationPoint) ifTrue: [^ self].
	
	self positionInternal: self center + (direction normalized * 10).
	self center: self positionInternal.