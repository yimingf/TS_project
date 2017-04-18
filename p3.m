% kth sf2943 tidsan17 (time series analysis) project problem 3 (prediction).

clc, clear;
% % a) Predictions on \textbf{AR(2)} model.
% model = arima('Constant', 0, 'AR', {1.3, -0.65}, 'Variance', 280);
% 
% m = 50;
% n = 300;
% c = 0;
% 
% Y = zeros(n, m);
% param_2 = zeros(2, m);
% param_10 = zeros(10, m); % AR(10)
% 
% for i=1:m
%   Y(:, i) = simulate(model, n);
% 
%   mle = arma_mle(Y(:, i), 2, 0);
%   param_2(:, i) = mle.ar;
% 
%   mle = arma_mle(Y(:, i), 10, 0);
%   param_10(:, i) = mle.ar;
% end
% 
% predict_2   = zeros(n, m);
% predict_10  = zeros(n, m);
% K = 3;
% for i=1:m
%   predict_2 (:, i) = prediction(param_2(:, i), Y(:, i), K, c);
%   predict_10(:, i) = prediction(param_10(:, i), Y(:, i), K, c);
% end
% 
% error_2 =mean(mean((Y(1+K:n, :)-predict_2 (1+K:n, :)).^2))
% error_10=mean(mean((Y(1+K:n, :)-predict_10(1+K:n, :)).^2))
% 
% % b) Prediction on \textbf{AR(1)} model.
% model = arima('Constant', 0, 'AR', {0.8}, 'Variance', 1);
% 
% m = 50;
% n = 2000;
% Y = zeros(n, m);
% param_ar = zeros(1, m); % AR(1)
% param_ma = zeros(10, m); % MA(10)
% 
% for i=1:m
%   Y(:, i) = simulate(model, n);
%   mle = arma_mle(Y(:, i), 1, 0);
%   foo = mle.ar;
%   param_ar(i) = foo;
%   for j=1:10 % simulate MA(10) from MA(\infty) from parameter of AR(1)
%     param_ma(j, i) = foo;
%     foo = foo*mle.ar;
%   end
% end
% 
% predict_ar = zeros(n, m);
% predict_ma = zeros(n, m);
% K = 3;
% for i=1:m
%   predict_ar(:, i) = prediction(param_ar(:, i), Y(:, i), K);
%   model = arima('Constant', 0, 'MA', param_ma(:, i), 'Variance', 1); % innovation algorithm
%   predict_ma(:, i) = simulate(model, n);
% end
% 
% error_ar=mean(mean((Y(1+K:n, :)-predict_ar(1+K:n, :)).^2))
% error_ma=mean(mean((Y(1+K:n, :)-predict_ma(1+K:n, :)).^2))

% c) Prediction on non-zero mean model.
% c = 10; % the constant
% model = arima('Constant', c, 'AR', {0.8}, 'Variance', 1);

% m = 50;
% n = 500;
% Y = zeros(n, m);
% param_ar = zeros(3, m); % parameter, variance, mean

% for i=1:m
%   Y(:, i) = simulate(model, n);
%   param_ar(3, i) = mean(Y(:, i));
%   Y_norm(:, i) = Y(:, i)-mean(Y(:, i));
%   mle = arma_mle(Y_norm(:, i), 1, 0);
%   param_ar(1:2, i) = [mle.ar, mle.sigma^2];
% end

% scatter(param_ar(1, :), param_ar(2, :));

% predict_ar = zeros(n, m);
% K = 1;
% for i=1:m
%   predict_ar(:, i) = prediction(param_ar(1, i), Y(:, i), K, param_ar(3, i));
% end

% error_ar=mean(mean((Y(1+K:n, :)-predict_ar(1+K:n, :)).^2))