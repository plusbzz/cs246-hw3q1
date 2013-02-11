function [M,N] = findMaxIndex(fname, maxM, maxN)
    M = maxM;
    N = maxN;
    fid = fopen (fname);
    while true
        [currN,currM,currR] = readRatingLine(fid);
        if currN == -1
            break;
        end;      
        if currN > N
            N = currN;
        end;
        if currM > M
            M = currM;
        end;          
    end;
    fclose(fid);
end
