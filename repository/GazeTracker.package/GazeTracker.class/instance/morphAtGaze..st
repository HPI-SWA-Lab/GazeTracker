as yet unclassified
morphAtGaze: position
	| morph filteredMorphs |
	filteredMorphs := ((ActiveWorld morphsAt: position)
		reject: [:m | m = ActiveWorld]).
	
	self class eyeFocusViaHandler ifTrue: [
		morph := filteredMorphs
			detect: [:m |
				m hasProperty: #eyeFocusHandler ]
			ifFound: [:m | m valueOfProperty: #eyeFocusHandler ifPresentDo: [ :handler |
					handler value ]]
			ifNone: []].	
	
	morph ifNil: [
		self class keyboardFocusOnEyeEnter ifTrue: [
			morph := filteredMorphs
				detect: [:m |
					m wantsKeyboardFocus or: [
						[m handlesKeyboard: self createKeyboardEvent ]
							ifError: [false] ] or: [
						m isSystemWindow ]]
				ifFound: [:m | m isSystemWindow
					ifTrue: []
					ifFalse: [m]]
				ifNone: []]].
	^ morph