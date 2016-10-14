*EyeTracker
generateEyeTrackerFixationDeltaEvent: evtBuf 
	"Generate the appropriate eye tracker fixation delta event for the given raw event buffer"

	| type position mode stamp |
	self flag: #todo.
	
	evtBuf fifth ifNil: [^ nil].
	
	type := #eyeTrackerFixation.
	position := evtBuf sixth @ evtBuf seventh.
	mode := self fixationDataModeFrom: evtBuf first asInteger.
	stamp := evtBuf fifth. "milliseconds relative to an arbitary start time"
	
	mode ifNil: [^ nil].

	^ eyeTrackerState lastFixationEvent
		ifNotNil: [:evt |
			EyeTrackerFixationDeltaEvent new
				setType: #eyeTrackerFixationDelta
				position: position
				mode: mode
				fixationPoint: evt position
				buttons: 0
				hand: self
				stamp: stamp]
		ifNil: [].