as yet unclassified
activateSystemWindowFor: morphAtGaze
	(self class keepFocusOnCmdKeyPref and: [Sensor commandKeyPressed]) ifFalse: [
		self class bringFocusedWindowToFront ifTrue: [
			(morphAtGaze ownerThatIsA: SystemWindow) ifNotNil: [:owner | owner activate ]]]