k = 20;
max_r = 5;
eta = 0.1;
lambda = 0.1;

% iterate over the files on disk once to find the max values of M and N

%[N,M] = findMaxIndex("ratings.train.txt",0,0);
%[N,M] = findMaxIndex("ratings.val.txt",N,M);

[P,Q] = sgd("test.txt",eta,lambda,k,max_r,100,100);