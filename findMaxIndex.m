function [R,N,M] = findMaxIndex(fname, maxR, maxN, maxM)
    M = maxM;
    N = maxN;
    R = maxR;
    fid = fopen (fname);
    
    bufferSize = 1e4; % scan through the file once
    buffer = reshape(fscanf(fid, '%d\t%d\t%g', bufferSize),3,[])' ;
    while ~isempty(buffer)
        for ix = 1:size(buffer,1)
            vals = buffer(ix,:);
            currN = vals(1);
            currM = vals(2);
            currR = vals(3);
            if currN == -1
                break;
            end;      
            if currN > N
                N = currN;
            end;
            if currM > M
                M = currM;
            end;          
            if currR > R
                R = currR;
            end;
        end
        buffer = reshape(fscanf(fid, '%d\t%d', bufferSize),2,[])' ;
    end
    fclose(fid);
end
