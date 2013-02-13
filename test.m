R = 5;
eta = 0.03;
lambdas = [0.0  0.2];
M = 100;
N = 100;


errors = [];
for lambda = lambdas
    for k = 1:10
        [P,Q] = sgd("test.txt",N,M,R,k,eta,lambda,40);
        E_tr = calculateError("test.txt",P,Q,lambda); 
        E_te = calculateError("test.txt",P,Q,lambda);
        [lambda k E_tr E_te]
        errors = [errors;lambda k E_tr E_te];
    end
end
save("results_test.mat");
