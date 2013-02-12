function [P,Q] = sgd(fname,P_init,Q_init,eta,lambda)
    P = P_init;
    Q = Q_init;
    k = size(Q,2);
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
        p_new = p + eta*(eps*q - lambda*p);
        q_new = q + eta*(eps*p - lambda*q);
        P(i,:) = p_new;
        Q(i,:) = q_new;
    end
    fclose(fid);       
end