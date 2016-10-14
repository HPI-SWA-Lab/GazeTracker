*EyeTracker
generateEyeTrackerEvent: evtBuf 
	"Generate the appropriate eye tracker event for the given raw event buffer"

	| type position mode stamp |
	self flag: #todo.
	
	evtBuf first ifNil: [^ nil].
	
	type := #eyeTrackerFixation.
	position := evtBuf third @ evtBuf fourth.
	mode := self fixationDataModeFrom: evtBuf first asInteger.
	stamp := evtBuf second. "milliseconds relative to an arbitary start time"
	
	mode ifNil: [^ nil].

	"eyeTrackerState lastFixationPoint ifNotNil: [:pt |"
		"TODO: Check for last fixation start event and maybe generate a EyeTrackerFixationDeltaEvent!!!"
		"TODO: If at end, clear last fixation point."
		
		"^ EyeTrackerFixationDeltaEvent new
			setType: #eyeTrackerFixationDelta
			position: position
			mode: mode
			fixationPoint: pt
			buttons: 0
			hand: self
			stamp: stamp]."

	^ EyeTrackerEvent new
		setType: type
		position: position
		mode: mode
		buttons: 0
		hand: self
		stamp: stamp