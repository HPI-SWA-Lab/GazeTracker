instance creation
open
	^ self new
		extent: ActiveWorld extent * 0.75;
		center: ActiveWorld center;
		openInWorld;
		yourself