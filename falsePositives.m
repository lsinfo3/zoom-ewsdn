function res = falsePositives(indy, flows, k)
    n = length(indy);
    max = length(flows.bps);
    %range = max-n+1;
    range = max-(n*k);
    orig = max:-1:range;
    matches = intersect(orig(:), indy(:));
    res = n-length(matches);
end