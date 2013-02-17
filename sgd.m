function [P,Q] = sgd(fname,N,M,R,k,eta,lambda,max_iter)
    fid = fopen(fname);
    P = rand(N,k)*sqrt(R/k);
    Q = rand(M,k)*sqrt(R/k);
    for j = 1:max_iter
        frewind(fid);        
        bufferSize = 1e4; % scan through the file once
        buffer = reshape(fscanf(fid, '%d\t%d\t%g', bufferSize),3,[])' ;
        while ~isempty(buffer)
            for ix = 1:size(buffer,1)
                vals = buffer(ix,:);
                i = vals(1);
                u = vals(2);
                r = vals(3);
                % do one SGD step
                p = P(i,1:k);
                q = Q(u,1:k);
                eps = r - q*p';
                p_new = p + eta*(eps*q - lambda*p);
                q_new = q + eta*(eps*p - lambda*q);
                P(i,:) = p_new;
                Q(i,:) = q_new;                         
            end
            buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
        end
    end
    fclose(fid);
end