eta = 0.03;
lambdas = [0.0 0.2];

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);

errors= [];
for lambda = lambdas
    for k = 1:10
        [P,Q] = sgd("ratings.train.txt",N,M,R,k,eta,lambda,40);
        E_tr = calculateError("ratings.train.txt",P,Q,lambda); 
        E_te = calculateError("ratings.val.txt",P,Q,lambda);
        [lambda k E_tr E_te]
        errors = [errors;lambda k E_tr E_te];
    end
end
save("results_q1c.mat","errors");
