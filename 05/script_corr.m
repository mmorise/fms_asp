[x, fs] = audioread('vaiueo2d.wav');

x = x(3600 : 4300); % 適当に切り出す（長さは31.8 ms）
t = (0 : length(x) - 1) / fs;
autocorrelation = zeros(length(x), 1);
normalization = sum(x .^ 2);

close all;
h = figure;
set(h, 'Position', [100 260 880 1000]);
for i = 1 : length(x)
  y = [x(i : length(x)); zeros(i - 1, 1)];
  tmp = x .* y;
  autocorrelation(i) = sum(tmp) / normalization;
  subplot(3, 1, 1);
  plot(t, x, t, y);
  grid;
  
  subplot(3, 1, 2);
  plot(t, tmp);
  set(gca, 'ylim', [-0.2 0.2]);
  grid;
  
  subplot(3, 1, 3);
  plot(t, autocorrelation);
  set(gca, 'ylim', [-1 1]);
  grid;
  
  pause(0.1);
end;

