# GazeTracker
_Support for gaze/eye tracking in Squeak_

Gaze tracking is typically used to gather information on a users point of view and analyze it. This project utilized gaze tracking in order to try and increase a programmers performance in the Squeak programming environment.

The project was started by [Daniel Stolpe](https://github.com/numberpi) and [Astrid Thomschke](github.com/athomschke) during the Programming Languages, Concepts, Tools and Environments (PLCTE) in the winter semester of 2015/2016, supervised by [Marcel Taeumel](https://github.com/marceltaeumel).

View the Squeak Gaze Tracker screencast at https://youtu.be/SNm0B0PTYQI

Get more information from presentations:
* [Frist prototype](https://docs.google.com/presentation/d/1-nI-6TA-7604qfjvKDztZV-Iyn9WVMYFZw6DR6xvjeY/edit?usp=sharing)
* [Final state (for now)](https://docs.google.com/presentation/d/17QsNCRyb0Y6qT02to8RwM-eY7PlWv37mVEKUq0oiiHg/edit?usp=sharing)

In 2016 we built a VM-Plugin to transfer the gaze data from the EyeX engine into Squeak to replace the dirty stdin-stdout-pipe hack.

## Setting up GazeTracker

The setup requires on the hardware side
* A Tobii EyeX
* A Windows Machine

On the software side the setup requires
* The [Tobii EyeX drivers](http://developer.tobii.com/eyex-setup/)
* The contents of [this repository](https://github.com/HPI-SWA-Lab/GazeTracker/)
* A [Squeak image](http://squeak.org/downloads/)

### Set up Tobii EyeX
* Install the Tobii EyeX below your PC or Laptop Screen.
* Plug in the Tobii EyeX. It will guide you through the setup, which includes the following
  * Download the software bundle at http://developer.tobii.com/eyex-setup/ and install it
  * Calibrate it following the software guide

Tobii is set up at this point. You can try the gaze tracker in your Windows environment.

### Building the VM-Plugin
It requires Visual Studio to be installed on your machine.
- Download the EyeX SDK for C/C++ from [developer.tobii.com](http://developer.tobii.com/downloads). 
- Extract the EyeX SDK files and copy the lib and include directories to the
  `plugin-code\thirdparty\TobiiEyeX-SDK` folder of the EyeX plugin. (Note that the SDK license differs from the one used for this plugin.)
- Build the Visual Studio project in `plugin-code\TobiiEyeXPlugin`

### Running Squeak with the EyeTracking plugin
- Copy the build output `TobiiEyeX.dll` to your Squeak VM folder (the folder where Squeak.exe is located).
- Copy the third-party `Tobii.EyeX.Client.dll` from the EyeX SDK lib folder also into your Squeak VM folder
- run Squeak

### Use gaze tracking information in Squeak
* In a Squeak workspace, run
```smalltalk
Metacello new
  baseline: 'EyeTracker';
  repository: 'github://HPI-SWA-LAB/GazeTracker/repository';
  load.
```
* Activate full screen mode in Squeak
* Open a sample Morph using gaze information
```smalltalk
EyeTrackerSampleMorph open
```

### Changing the Slang code
tbd

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
