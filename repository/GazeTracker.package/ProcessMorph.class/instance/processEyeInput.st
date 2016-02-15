as yet unclassified
processEyeInput 
	| morphAtCross millisecondsSinceLastChange |
	cameraPosition := self parseInput: self readLineFromStdIn.
	eyePostionMorph
		center: cameraPosition;
		comeToFront.
	morphAtCross := self morphAtCross.
	morphAtCross ifNotNil: [
		(morphAtCross ownerThatIsA: SystemWindow)
			ifNotNil: [:owner | (owner model isKindOf: InputTestWindowModel)
				ifTrue: [ morphAtCross :=  owner submorphs last ]]. ].
	millisecondsSinceLastChange := eyePostionMorph updateTarget: morphAtCross.
	millisecondsSinceLastChange > 250
		ifTrue: [morphAtCross
				ifNotNil: [
					(self class keepFocusOnCmdKeyPref and: [Sensor commandKeyPressed]) ifFalse: [
						"Transcript showln: morphAtCross."
						self class bringFocusedWindowToFront ifTrue: [
							(morphAtCross ownerThatIsA: SystemWindow) ifNotNil: [:owner | owner activate ]].
						ActiveHand newKeyboardFocus: morphAtCross. "TODO: focus not always but on key press"
						eyePostionMorph resetTimer]]].
	millisecondsSinceLastChange > 1500
		ifTrue: [morphAtCross
				ifNotNil: [ (morphAtCross isKindOf: PluggableButtonMorph)
					ifTrue: [ eyePostionMorph resetTimer.
						"morphAtCross performAction" ] ]]
	"Transcript showln: morphAtCross "