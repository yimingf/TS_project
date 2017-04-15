% kth sf2943 tidsan17 (time series analysis) project problem 2 (parameter estimation).

clc, clear;
model = arima('Constant', 0, 'AR', {1.3, -0.65}, 'Variance', 280);

m = 50; % number of samples.
n = 500; % size of data.
rng('default');
Y = cell(1, m);
param_mle = zeros(2, m);
param_yule = zeros(2, m);
for i=1:m
  Y{i} = simulate(model, n); % generate data

  mle = arma_mle(Y{i}, 2, 0);
  param_mle(:, i) = mle.ar; % estimate by ml

  [d, ~] = aryule(Y{i}, 2);
  param_yule(:, i) = d(2:3)';
end

figure(1)
scatter(param_mle(1, :), param_mle(2, :));
title('Scatter plot of ML estimation');
grid on;

figure(2)
scatter(param_yule(1, :), param_yule(2, :));
title('Scatter plot of Yule-Walker estimation');
grid on;
