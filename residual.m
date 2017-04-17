% dedicated for p2 only.

function r = residual (param, data)

len = length(data);
r = zeros(1, len);
for i=1:len
  if i==1
    r(i) = data(i);
  elseif i==2
    r(i) = data(i)-param(1)*data(i-1);
  else
    r(i) = data(i)-param(1)*data(i-1)-param(2)*data(i-2);
  end
end