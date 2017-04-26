% kth sf2943 tidsan17 (time series analysis) project problem 3 (prediction).
% dedicated for problem 4 only.
% use AICC statistics for selecting the orders (p, q) for given dataset.

function [p, q] = order_selection(y, max_p, max_q)

aicc = zeros(max_p, max_q);
yt = iddata(y);

for i=1:max_p
  for j=1:max_q
    th = armax(yt, [i j]);
    aicc(i, j) = aic(th, 'AICc');
  end % for j
end % for i

[p, q] = find(aicc==min(aicc(:)));