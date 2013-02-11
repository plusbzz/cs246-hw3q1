function [n,m,r] = readRatingLine(fid)
    txt = fgetl(fid);
    if txt == -1
        n = -1;
        m = -1;
        r = -1;
    else
        vals = strsplit(txt,"\t",true);
        n = str2num(vals{1,1});
        m = str2num(vals{1,2});
        r = str2num(vals{1,3});
    end
end