function [P,Q,Bu,Bi,E_train,E] = sgd(fname,N,M,R,k,mu,eta,lambda,max_iter)
    fid = fopen(fname);
    
    P = rand(N,k)*sqrt(R/k);
    Q = rand(M,k)*sqrt(R/k);

    Bu = rand(N,1)*R;
    Bi = rand(M,1)*R;

    E_train = [];
    E = [];
    for j = 1:max_iter
        frewind(fid);        
        E_tr = 0;
        bufferSize = 3e4; % scan through the file once
        buffer = reshape(fscanf(fid, '%d\t%d\t%g', bufferSize),3,[])' ;
        while ~isempty(buffer)
            for ix = 1:size(buffer,1)
                vals = buffer(ix,:);
                u = vals(1);
                i = vals(2);
                r = vals(3);
                
                % do one SGD step
                p = P(u,1:k);
                q = Q(i,1:k);
                bu = Bu(u,1);
                bi = Bi(i,1);
                
                eps = r - mu - bu - bi- q*p';
                p_new = p + eta*(eps*q - lambda*p);
                q_new = q + eta*(eps*p - lambda*q);
                bu_new = bu + eta*(eps - lambda*bu);
                bi_new = bi + eta*(eps - lambda*bi);
                
                P(u,:) = p_new;
                Q(i,:) = q_new;    
                Bu(u,1) = bu_new;
                Bi(i,1) = bi_new;
                E_tr = E_tr + (r - mu - bu - bi - q_new*p_new')^2;
            end
            buffer = reshape(fscanf(fid, '%d\t%d\t%g', bufferSize),3,[])' ;
        end
        E_train = [E_train,E_tr];
        E_curr = E_tr   + lambda*(norm(P,'fro')^2 + norm(Q,'fro')^2);
        E_curr = E_curr + lambda*(norm(Bu,'fro')^2 + norm(Bi,'fro')^2); 
        E = [E, E_curr];
    end
    fclose(fid);
end