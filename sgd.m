function [P,Q] = sgd(fname,N,M,R,k,eta,lambda,max_iter)
    fid = fopen(fname);
    P = rand(N,k)*sqrt(R/k);
    Q = rand(M,k)*sqrt(R/k);
    for j = 1:max_iter
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
        end
    end
    fclose(fid);
end