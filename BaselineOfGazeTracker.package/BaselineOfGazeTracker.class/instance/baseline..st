as yet unclassified
baseline: spec
    <baseline>
    spec
        for: #'common'
        do: [ 
            spec
                package: 'GazeTracker-Core';
                package: 'GazeTracker-Evaluation' with: [ spec requires: #('default') ].
            spec
                group: 'default' with: #('GazeTracker-Core');
                group: 'evaluation' with: #('GazeTracker-Core' 'GazeTracker-Evaluation')]