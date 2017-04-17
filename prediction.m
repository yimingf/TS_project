% K-step predictioin of AR(p).
function result = prediction (param, data, K, c)

p = length(param);
len = length(data);
result = zeros(1, len);
for ind=1:len
  bar = zeros(1, K-1);

  for k=1:K % for each step
    foo = 0;

    for i=1:p

      if (ind+k-1-i <= 0)
        continue;
      elseif (i<k)
        foo = foo+param(i)*bar(i);
      else
        foo = foo+param(i)*(data(ind+k-1-i)-c);
      end % if

    end % for i

    bar(k) = foo;
  end % for k

  result(ind) = foo+c;
end % for ind