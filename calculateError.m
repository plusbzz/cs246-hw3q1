function E = calculateError(fname,P,Q,lambda)
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
        E = E + (r - q*p')^2;
    end
    fclose(fid);       
end