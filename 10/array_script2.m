% アレイ信号処理の簡単なシミュレーション
% こちらはマイクの個数による変化を見る
fs = 48000;
d = 10; % マイク間隔により空間折り返しの影響が変化
t = (0 : fs) / fs;
f = 10;
number_of_mics = 4; % マイク個数によりBeam formingの差を観測
x_axis = 0 : 0.01 : 2 * pi;
power_list = zeros(length(0 : 0.01 : 2 * pi), 1);
x_list = zeros(length(0 : 0.01 : 2 * pi), 1);
y_list = zeros(length(0 : 0.01 : 2 * pi), 1);
count = 1;

close all;
figure;
max_power = 0;
for i = x_axis
  subplot(2, 2, 1)
  x_p = sin(i);
  y_p = cos(i);
  plot(x_p, y_p, 'o');
  set(gca, 'xlim', [-1 1], 'ylim', [-1 1]);
  grid;

%   subplot(2, 2, [3, 4]);
%   x = sin(2 * pi * f * t);
%   y = sin(2 * pi * f * t + d*sin(i));
%   plot(t, x, t, y, t, x + y);
%   set(gca, 'ylim',[-2 2]);
  sig_all = zeros(1, length(t));
  for j = 1 : number_of_mics
    sig_all = sig_all + sin(2 * pi * f * t + (d * (j - 1)) * sin(i));
  end;
  
  subplot(2, 2, 2);
  power_list(count) = sum(sig_all .^ 2);
  plot(x_axis, power_list);
  set(gca, 'xlim', [0 2 * pi]);
  grid;

  subplot(2, 2, 1)
  hold on;
  x_list(count) = sin(i) * power_list(count) / power_list(1);
  y_list(count) = cos(i) * power_list(count) / power_list(1);
  plot(x_list(1 : count), y_list(1 : count));
  set(gca, 'xlim', [-1 1], 'ylim', [-1 1]);
  grid;
  hold off;
  count = count + 1;
  pause(0.01);

end;

