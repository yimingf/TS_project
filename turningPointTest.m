% implement Section 1.6 (c) turning point test
function h = turningPointTest(data)
len = length(data);
mean_T = 2*(len-2)/3;
var_T = (16*len-29)/90;
T = 0;
for i=2:len-1
    if data(i)>data(i-1) && data(i)>data(i+1)
        T = T + 1;
    elseif data(i)<data(i-1) && data(i)<data(i+1)
        T = T + 1;
    else
    end
end
if abs(T - mean_T)/sqrt(var_T) > 1.96
    h = 1;
else
    h = 0;
end
