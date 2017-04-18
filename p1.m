% kth sf2943 tidsan17 (time series analysis) project problem 1 (white noise)

clear;
% initiate size of data and lag
n = 500; % size n
h = 40; % lag

% 1. generate iid ts datas.
mu = 0;
sigma = 1;
y = sigma*randn(n, 1)+mu; % simulate iid samples
[rho,lags,bounds] = autocorr(y, h);

% 2. different tests.
% (a) test the claim that p(h) has gaussian distribution with mean zero and variance 1/n.
var = 1/n;
h_1 = kstest(rho/sqrt(var));

% (b) the portmanteau test (ljung-box q-test).
h_2 = lbqtest(rho-mean(rho));

% Section 1.6 (a) the sample autocorrelation function
h_3 = ACFbound(rho, 40);

% Section 1.6 (c) turning point test
h_4 = turningPointTest(rho);

% % 3. test with different models such as AR and MA.
% ar = arima('Constant',0.05,'MA',{0.7},'Variance',0.01); % AR(1) model.
% y = simulate(ar, n);
% % rho = autocorr(y, h);
% 
% % (a) test the claim that p(h) has gaussian dist w/ mean 0 and variance 1/n.
% var = 0.01;
% h_1 = kstest(y/sqrt(var));
% 
% % (b) the portmanteau test (ljung-box q-test).
% h_2 = lbqtest(y-mean(y));
% 
% % Section 1.6 (a) the sample autocorrelation function
% h_3 = ACFbound(y, h);
% 
% % Section 1.6 (c) turning point test
% h_4 = turningPointTest(y);

figure(1)
x = 1:1:n;
autocorr(rho, h)
grid on;

% figure(2)
% x = 1:1:n;
% plot(y)
% title('White noise');
% xlabel('Sample');
% ylabel('Sample Values');
% grid on;

