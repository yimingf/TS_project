% kth sf2943 tidsan17 (time series analysis) project problem 2 (parameter estimation).

clc, clear;
model = arima('Constant', 0, 'AR', {1.3, -0.65}, 'Variance', 280);

m = 50; % number of samples.
n = 100; % size of data.
% rng('default');
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

% one step prediction from mle & yule
Y_predict_mle = cell(1, m);
Y_predict_yule = cell(1, m);
for i=1:m
    P = prediction(param_mle(:, i), Y{i});
    Y_predict_mle{i} = P;
    P = prediction(-param_yule(:, i), Y{i});
    Y_predict_yule{i} = P;
end

% one step mean-squared prediction error 
error_mle = 0;
error_yule = 0;
for i=1:m
    for j=1:n
        error_mle = error_mle + (Y{i}(j) - Y_predict_mle{i}(j))^2;
        error_yule = error_yule + (Y{i}(j) - Y_predict_yule{i}(j))^2;
    end
end
error_mle = error_mle / (m * n);
error_yule = error_yule / (m * n);


figure(1)
scatter(param_mle(1, :), param_mle(2, :));
title('Scatter plot of ML estimation');
grid on;

figure(2)
scatter(param_yule(1, :), param_yule(2, :));
title('Scatter plot of Yule-Walker estimation');
grid on;

figure(3)
foo = (1: n);
plot(foo, Y{1}, foo, Y_predict_mle{1})

figure(4)
foo = (1: n);
plot(foo, Y{1}, foo, Y_predict_yule{1})

