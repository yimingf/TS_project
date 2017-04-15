% kth sf2943 tidsan17 (time series analysis) project problem 3 (prediction).

clc, clear;
% 1. AR(2) process
model = arima('Constant', 0, 'AR', {1.3, -0.65}, 'Variance', 280);

m = 50; % number of samples.
n = 500; % size of data.
rng('default');

Y = cell(1, m);
param_mle = zeros(2, m);
param_yule = zeros(10, m); % AR(10)

for i=1:m
  Y{i} = simulate(model, n); % generate data

  mle = arma_mle(Y{i}, 2, 0);
  param_mle(:, i) = mle.ar;

  [d, ~] = aryule(Y{i}, 10);
  param_yule(:, i) = d(2:11)';
end

K = 1;
sys = idpoly([1, -1.3, 0.65], [], 1, 1, [], 280) % create a model
yp = predict(sys, Y{6}, K) % predict with K-steps

% 2. AR(1) process
model = arima('Constant', 0, 'AR', {0.8}, 'Variance', 1);

param_mle = zeros(10, m); % MA(10)
param_yule = zeros(1, m); % AR(1)

for i=1:m
  Y{i} = simulate(model, n); % generate data
  [d, ~] = aryule(Y{i}, 1);
  foo = d(2);
  param_yule(i) = foo;
  for j=1:10
    param_mle(j, i) = foo^j;
  end
end