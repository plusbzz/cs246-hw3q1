k = 20;
max_r = 5;

% iterate over the files on disk once to find the max values of M and N

[M,N] = findMaxIndex("ratings.train.txt",0,0);
[M,N] = findMaxIndex("ratings.val.txt",M,N);

% Initialize P and Q matrices
P = rand(N,k)*sqrt(max_r/k);
Q = rand(M,k)*sqrt(max_r/k);

% Algorithm

% Until convergence
%  For each R_iu
%   do a step

