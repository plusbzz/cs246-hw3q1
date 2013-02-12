function [R,N,M] = findMaxIndex(fname, maxR, maxN, maxM)
    M = maxM;
    N = maxN;
    R = maxR;
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
        if currR > R
            R = currR;
        end;
    end;
    fclose(fid);
end
