accessing
onClick
	| uuid |
	Transcript showln: 'Starting random window popup game'.
	correctAnswers := 0.
	wrongAnswers := 0.
	uuid := UUID new asString.
	(self future: 40000) endGame: uuid.
	self id: uuid.
	self spawnNextInputWindow.
	
	