k = 20;
etas = [0.01 0.03 0.1 0.3];
lambda = 0.2;

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);

errors = [];
for eta = etas
    E_train = [];
    [P,Q,E_train,E] = sgd("ratings.train.txt",N,M,R,k,eta,lambda,40);
    errors= [errors; E];
end
save("results_q1b.mat","errors");
