k = 20;
etas = [0.01 0.03 0.1 0.3];
lambda = 0.2;

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);

P = rand(N,k)*sqrt(R/k);
Q = rand(M,k)*sqrt(R/k);

errors_tr = [];
errors_te = [];
errors_to = [];
for eta = etas
    E_train = [];
    E_test  = [];
    E_to    = [];
    for i = 1:40
        [P,Q,E_tr] = sgd("ratings.train.txt",P,Q,eta,lambda);
        E_train= [E_train,E_tr];
        E_te = calculateError("ratings.val.txt",P,Q,lambda); 
        E_test = [E_test,E_te];
        E_to = [E_to, E_tr + E_te + lambda*(norm(P,"fro")^2 + norm(Q,"fro")^2)]
    end
    errors_tr = [errors_tr;E_train];
    errors_te = [errors_te;E_test];
    errors_to = [errors_to;E_to];
end
save("results.mat");
