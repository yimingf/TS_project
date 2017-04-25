% kth sf2943 tidsan17 (time series analysis) project problem 4 (model selection)
clc, clear
x = load('./all_series/Data_series_1.txt');
[N, ~] = size(x);

foo = [1:N];
% plot(foo, y)

x = x-mean(x); % mean != 0, try to remove non-zero means
h = 100;
% autocorr(y, h) % found seasonal components, period T = 12

% deseasonalization
T = 12;
m = movmean(x, T);
w = zeros(T, 1);
for i=1:T
  if i == T
    w(i) = mean(x(foo(mod(foo, T)==0))-m(foo(mod(foo, T)==0)));
  else
    w(i) = mean(x(foo(mod(foo, T)==i))-m(foo(mod(foo, T)==i)));
  end % if
end % for

bar = sum(w)/T;
s = w-bar;

d = zeros(N, 1);
for i=1:T
  if i == T
    bar = foo(mod(foo, T)==0);
    d(bar) = x(bar)-s(T);
  else
    bar = foo(mod(foo, T)==i);
    d(bar) = x(bar)-s(i);
  end % if
end % for
autocorr(d, h) % some trends can be seen. try to remove the trends

y = zeros(N, 1);
for i=1:T
  if i == T
    bar = foo(mod(foo, T)==0);
    y(bar) = x(bar)-m(bar)-s(T);
  else
    bar = foo(mod(foo, T)==i);
    y(bar) = x(bar)-m(bar)-s(i);
  end % if
end % for