# GazeTracker
Support for gaze/eye tracking in Squeak

Gaze tracking is typically used to gather information on a users point of view and analyze it. This project utilized gaze tracking in order to try and increase a programmers performance in the Squeak programming environment.

The project was started by [Daniel Stolpe](https://github.com/numberpi) and [Astrid Thomschke](github.com/athomschke) during the Programming Languages, Concepts, Tools and Environments (PLCTE) in the winter semester of 2015/2016, supervised by [Marcel Taeumel](https://github.com/marceltaeumel).

## Setting up GazeTracker
In order to have gaze coordinates information available in a Squeak image, we write information from a Tobii EyeX gaze tracker to stdout. This output is then piped into a process running a Squeak image.

The setup requires on the hardware side
* A Tobii EyeX
* A Windows Machine

On the software side the setup requires
* The [Tobii EyeX drivers](http://developer.tobii.com/eyex-setup/)
* The contents of [this repository](https://github.com/HPI-SWA-Lab/GazeTracker/)
* A [Squeak image](http://squeak.org/downloads/)

### Set up TobiiEyex
* Install the Tobii EyeX below your PC or Laptop Screen.
* Plug in the Tobii EyeX. It will guide you through the setup, which includes the following
  * Download the software bundle at http://developer.tobii.com/eyex-setup/ and install it
  * Calibrate it following the software guide

Tobii is set up at this point. You can try the gaze tracker in your Windows environment.

### Start Squeak with gaze tracking information
We provide an adapter as Windows executable that allows writing screen coordinates from TobiiEyeX to stdout. If you want to make changes to this output format, you'll find instructions [later in this document](https://github.com/HPI-SWA-Lab/GazeTracker/blob/master/README.md#making-changes-to-the-exchange-format-between-tobii-eyex-and-squeak).

* If you don't have a Squeak environment, download a Squeak executable and image from http://squeak.org/downloads/
* In https://github.com/HPI-SWA-Lab/GazeTracker/tobii-adapter/ , copy Tobii.EyeX.Client-template-x32.dll or Tobii.EyeX.Client-template-x64.dll (depending on your system) and rename it to Tobii.EyeX.Client.dll. The sources for these libraries can be found in the [TobiiEyeX SDK for C and C++](http://developer.tobii.com/eyex-sdk/c-cplusplus/)
* Start your squeak image from command line with the adapter
 * The pre-compiled executable can be found under [[GazeTracker repository]\tobii-adapter\Tobii2SqueakAdapter.exe](https://github.com/HPI-SWA-Lab/GazeTracker/blob/master/tobii-adapter/Tobii2SqueakAdapter.exe)
 * An example batch file can be found at [[GazeTracker repository]\tobii-adapter\startSqueakWithTobii-template.bat](https://github.com/HPI-SWA-Lab/GazeTracker/tree/master/tobii-adapter/startSqueakWithTobii-template.bat)
 * Use following shell command (according to your environment)
``` shell
[PathToYourTobii2SqueakAdapter] | [PathToYourSqueakConsoleExecutable] [PathToYourSqueakImage]
```

### Use gaze tracking information in Squeak
* In a Squeak workspace, run
```smalltalk
Metacello new
  baseline: 'GazeTracker';
  repository: 'github://HPI-SWA-LAB/GazeTracker/repository';
  load.
```
* Left-click into the world and choose "open > GazeTracker".
 * A button labelled "Start/Stop process" will be put in your world.
 * Click this button to toggle between the two states
  * When gaze tracking is enabled and Tobii is running, the focus for Squeak text fields will be set to your current gaze point
  * When Tobii is not running or it cannot find your gaze, the Squeak image will stall until you're back in Tobii's view
* Save the Image and close it.

## Making changes to the TobiiEyeX Adapter
If you want to make changes adapter, e.g. to change the way this project writes gaze coordinates to the stout, follow these instructions.

It requires Visual Studio to be installed on your machine.

* Download and install the Tobii EyeX SDK for C and C++: http://developer.tobii.com/eyex-sdk/c-cplusplus/
* Apply the changes made for the adapter to the downloaded sources.
 * The changed files can be found in [[GazeTracker repository]\tobii-adapter-source](https://github.com/HPI-SWA-Lab/GazeTracker/tree/master/tobii-adapter-source)
* Make your changes
* Export a Windows executable

## Linklist
* GazeTracking for Squeak
  * Github repository of this projects work: https://github.com/HPI-SWA-Lab/GazeTracker/
  * Required Squeak package: [[GazeTracker repository]\repository](https://github.com/HPI-SWA-Lab/GazeTracker/tree/master/repository)
  * Tobii adapter: [[GazeTracker repository]\tobii-adapter](https://github.com/HPI-SWA-Lab/GazeTracker/tree/master/tobii-adapter)
  * Tobii EyeX SDK changes: [[GazeTracker repository]\tobii-adapter-source](https://github.com/HPI-SWA-Lab/GazeTracker/tree/master/tobii-adapter-source)
* Tobii
  * TobiiEyeX Drivers: http://developer.tobii.com/eyex-setup/
  * TobiiEyeX SDK for C and C++: http://developer.tobii.com/eyex-sdk/c-cplusplus/
* Squeak
  * Squeak images: http://squeak.org/downloads/
