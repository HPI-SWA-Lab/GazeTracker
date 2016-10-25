accessing
fixationPoint

	^ fixationPoint ifNil: [fixationPoint := self position]