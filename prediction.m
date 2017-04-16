% one step predictioin of AR(2).
function P = prediction(param, data)
len = length(data);
P = zeros(1, len);
for i=1:len
    if i==1
        p = 0;
    elseif i==2
        p = param(1) * data(i-1);
    else
        p = param(1) * data(i-1) + param(2) * data(i-2);
    end
    P(i) = p;
end
end