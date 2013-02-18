%Q1.b

k = 20;
etas = [0.01 0.03];
lambda = 0.2;

% iterate over the files on disk once to find the max values of M and N
tic;
[R,N,M] = findMaxIndex('ratings.train.txt',0,0,0);
[R,N,M] = findMaxIndex('ratings.val.txt',R,N,M)
toc
tic;
errors1 = [];
for eta = etas
    [P,Q,E_train,E] = sgd('ratings.train.txt',N,M,R,k,eta,lambda,40);
    errors1= [errors1; E];
end
errors1
toc

%Q1.c
eta = 0.03;
lambdas = [0.0 0.2];

errors2= [];
for lambda = lambdas
    for k = 1:10
	tic;
        [P,Q,E_train,E] = sgd('ratings.train.txt',N,M,R,k,eta,lambda,40);
        E_tr = calculateError('ratings.train.txt',P,Q); 
        E_te = calculateError('ratings.val.txt',P,Q);
        [lambda k E_tr E_te]
	toc
        errors2 = [errors2;lambda k E_tr E_te];
    end
end
errors2
save('results_q1bc.mat','errors1','errors2');
