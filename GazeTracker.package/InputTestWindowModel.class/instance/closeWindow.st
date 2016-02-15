accessing
closeWindow
	self
		window submorphs select: [:morph | morph isKindOf: PluggableTextMorph ] thenDo: [:morph | morph cancel].
	self window delete