as yet unclassified
baseline: spec 
	<baseline>
	spec
		for: #common
		do: [
			spec
				package: 'EyeTracker';										
				package: 'TobiiEyeXPlugin'.
					
			spec
				group: 'default' with: #('EyeTracker');
				group: 'plugin' with: #('TobiiEyeXPlugin');
				group: 'all' with: #('TobiiEyeXPlugin' 'EyeTracker')]