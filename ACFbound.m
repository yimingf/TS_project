% implementation of test (a) in Section 1.6
function h = ACFbound(data, lag)
[rho,~,bounds] = autocorr(data, lag);
out_of_bounds = 0;
for i=2:length(rho)
    if rho(i)>bounds(1) || rho(i)<bounds(2)
        out_of_bounds = out_of_bounds + 1;
    end
end
if out_of_bounds < 3
    h = 0;
else
    h = 1;
end