% kth sf2943 tidsan17 (time series analysis) project problem 2 (parameter estimation).

clear;
model = arima('Constant', 0, 'AR', {1.3, -0.65}, 'Variance', 280);

m = 500;
rng('default')
Y = simulate(model, m);

% d is the estimated model parameter from Yule-Walker estimation
% p error variance
[d, p] = aryule(Y,2);

figure(1)
plot(Y)
xlim([0, m])
title('Simulated AR(2) Process')

figure(2)
autocorr(Y, 50)
grid on;
