*EyeTracker
handleEyeTracker: event
	event wasHandled ifTrue: [^ self].
	(self handlesEyeTracker: event) ifFalse: [^ self].
	event wasHandled: true.
	^ self eyeTracked: event