% kth sf2943 tidsan17 (time series analysis) project problem 6 (garch model).
% some data retrieved from quantlab.

% GARCH(2. 2) model fitted from 01/01/2017 to 03/05/2017.
% we want to fit 95% confidence level for stock price of **04/05/2017**.
clc, clear
% % 1.
% foo = [0.000034021 0.064860136 0.000000006 0.000817247 0.006258225];
% bar = [0.000000000 0.047206106];
% alpha_0 = foo(1);
% alpha = [foo(2) bar(1)];
% beta_ = [foo(3) bar(2)];
% mean_ = foo(4);
% std_ = foo(5);
% s_0 = 1633.99; % stock price of **03/05/2017**.
% 
% mu = 0;
% z = [0.005830305 -0.001541706]; % log-reutrns distribution
% v = [-0.001926 -0.002670];
% var_ = alpha_0+alpha*z'+beta_*v'; % 2.8614e-04
% 
% num = 100;
% s_k = zeros(num, 1);
% for i=1:num
%   x_t = randn()*sqrt(var_);
%   y_t = mu+x_t;
%   s_k(i) = s_0*exp(y_t); % 1.6870e+03
% end
% 
% var_ = var(s_k);
% q_95_up_garch = mean(s_k)+1.96*sqrt(var_);
% q_95_down_garch = mean(s_k)-1.96*sqrt(var_);
% 
% 
% % naive approach.
% s_k = zeros(num, 1);
% for i=1:num
%   s_k(i) = s_0*exp(sqrt(abs(v(1)))*randn());
% end
% var_ = var(s_k);
% q_95_up_naive = mean(s_k)+1.96*sqrt(var_); % 1.7640e+03
% q_95_down_naive = mean(s_k)-1.96*sqrt(var_);

% % 2.
% % 2010-08-25 is 250 days before 2011-08-18.
% % using GARCH(2, 2).
% clc, clear
% alpha_0 = 0.0000009838;
% alpha = [0.043909004 0.191871594];
% beta_ = [0.032837324 0.686450789];
% mean_ = -0.00043583;
% std_ = 0.01251815;
% s_0 = 893.0758; % too small...
% 
% v = zeros(12, 1);
% x = zeros(12, 1);
% v(1:2) = [-0.07 0]; 
% x(1:2) = [-0.069248 -0.0692479];
% num = 100;
% s_k = zeros(num, 1);
% 
% for j=1:num
%   for i=1:10
%     var_ = alpha_0+alpha*v(i:i+1)+beta_*x(i:i+1);
%     x_t = randn()*sqrt(abs(var_));
% 
%     v(i+2) = var_;
%     x(i+2) = x_t;
%   end
%   sum_x = sum(x(3:12));
%   exp_x = exp(sum_x);
%   s_k(j) = s_0*exp(mean(x(3:12)));
% end
% 
% var_ = var(s_k);
% mmean = mean(s_k);
% q_05_down = mean(s_k)-1.96*sqrt(var_); % -1.7703e+04
% q_05_up = mean(s_k)+1.96*sqrt(var_);


% % 2013-04-25 is 250 days before 2014-04-24.
% clc, clear
% alpha_0 = 0.000025131;
% alpha = [0.103642507 0];
% beta_ = [0.011588480 0.520348628];
% mean_ = 0.00053760;
% std_ = 0.00834714;
% s_0 = 1365.266650; % too small...
% 
% v = zeros(12, 1);
% x = zeros(12, 1);
% v(1:2) = [0.008443 0.0084427]; 
% x(1:2) = [0.01 -0.01];
% num = 100;
% s_k = zeros(num, 1);
% 
% for j=1:num
%   for i=1:10
%     var_ = alpha_0+alpha*v(i:i+1)+beta_*x(i:i+1);
%     x_t = randn()*sqrt(abs(var_));
% 
%     v(i+2) = var_;
%     x(i+2) = x_t;
%   end
%   s_k(j) = s_0*exp(mean(x(3:12)));
% end
% 
% var_ = var(s_k); % mean = 1.8356e+03
% q_05_down = mean(s_k)-1.96*sqrt(var_); % -1.1036e+03
% q_05_up = mean(s_k)+1.96*sqrt(var_);

% 20 June 2014 (2014-06-20) is 250 business days before 2015-06-18.
clc, clear
alpha_0 = 0.000018180;
alpha = [0.114912880 0.048417068];
beta_ = [0.192061769 0.462323152];
s_0 = 1562.42;

v = zeros(12, 1);
x = zeros(12, 1);
v(1:2) = [-0.003670 -0.003669843]; 
x(1:2) = [0.00 -0.01];
num = 100;
s_k = zeros(num, 1);

for j=1:num
  for i=1:10
    var_ = alpha_0+alpha*v(i:i+1)+beta_*x(i:i+1);
    x_t = randn()*sqrt(abs(var_));

    v(i+2) = var_;
    x(i+2) = x_t;
  end
  s_k(j) = s_0*exp(mean(x(3:12)));
end

var_ = var(s_k); % mean = 2.1933e+03
q_05_down = mean(s_k)-1.96*sqrt(var_); % -3.5407e+03
q_05_up = mean(s_k)+1.96*sqrt(var_);