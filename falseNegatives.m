function res = falseNegatives(indy, flows)
    n = length(indy);
    max = length(flows.bps);
    range = max-n;
    %range = max-10;
    orig = max:-1:range;
    matches = intersect(orig(:), indy(:));
    res = n-length(matches);
end