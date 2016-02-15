as yet unclassified
onClick
	process ifNotNil: [
		process terminate.
		process := nil.
		self setLabelStarted: false]
	ifNil: [
		process := self endlessProcessBlock newProcess.
		process priority: 20.
		process resume.
		self setLabelStarted: true ]
	