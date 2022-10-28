%% Master of Science Thesis: Rohan Chandrashekar (St Id: 5238382)
%% Topic: Graph Regularized Canonical Polyadiac (GRCP) Tensor Decomposition 
clear; clc; 
%Adding paths for required files to train the model
addpath('core'); addpath(genpath('utils')); addpath('data');
feature('numCores'); 
%Initialization of GRCP model
GRCP_ImageInit;

%% Graph Regularized Canonical Polyadiac (GRCP) Tensor Decomposition 
[A,lambda,f,Train_NMSE,Test_NMSE,R_Time,Training_Data] = Image_ALS(Data,opts);

%% Storing obtained results.
clear i idx
A = reshape(A,sz);
f = reshape(f,sz);
lambda = reshape(lambda,sz);
R_Time = reshape(R_Time,sz);
Train_NMSE = reshape(Train_NMSE,sz);
Test_NMSE = reshape(Test_NMSE,sz);
Training_Data = reshape(Training_Data,sz);

if (opts.fsave == 1)
    save(opts.filename);
end