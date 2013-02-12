function [P,Q,E] = sgd(fname,P_init,Q_init,eta,lambda)
    P = P_init;
    Q = Q_init;
    k = size(Q,2);
    E = 0;
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
        E = E + (r - q_new*p_new')^2;
    end
    E = E + lambda*(norm(P,"fro")^2 + norm(Q,"fro")^2);
    fclose(fid);       
end