function E = calculateError(fname,P,Q,mu,Bu,Bi,lambda)
    fid = fopen (fname);
    E = 0;
    k = size(Q,2);
    while true
        [i,u,r] = readRatingLine(fid);
        if i == -1
            break;
        end
        p = P(i,1:k);
        q = Q(u,1:k);
        bu = Bu(u,1);
        bi = Bi(i,1);
        
        E = E + (r - mu - bu - bi - q*p')^2;
    end
    fclose(fid);       
end
