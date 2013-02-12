function E = calculateError(fname,P,Q)
    fid = fopen (fname);
    E = 0;
    while true
        [i,u,r] = readRatingLine(fid);
        if i == -1
            break;
        end
        % if not end of file, do one SGD step
        p = P(i,1:k);
        q = Q(u,1:k);
        E = E + (r - q*p')^2;
    end
    E = E + lambda*(norm(P,"fro")^2 + norm(Q,"fro")^2);
    fclose(fid);       
end