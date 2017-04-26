% kth sf2943 tidsan17 (time series analysis) project problem 4 (model selection)
clc, clear
addpath ./src

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

%{
  now we have the deseasonalized data with trends removed.
  try to fit with AR/MA/ARMA models.
  since the first 5 ACF points are beyond the confidence level we try AR(5) first.
%}

mle = arma_mle(y, 5, 0);
% mle = arma_mle(y, 6, 0); % not suitable.

%{
  for validation of the model we could apply residual analysis.

  we have finished analysing dataset 1.
  it contains a small ascending trend, a seasonal compoment with period 12 (does the dataset come from a monthly report?), a mean value of around 180, and an autoregression (AR(5)) component.

  we will now move on to dataset 2.
%}

clc, clear
x = load('./all_series/Data_series_2.txt');
[N, ~] = size(x);

foo = [1:N];
% plot(foo, x)
x = x-mean(x); % mean != 0, try to remove non-zero means
h = 100;
% autocorr(x, h) % found seasonal components, period T = 12

% deseasonalization
T = 12;
m = movmean(x, T);
xt = x-m;

% below codes are de(season|trend)-izing calculations from mathworks documentation.
sidx = cell(T,1);
for i = 1:T
 sidx{i,1} = i:T:N;
end

sst = cellfun(@(x) mean(xt(x)),sidx);
nc = floor(N/T); % no. complete years
rm = mod(N, T); % no. extra months
sst = [repmat(sst, nc, 1); sst(1:rm)];

sBar = mean(sst); % for centering
sst = sst-sBar;

dt = x-sst; % now we have deseasonalized data. 
mle = arma_mle(dt, 1, 0);

%{
  we have finished analysing dataset 2.
  it contains a seasonal compoment with period 12 (does the dataset come from a monthly report?), a mean value of around 85, and an autoregression (AR(1)) component.

  now we will proceed to dataset 3.
%}

clc, clear
x = load('./all_series/Data_series_3.txt');
[N, ~] = size(x);

foo = [1:N];
% plot(foo, x)

h = 100;
x = x-mean(x); % almost zero-mean, but we still need this step to ensure a pure zero mean dataset.
autocorr(x, h) % the ACF plot corresponds to a figure on the textbook (3-3), so we try MLE with AR(2) model.
mle = arma_mle(x, 2, 0);

%{
  we have finished analysing dataset 3.
  it contains a mean value around 0.01 and an autoregression (AR(2)) model.

  now we will move on to dataset 4.
%}

clc, clear
x = load('./all_series/Data_series_4.txt');
[N, ~] = size(x);

foo = [1:N];
% plot(foo, x)
h = 100;
x = x-mean(x);
autocorr(x, h) % trend detected, try to remove the trends

T = 30;
m = movmean(x, T);
autocorr(m, h) % steadily decreasing ACF plot.
xt = x-m;
% plot(foo, xt) % the trends are removed successfully.
autocorr(xt, h) % try AR(p) model.
mle = arma_mle(xt, 2, 2); % ARMA(2, 2) sufficiently fits the model.

%{
  we have finished analysing dataset 4.
  it contains an ascending trend, a mean value around 1.09 and an ARMA(2, 2) model.

  we will proceed to dataset 5.
%}

clc, clear
x = load('./all_series/Data_series_5.txt');
[N, ~] = size(x);

foo = [1:N];
plot(foo, x) % an increasing-then-decreasing trend was found. try to remove the trend
x = x-mean(x); 

T = 20;
h = 100;
m = movmean(x, T);
% autocorr(m, h)
xt = x-m;
plot(foo, xt) % the trend was successfully removed
