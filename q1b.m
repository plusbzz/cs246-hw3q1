k = 20;
max_r = 5;
eta = 0.1;
lambda = 0.1;

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);
[P,Q] = sgd("ratings.train.txt",eta,lambda,k,R,N,M);

%[P,Q] = sgd("test.txt",eta,lambda,k,5,100,100);