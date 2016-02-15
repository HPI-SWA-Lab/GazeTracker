toolbuilder
buildWith: aBuilder
	| spec |
	spec := (self buildWindowWith: aBuilder specs: { 
		(0@0 corner: 1@0.2) -> [aBuilder pluggableTextSpec new
			getText: #taskText;
			model: self;
			yourself].
		(0@0.2 corner: 1@1) -> [aBuilder pluggableTextSpec new
			getText: #contents;
			setText: #acceptContents:;
			model: self;
			yourself]
	}) extent: 300@150;
		yourself.
	^ aBuilder build: spec