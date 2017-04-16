% one step predictioin of AR(2).
function P = prediction(param, data)
len = length(data);
P = zeros(1, len);
for i=2:len
    p = param(1) * data(i+1) + param(2) * data(i);
    P(i) = p;
end
end