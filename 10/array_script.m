% アレイ信号処理の簡単なシミュレーション
fs = 48000;
d = 1;
t = (0 : fs) / fs;
f = 10;
x_axis = 0 : 0.01 : 2 * pi;
power_list = zeros(length(0 : 0.01 : 2 * pi), 1);
count = 1;

close all;
figure;
for i = x_axis
  subplot(2, 2, 1)
  x_p = sin(i);
  y_p = cos(i);
  plot(x_p, y_p, 'o');
  set(gca, 'xlim', [-1 1], 'ylim', [-1 1]);
  grid;
  
  subplot(2, 2, [3, 4]);
  x = sin(2 * pi * f * t);
  y = sin(2 * pi * f * t + d*sin(i));
  plot(t, x, t, y, t, x + y);
  set(gca, 'ylim',[-2 2]);
  grid;
  pause(0.01);
  
  subplot(2, 2, 2);
  power_list(count) = sum((x + y) .^ 2);
  plot(x_axis, power_list);
  set(gca, 'xlim', [0 2 * pi]);
  count = count + 1;
end;

