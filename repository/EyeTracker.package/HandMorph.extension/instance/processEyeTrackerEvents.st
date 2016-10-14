*EyeTracker
processEyeTrackerEvents

	| fixationEvent fixationDeltaEvent evtBuf |
	self flag: #todo.
	eyeTrackerState ifNil: [eyeTrackerState := EyeTrackerState new].
	
	evtBuf := EyeTrackerSensor pollFixationData.
	fixationEvent := self generateEyeTrackerEvent: evtBuf.
	fixationEvent ifNil: [^ self].
	
	fixationEvent ~= eyeTrackerState lastFixationEvent ifTrue: [
		self handleEvent: fixationEvent.
		eyeTrackerState lastFixationEvent: fixationEvent].

	fixationDeltaEvent := self generateEyeTrackerFixationDeltaEvent: evtBuf.
	fixationDeltaEvent ifNil: [^ self].
	
	(fixationDeltaEvent timeStamp ~= fixationEvent timeStamp	
		and: [fixationDeltaEvent ~= eyeTrackerState lastFixationDeltaEvent]) ifTrue: [
			self handleEvent: fixationDeltaEvent.
			eyeTrackerState lastFixationDeltaEvent: fixationDeltaEvent]
	