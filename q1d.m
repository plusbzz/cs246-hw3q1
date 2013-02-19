% iterate over the files on disk once to find the max values of M and N
tic;
[R,N,M,sum,cnt] = findMaxIndex('ratings.train.txt',0,0,0,0,0);
[R,N,M,sum,cnt] = findMaxIndex('ratings.val.txt',R,N,M,sum,cnt)
mu = sum/cnt
toc


%Q1.d.b

k = 20;
etas = [0.01 0.03 0.1 0.3];
lambda = 0.2;
tic;
errors1 = [];
for eta = etas
    [P,Q,Bu,Bi,E_train,E] = sgd('ratings.train.txt',N,M,R,k,mu,eta,lambda,40);
    errors1= [errors1; E];
    E
end
errors1
toc

%Q1.d.c
eta = 0.03;
lambdas = [0.0 0.2];

errors2= [];
for lambda = lambdas
    for k = 1:10
        tic;
        [P,Q,Bu,Bi,E_train,E] = sgd('ratings.train.txt',N,M,R,k,mu,eta,lambda,40);
        E_tr = calculateError('ratings.train.txt',P,Q,mu,Bu,Bi); 
        E_te = calculateError('ratings.val.txt',P,Q,mu,Bu,Bi);
        [lambda k E_tr E_te]
        toc
        errors2 = [errors2;lambda k E_tr E_te];
    end
end
errors2
save('results_q1d.mat','errors1','errors2');
