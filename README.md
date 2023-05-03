# TDSFT ![](https://img.shields.io/github/forks/UniBoDS4H/TDSFT?style=social) ![](https://img.shields.io/github/stars/UniBoDS4H/TDSFT?style=social) ![](https://img.shields.io/github/watchers/UniBoDS4H/TDSFTe?style=social) <br>

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)
[![Latest Release](https://img.shields.io/github/v/release/UniBoDS4H/TDSFT?style=for-the-badge&color=blue)](https://img.shields.io/github/v/release)

> "TDSFT (Two Dimensional Segmentation Fusion Tool): an extensible and open-source tool for combining different bidimensional annotations."

<!-- Add resources/logo/logo_blackbg.svg -->

<img src="resources/logo/logo_nobg.svg" width="300">

1. [Description](#description)
2. [Download](#download)
3. [How to use](#how-to-use)
4. [Extend](#extend)

## Description ##
TDSFT is a *MATLAB Standalone Application* which permits to fuse of different bidimensional annotations.
It can be easily installed on Windows, Linux and macOs. \
It is developed to help *doctors, anatomopathologist, and anyone* who needs to fuse different segmentations. \
The focus is on *medical images* but it can be applied to every field where annotation fusion is needed, e.g. mineral annotations.

It is developed to provide the community with a tool:
- easy-to-use: everyone can easily use it, and every design choice was taken to help users in their daily usage;
- extensible: it is easy to add and run your algorithms without the need to develop a further gui but using the instruments TDSFT provides;
- open-source: everyone can access and use it (see the licenses).

## Download ##

## How to use ##

## Extend ##
To add external algorithms follow the next steps:

1. Create a MATLAB source file, the filename must follow this pattern : algorithm_{yourName}.m \
   (substitute {yourName} with the name of your algorithm written in camel case, see [algorithms](api/algorithms) directory for some examples);
2. Copy the file inside the [algorithms](api/algorithms) directory
3. Inside the source file must be present only one function called as the source file.
4. The default aurgument of the function is an array 

## Acknowledgments ##
- Lorenzo Drudi, Bachelor's Degree Student in Computer Sciences, University of Bologna, Italy \
  email: lorenzodrudi11@gmail.com \
  github: [@LorenzoDrudi](https://github.com/LorenzoDrudi)
  
## Contact Us ##
The Data Science for Health (DS4H) group:
- Antonella Carbonaro, Department of Computer Science and Engineering (DISI), University of Bologna, Bologna, Italy \
  email: antonella.carbonaro@unibo.it

- Filippo Piccinini, Istituto Scientifico Romagnolo per lo Studio e la Cura dei Tumori (IRST) IRCCS, Meldola (FC), Italy \
  email: filippo.piccinini@irst.emr.it
  
