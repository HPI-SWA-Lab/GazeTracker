accessing
endGame: id
	PluggableSystemWindow allInstances select: [ :aSystemWindow |
		(aSystemWindow model isKindOf: InputTestWindowModel) and: [
			aSystemWindow model id = id ]
	] thenDo: [ :aWindow |
		aWindow model closeWindow.
	].
	Transcript showln: 'Ending random window popup game.'.
	Transcript showln: 'Result: ' , (correctAnswers + wrongAnswers) , ' questions answered, where ', correctAnswers, ' were correct and ', wrongAnswers, ' were incorrect.'.