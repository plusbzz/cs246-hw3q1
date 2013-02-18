function E = calculateError(fname,P,Q)
    fid = fopen (fname);
    E = 0;
    k = size(Q,2);

    bufferSize = 3e4; % scan through the file once
    buffer = reshape(fscanf(fid, '%d\t%d\t%g', bufferSize),3,[])' ;
    while ~isempty(buffer)
        for ix = 1:size(buffer,1)
            vals = buffer(ix,:);
            u = vals(1);
            i = vals(2);
            r = vals(3);
            p = P(u,1:k);
            q = Q(i,1:k);
            E = E + (r - q*p')^2;
        end
        buffer = reshape(fscanf(fid, '%d\t%d\t%g', bufferSize),3,[])' ;
    end
    fclose(fid);       
end
