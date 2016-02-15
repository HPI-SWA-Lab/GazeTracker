accessing
spawnNextInputWindow
	| model |
	model := InputTestWindowModel openWithRandomTask.
	model id: self id.
	model
		when: #inputTestCorrect
		send: #spawnNextInputWindowAfterCorrectAnswer
		to: self.
	model
		when: #inputTestIncorrect
		send: #spawnNextInputWindowAfterWrongAnswer
		to: self.
	^ model