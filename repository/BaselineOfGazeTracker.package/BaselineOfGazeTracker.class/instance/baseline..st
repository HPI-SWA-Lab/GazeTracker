as yet unclassified
baseline: spec 
	<baseline>
	spec
		for: #common
		do: [
			spec
				package: 'GazeTracker' with: [
					spec
						repository: 'github://HPI-SWA-Lab/GazeTracker:master/repository'];	
									
				package: 'GazeTrackerEvaluation' with: [
					spec
						repository: 'github://HPI-SWA-Lab/GazeTracker:master/repository';
						requires: #('GazeTracker-Core' )].
					
			spec
				group: 'default' with: #('GazeTracker' );
				group: 'evaluation' with: #('GazeTracker' 'GazeTrackerEvaluation' )]