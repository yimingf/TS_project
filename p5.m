% kth sf2943 tidsan17 (time series analysis) project problem 5 (chosen data analysis).
% used 'CO2 (ppm) mauna loa, 1965-1980' data from https://datamarket.com/data/set/22v1/co2-ppm-mauna-loa-1965-1980#!ds=22v1&display=line
% most codes inherited from p4.

x = load('all_series/p5_data');
mean(x) % 328.4640
[N, ~] = size(x);

foo = [1:N];
plot(foo, x) % apparent trends and seasonal patterns found.

x = x-mean(x);
h = 50;
autocorr(x, h)

T = 12;
m = movmean(x, T);
xt = x-m;