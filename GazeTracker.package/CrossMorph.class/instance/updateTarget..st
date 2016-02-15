as yet unclassified
updateTarget: aNewTarget
	self newTarget: aNewTarget.
	aNewTarget ~= self lastTarget
		ifTrue: [
			self resetTimer ].
	self lastTarget: self newTarget.
	^ Time millisecondsSince: self lastTargetChangeTime