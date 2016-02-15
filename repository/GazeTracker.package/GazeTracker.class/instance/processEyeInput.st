as yet unclassified
processEyeInput 
	| morphAtGaze position |
	position := self parseInput: self readLineFromStdIn.
	morphAtGaze := self morphAtGaze: position.
	morphAtGaze
		ifNotNil: [ | targetChangeDelta |
			targetChangeDelta := self updateTarget: morphAtGaze.
			targetChangeDelta > self class focusActivationThreshold ifTrue: [
				self activateSystemWindowFor: morphAtGaze.
				ActiveHand newKeyboardFocus: morphAtGaze]].