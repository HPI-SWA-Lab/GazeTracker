as yet unclassified
updateTarget: aMorph
	| timeDiff |
	aMorph ifNil: [^ 0].
	timeDiff := 0.
	lastTargetTime ifNil: [lastTargetTime := Time millisecondClockValue].
	
	lastTarget ~= aMorph ifTrue: [ 
		timeDiff := Time millisecondsSince: lastTargetTime.
		lastTargetTime := Time millisecondClockValue.
		lastTarget := aMorph ].
	^ timeDiff
	
	