accessing
acceptContents: aTextOrString
	| result input |
	input := aTextOrString asString asInteger.
	result := (Compiler evaluate: self taskText) = input.
	self changed: #taskText.
	(self future: 1000) closeWindow.
	result
		ifTrue: [super acceptContents: 'RICHTIG!'.
			self triggerEvent: #inputTestCorrect. ]
		ifFalse: [super acceptContents: 'FALSCH!'.
			self triggerEvent: #inputTestIncorrect.].
	^ true
	