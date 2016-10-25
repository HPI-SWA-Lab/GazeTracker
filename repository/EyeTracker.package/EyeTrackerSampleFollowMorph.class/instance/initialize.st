submorphs-add/remove
initialize

	| hand |
	super initialize.
	self eventFilter: (PluggableEventFilter on: [:evt  | 
		(evt isEyeTracker and: [evt isFixationDelta not])
			ifTrue: [self fixationPoint: evt position].
			evt]).
	hand := Project current world firstHand.
	hand addEventCaptureFilter: self eventFilter