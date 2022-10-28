%% Master of Science Thesis: Rohan Chandrashekar (St Id: 5238382)
%% Topic: Graph Regularized Canonical Polyadiac (GRCP) Tensor Decomposition 
%% Configuration File for Data Preparation and Initialization
%Input Requirements: Image Data in the format Width x Height x RGB
Data = double(imread('baboon.jpg'));

%% Initializations for the Algorithm  
%Maximum Iterations for ALS Algorithm
opts.maxALSIter = 200;   
%Convergence Tolerance for ALS Algorithm
opts.tolALS = eps;       
%Maximum Iterations for Conjugate Gradient Descent Method
opts.cgmaxIter = 30;    
%Convergence Tolerance for Conjugate Gradient Descent Method
opts.cgtol = 1e-12;    
%Print ALS iterations (1) or not (0) 
opts.printin = 1;      
%Choice of Computation: CPU (single/double precision) or GPU (gpuArray).
%GPU compatibility required on the machine using gpuArray
%https://www.mathworks.com/help/releases/R2022a/parallel-computing/run-matlab-functions-on-a-gpu.html
opts.type = "single";

%Rank of CP Decomposition: Testing of varying model ranks can be done by 
%providing the CP ranks as [R1 R2 R3 ... RN].
opts.Rank = [40 60 80 100 120 140];         

%Regularization Coefficients: Testing of varying model regularization can 
%be done by providing the regularization coefficients [a1 a2 a3 ... aN].
%Laplacian Regularization 
opts.LReg = [0 1e-1 1e-2 1e-3];
%Nuclear Norm Regularization
opts.NReg = 1;

%Number of kNN members for the Laplacians built on each n-mode matricized tensor.
%Provided as [kNN(1) kNN(2) kNN(3); kNN(1) kNN(2) kNN(3); ... ; kNN(1) kNN(2) kNN(3)]
opts.KNN = [1 1 1; 1 1 2; 2 2 1; 2 2 2];

%Amount of noise in SNR (dB) to be added to the image provided as [s1 s2 s3 ... sN]
opts.SNR = [0 0.1 0.5 1 4 7];

sz = [length(opts.SNR) length(opts.KNN) length(opts.Rank) length(opts.LReg)];
idx = prod(sz);

%Display Laplacian matrices? (1) to show, (0) to not show
opts.dispLap = 0;
%Save simulation results? (1) to save, (0) to not save
opts.fsave = 1;
%Filename for saving built models
opts.filename = "GRCP_Image_misc";
