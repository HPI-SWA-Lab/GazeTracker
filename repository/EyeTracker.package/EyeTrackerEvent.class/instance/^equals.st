comparing
= aMorphicEvent
	super = aMorphicEvent ifFalse:[^false].
	position = aMorphicEvent position ifFalse: [^ false].
	mode = aMorphicEvent mode ifFalse: [^ false].
	buttons = aMorphicEvent buttons ifFalse: [^ false].
	^ true