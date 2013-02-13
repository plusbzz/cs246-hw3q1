k = 20;
etas = [0.01 0.03 0.1 0.3];
lambda = 0.2;

% iterate over the files on disk once to find the max values of M and N

[R,N,M] = findMaxIndex("ratings.train.txt",0,0,0);
[R,N,M] = findMaxIndex("ratings.val.txt",R,N,M);

errors_tr = [];
for eta = etas
    E_train = [];
    P = rand(N,k)*sqrt(R/k);
    Q = rand(M,k)*sqrt(R/k);
    for i = 1:40
        [P,Q,E_tr] = sgd("ratings.train.txt",P,Q,eta,lambda);
        E_train= [E_train,E_tr];
        E = E_tr + lambda*(norm(P,"fro")^2 + norm(Q,"fro")^2);
    end
    errors_tr = [errors_tr;E_train];
end
save("results_q1b.mat");
