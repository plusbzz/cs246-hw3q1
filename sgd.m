function [P,Q,E_train,E] = sgd(fname,N,M,R,k,eta,lambda,max_iter)
    fid = fopen(fname);
    P = rand(N,k)*sqrt(R/k);
    Q = rand(M,k)*sqrt(R/k);
    E_train = [];
    E = [];
    for i = 1:40    
        frewind(fid);
        E_tr = 0;
        while true
            [i,u,r] = readRatingLine(fid);
            if i == -1
                break;
            end
            % if not end of file, do one SGD step
            p = P(i,1:k);
            q = Q(u,1:k);
            eps = r - q*p';
            p_new = p + eta*(eps*q - lambda*p);
            q_new = q + eta*(eps*p - lambda*q);
            P(i,:) = p_new;
            Q(i,:) = q_new;
            E_tr = E_tr + (r - q_new*p_new')^2;
            [eta i E_tr]
        end
        E_train = [E_train,E_tr];
        E = [E, E_tr + lambda*(norm(P,"fro")^2 + norm(Q,"fro")^2)];
    end
    fclose(fid);
end