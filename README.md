# Graph Regularized Tensor Decomposition (GRCP) for Images

This repository contains the code adapted for Image representation from the Master of Science Thesis "[Graph Regularized Tensor Decomposition for Recommender Systems](https://github.com/calm-rc/Graph-Regularized-Tensor-Decomposition-for-Recommender-Systems)" carried out under [Dr.ir. K. Batselier](https://www.tudelft.nl/staff/k.batselier/?cHash=bc8a8a032dbc0c2e49df471ee3538c27) and [Elvin Isufi](https://www.tudelft.nl/ewi/over-de-faculteit/afdelingen/intelligent-systems/multimedia-computing/people/elvin-isufi) in Systems and Control at Delft University of Technology. For any questions or suggestions, please e-mail [Rohan Chandrashekar](R.Chandrashekar@student.tudelft.nl).

# Code Structure 

The code is written on MATLAB R2021b. The required dependencies have been included in the repository as data files (data) and code files (utils and core). 

The data files comprise of an image 'baboon.jpg', an RGB image of dimensions 512x512.

The code files comprising of .m script files, contains the necessary mathematical operations (Tensor and Graph theory) and algorithms (GRCP Alternating Least Squares and Conjugate Gradient) to evalaute the GRCP model for Image representation.  

# Code Usage 

1. Download/clone the repository. 
2. The model framework is evaluated for the hyperparameters and settings set in `GRCP_ImageInit.m`. Detailed comments have been provided in the initialization file on type and configuration of these parameters. 
3. Open MATLAB and navigate to the destination folder and run `GRCP_ImageMain.m` from the Command Window.

# References

[1] Perraudin Nathanaël, Johan Paratte, David Shuman, Lionel Martin, Vassilis Kalofolias, Pierre Vandergheynst and David K. Hammond}, "GSPBOX: A toolbox for signal processing on graphs," [arxiv e-print](https://arxiv.org/abs/1408.5781), 08-2014

[2]  Brett W. Bader, Tamara G. Kolda and others, Tensor Toolbox for MATLAB, Version 3.4, www.tensortoolbox.org, September 21, 2022

# Copyrights

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the conditions listed in the 'LICENSE' file are met.
