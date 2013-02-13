k = 20;
R = 5;
etas = [0.01 0.03 0.1 0.3];
lambda = 0.2;
M = 100;
N = 100;


errors = [];
for eta = etas
    E_train = [];
    [P,Q,E_train,E] = sgd("test.txt",N,M,R,k,eta,lambda,40);
    errors= [errors; E];
end
save("results_test.mat");
