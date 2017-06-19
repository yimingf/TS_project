% kth sf2943 tidsan17 (time series analysis) project problem 2 (parameter estimation).

clc, clear;
addpath ./src
model = arima('Constant', 0, 'AR', {1.3, -0.65}, 'Variance', 280);

m = 500; % number of samples.
n = 200; % size of data.
K = 1;
c = 0;
% rng('default');
Y = zeros(n, m);
param_mle = zeros(2, m);
param_yule = zeros(2, m);
for i=1:m
  Y(:, i) = simulate(model, n); % generate data

  mle = arma_mle(Y(:, i), 2, 0);
  param_mle(:, i) = mle.ar; % estimate by ml

  [d, ~] = aryule(Y(:, i), 2);
  param_yule(:, i) = d(2:3)';
end

% one step prediction from mle & yule
Y_predict_mle = zeros(n, m);
Y_predict_yule = zeros(n, m);
Y_residual_mle = zeros(n, m);
Y_residual_yule = zeros(n, m);
for i=1:m
  Y_predict_mle(:, i) = prediction(param_mle(:, i), Y(:, i), K, c);
  Y_predict_yule(:, i) = prediction(-param_yule(:, i), Y(:, i), K, c);
  Y_residual_mle(:, i) = residual(param_mle(:, i), Y(:, i));
  Y_residual_yule(:, i) = residual(-param_yule(:, i), Y(:, i));
end

% one step mean-squared prediction error
em = mean((Y-Y_predict_mle).^2);
error_mle = mean(mean((Y-Y_predict_mle).^2));
ey = mean((Y-Y_predict_yule).^2);
error_yule = mean(mean((Y-Y_predict_yule).^2));
var_residual_mle = mean(var(Y_residual_mle));
var_residual_yule = mean(var(Y_residual_yule));

% kstest for residuals are uncorrelated and same dist as Z_t
[h_mle, p_mle] = kstest(Y_residual_mle/sqrt(var_residual_mle));
[h_yule, p_yule] = kstest(Y_residual_yule/sqrt(var_residual_yule));

figure(1)
scatter(param_mle(1, :), param_mle(2, :));
title('Scatter plot of ML estimation');
grid on;

figure(2)
scatter(param_yule(1, :), param_yule(2, :));
title('Scatter plot of Yule-Walker estimation');
grid on;

figure(3)
foo = [1: n];
plot(foo, Y(:, 1), foo, Y_predict_mle(:, 1))
title('Prediction of ML estimation');

figure(4)
foo = (1: n);
plot(foo, Y(:, 1), foo, Y_predict_yule(:, 1))
title('Prediction of Yule-Walker estimation');

figure(5)
histogram(em-280, m/20);
xlabel('prediction error');
ylabel('frequency');
title('histogram of MLE prediction error');

figure(6)
histogram(em-280, m/20);
xlabel('prediction error');
ylabel('frequency');
title('histogram of Yule-Walker prediction error');

figure(7)
autocorr(Y_residual_mle(:, randi(200), 50));

