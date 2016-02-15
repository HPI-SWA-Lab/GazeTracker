as yet unclassified
setLabelStarted: aBoolean
	aBoolean
		ifTrue: [self label: 'Stop GazeTracker'.]
		ifFalse: [self label: 'Start GazeTracker'.]