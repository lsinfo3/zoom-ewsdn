function res = mymse(indy, flows)
    n = length(indy);
    max = length(flows.bps);
    orig = max:-1:max-n+1;
    errors = orig(:)-indy(:);
    res = mean(errors.^2);
end