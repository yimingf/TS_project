clear;
n = 500;
mu = 0;
sigma = 1;
y = sigma * randn(n, 1) + mu;
acf = autocorr(y, 499);
pacf = parcorr(y);

var = 1/n;
acf_std = (acf - mu) / sqrt(var);
h = kstest(acf_std);

figure(1)
x = 1:1:n;
plot(y)
title('White noise');
xlabel('Sample');
ylabel('Sample Values');
grid on;

figure(2)
x = 1:1:n;
autocorr(y)
grid on;






