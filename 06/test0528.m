fs = 48000;
f0 = 100;
t0 = round(fs / f0);

x = zeros(fs, 1);
for i = 1 : t0 : length(x)
  x(i) = 1;
end;

win = hanning(t0 * 4);
fft_size = 8192;
w = (0 : fft_size - 1) * fs / fft_size;
for i = 1 : t0 * 10
  tmp = x(i : i + length(win) - 1) .* win;
  subplot(2, 1, 1);
  plot(tmp); hold on;
  plot(win); hold off;

  cep = ifft(log(abs(fft(tmp, fft_size))));
  subplot(2, 1, 2);
  plot(cep);
  set(gca, 'xlim', [0 1000]);
  set(gca, 'ylim', [-1 1]);
%   subplot(2, 1, 2);
%   plot(w, abs(fft(tmp, fft_size)));
%   set(gca, 'xlim', [0 400], 'ylim', [0 1]);
  pause(0.01);
end;

