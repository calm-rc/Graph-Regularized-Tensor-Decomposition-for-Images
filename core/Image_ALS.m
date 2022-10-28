function [A,lambda,f,Train_NMSE,Test_NMSE,R_Time,Training_Data] = Baboon_ALS(Data,opts)
%% Initializations for the Image data
%Importing Image data
I = Data;
%Converting Image data of type 'double' to 'uint8'
X = uint8(I);
varI = std2(I)^2;
oG_dims = size(I);
ndimI = ndims(I); 
W = ones(oG_dims);

%% Initializing parameters to train the image model for given parameters
knn_graph = opts.KNN;
rank = opts.Rank;
reg = opts.LReg;
SNR = opts.SNR;
sz = [size(SNR,2) size(knn_graph,1) size(rank,2) size(reg,2)];

%%Initializing parameters to store the Trained Image models
%Factor matrices and normalizing coefficients of the Trained models
A = cell(prod(sz),1);
lambda = cell(prod(sz),1);
%Regularization coefficients for graph Laplacians
alpha = cell(1,ndims(I));
%Percentage of Fit of the Trained models
f = cell(prod(sz),1);
%Training NMSE of the Trained models
Train_NMSE = cell(prod(sz),1);

%% Optimization Algorithm - ALS with Conjugate Gradient
for m = 1:sz(1)
    %% Adding Gaussian noise
    %Adding Gaussian noise to the original image data
    if(SNR(m)~=0)
        I_Noise = I + sqrt(varI/10^(SNR(m)/10))*randn(size(I));
    else
        I_Noise = I;
    end
    Training_Data{m} = I_Noise;
    for t = 1:sz(2)
        disp('Laplacians being built...');
        L = cell(1,ndimI);
        nn_graph = knn_graph(t,:);
        if(opts.dispLap == 1)
            figure("Visible","on");
        else
            figure("Visible","off");
        end
        tiledlayout(3,3,'TileSpacing','Compact','Padding','Compact');
        for i = 1:ndimI
            clear G;
            param.k = nn_graph(i);
            iL = Tensor_nMode(I_Noise,i);
            %Building the kNN graph using the GSP toolbox
            G = gsp_nn_graph(iL,param);
            %Building Laplacian matrix
            L{i} = Laplacian(G);
            %Displaying built Laplacian matrices
            if(opts.dispLap == 1)
                nexttile
                %Plotting the n-mode Matricized Tensor
                spy(iL);
                nexttile
                [V, ~] = eigs(L{i}, 2, 'SA');
                [~, p] = sort(V(:,2));
                hold on
                %Plotting the graph Laplacian built on the n-mode Matricized
                %Tensor
                spy(L{i}(p,p));
                nexttile
                %Plotting the Eigen Values of the graph Laplacian
                plot(sort(V(:,2)), '.-');
            end
        end
        for y = 1:sz(3)
            r = rank(y);
            for z = 1:sz(4)
                for i = 1:ndimI
                    alpha{i} = reg(z);
                end
                idx = sub2ind(sz,m,t,y,z);
                tic
                %CP ALS algorithm to obtained trained model as implemented in Algorithm (4)
                [A{idx},lambda{idx},f{idx},Train_NMSE{idx}] = CP_ALSLap(I_Noise,W,L,alpha,r,opts);
                %Storing time taken to train the model
                R_Time(idx) = toc;
            end
        end
    end
end

%% Testing Dataset
normX = norm(I(:));
%Calculating the Testing Error given the Trained model
for i = 1:prod(sz)
    X = CP_Reconstruct(A{i},lambda{i});
    Train_X = reshape(W(:).*X(:),oG_dims);
    nXbar = norm(Train_X(:));
    normresidual = sqrt(normX^2 + nXbar^2 - 2 * Tensor_Inner(I,Train_X));
    Test_NMSE(i) = normresidual / normX;
end
