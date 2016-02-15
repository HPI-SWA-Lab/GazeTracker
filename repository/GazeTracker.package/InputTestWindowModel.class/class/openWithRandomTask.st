as yet unclassified
openWithRandomTask
	| windowModel |
	windowModel := (self new
		taskText: '                             ' , ((Random seed: nil) nextInt: 10) asString , ' + ' , ((Random seed: nil) nextInt: 10);
		yourself).
	windowModel window: ( (ToolBuilder open: windowModel)
			position: ((Random seed: nil) nextInt: ActiveWorld extent x - 300)@((Random seed: nil) nextInt: ActiveWorld extent y - 300);
			yourself ).
	^ windowModel