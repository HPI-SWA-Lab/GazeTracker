as yet unclassified
baseline: spec 
	<baseline>
	spec
		for: #common
		do: [
			spec
				package: 'EyeTracker' with: [
					spec
						repository: 'github://HPI-SWA-Lab/GazeTracker:master/repository'];	
									
				package: 'TobiiEyeXPlugin' with: [
					spec
						repository: 'github://HPI-SWA-Lab/GazeTracker:master/repository'].
					
			spec
				group: 'default' with: #('EyeTracker');
				group: 'Plugin' with: #('TobiiEyeXPlugin')]