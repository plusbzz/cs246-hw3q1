function [P,Q] = sgd(fname,eta,lambda,k,max_r,N,M)
    P = rand(N,k)*sqrt(max_r/k);
    Q = rand(M,k)*sqrt(max_r/k);

    % Until convergence
    %  For each R_iu
    %   do a step
    converged = false;
    
    do
        P_old = P;
        Q_old = Q;
        % one iteration
        fid = fopen (fname);
        while true
            [i,u,r] = readRatingLine(fid);
            if i == -1
                break;
            end
            % if not end of file, do one SGD step
            p = P(i,1:k);
            q = Q(u,1:k);
            eps = r - q*p';
            P(i,:) = p + eta*(eps*q - lambda*p);
            Q(u,:) = q + eta*(eps*p - lambda*q);
        end
        fclose(fid)
        % test for convergence
        errP = norm(P_old-P,"fro");
        errQ = norm(Q_old-Q,"fro");
        errP + errQ
        if errP + errQ < 0.00005
            converged = true;
        end
    until converged
end