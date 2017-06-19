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
y = x-m-sst; % the model is now MA(2).

subplot(2,1,1)
autocorr(y)
subplot(2,1,2)
parcorr(y)

EstMdl = estimate(arima(0,0,2),y);
