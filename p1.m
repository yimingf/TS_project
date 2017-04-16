% kth sf2943 tidsan17 (time series analysis) project problem 1 (white noise)

clear;
% 1. generate iid ts datas.
n = 100000; % size n
mu = 0;
sigma = 1;
h = 4; % lag
% y = sigma*randn(n, 1)+mu; % simulate iid samples
% rho = autocorr(y, h);
% pacf = parcorr(y);

% 2. different tests.
% (a) test the claim that p(h) has gaussian distribution with mean zero and variance 1/n.
% var = 1/n;
% h_1 = kstest(rho/sqrt(var));

% % (b) the portmanteau test (ljung-box q-test).
% h_2 = lbqtest(rho-mean(y));

% 3. test with different models such as AR and MA.
ar = arima('Constant',0.05,'MA',{0.7},'Variance',0.01); % AR(3) model.
y = simulate(ar, n);
rho = autocorr(y, h);

% (a) test the claim that p(h) has gaussian dist w/ mean 0 and variance 1/n.
var = 1/n;
h_1 = kstest(rho/sqrt(var));

% (b) the portmanteau test (ljung-box q-test).
h_2 = lbqtest(rho-mean(y));

% figure(1)
% x = 1:1:n;
% plot(y)
% title('White noise');
% xlabel('Sample');
% ylabel('Sample Values');
% grid on;

figure(2)
x = 1:1:n;
autocorr(y)
grid on;