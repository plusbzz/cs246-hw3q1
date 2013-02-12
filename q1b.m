k = 20;
max_r = 5;
eta = 0.1;
lambda = 0.2;

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);

P = rand(N,k)*sqrt(R/k);
Q = rand(M,k)*sqrt(R/k);

errors = [];
for i = 1:40
    [P,Q,E] = sgd("ratings.train.txt",P,Q,eta,lambda);
    errors = [errors;E];
end
errors
