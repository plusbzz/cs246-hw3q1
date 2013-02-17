function [n,m,r] = readRatingLine(fid)
    txt = fgetl(fid);
    if txt == -1
        n = -1;
        m = -1;
        r = -1;
    else
        [vals,cnt] = sscanf(txt,'%d\t%d\t%g');
        n = vals(1);
        m = vals(2);
        r = vals(3);
    end
end