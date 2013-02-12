R = 5;
eta = 0.03;
lambdas = [0.0  0.2];
M = 100;
N = 100;


errors_tr = [];
errors_te = [];
errors_to = [];
for lambda = lambdas
    for k = 1:10
        P = rand(N,k)*sqrt(R/k);
        Q = rand(M,k)*sqrt(R/k);
        for i = 1:40
            [P,Q,E_tr] = sgd("test.txt",P,Q,eta,lambda);
        end
        E_te = calculateError("test.txt",P,Q,lambda); 
        errors_tr = [errors_tr;lambda k E_tr];
        errors_te = [errors_te;lambda k E_te];
    end
end
save("results_test.mat");
