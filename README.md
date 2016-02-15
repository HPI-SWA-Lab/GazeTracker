# GazeTracker
Support for gaze/eye tracking in Squeak

Gaze tracking is typically used to gather information on a users point of view and analyze it. This project utilized gaze tracking in order to try and increase a programmers performance in the Squeak programming environment.

The project was started by [Daniel Stolpe](https://github.com/numberpi) and [Astrid Thomschke](github.com/athomschke) during the Programming Languages, Concepts, Tools and Environments (PLCTE) in the winter semester of 2015/2016, supervised by [Marcel Taeumel](https://github.com/marceltaeumel).

## Setup instructions
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

### Prepare Squeak image
* If you don't have one, download a Squeak image from http://squeak.org/downloads/
TODO: commit packages and reference them

### Start gaze tracking in squeak
We provide a Windows executable that allows writing screen coordinates from TobiiEyeX to stdout. If you want to make changes to this output format, have a look at section "Changing the exchange format between Tobii EyeX and Squeak"
TODO: naming coorrect! The pre-compiled executable can be found under /GazeCorrdinatesToCommandLine/GazeCorrdinatesToCommandLine.exe

TODO: correct command! Start your squeak image with [GazeCorrdinatesToCommandLineExecutable.exe] >> [YourSqueakImage.exe]

## Making changes to the exchange format between Tobii EyeX and Squeak
If you want to make changes to the way this project writes gaze coordinates to the stout, follow these instructions.
* Download and install the Tobii EyeX SDK for C and C++: http://developer.tobii.com/eyex-sdk/c-cplusplus/
TODO: Put in subfolder of this repo

## Linklist
* Tobii
  * TobiiEyeX Drivers: http://developer.tobii.com/eyex-setup/
  * TobiiEyeX SDK for C and C++: http://developer.tobii.com/eyex-sdk/c-cplusplus/
* Squeak
  * Squeak images: http://squeak.org/downloads/
* GazeTracking for Squeak
  * Github repository of this projects work: https://github.com/HPI-SWA-Lab/GazeTracker/
  
