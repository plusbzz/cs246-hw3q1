eta = 0.03;
lambdas = [0.0 0.2];

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);

errors_tr = [];
errors_te = [];
for lambda = lambdas
    for k = 1:10
        P = rand(N,k)*sqrt(R/k);
        Q = rand(M,k)*sqrt(R/k);
        for i = 1:40
            [P,Q,E_tr] = sgd("ratings.train.txt",P,Q,eta,lambda);
        end
        E_te = calculateError("ratings.val.txt",P,Q,lambda); 
        errors_tr = [errors_tr;lambda k E_tr];
        errors_te = [errors_te;lambda k E_te];
    end
end
save("results.mat");
