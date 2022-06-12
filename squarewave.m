function sq = squarewave(t,cycles)
    L = length(t);
    p = ceil(L/cycles);
    pve = ones(1,p);
    nve = -ones(1,p);
    sq = [];
    for k = 1:cycles
        if rem(k,2) == 1
            sq = [sq pve];
        else
            sq = [sq nve];
    end
end

