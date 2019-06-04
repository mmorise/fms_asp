% 短時間フーリエ変換によるスペクトルの解析ムービー
[x, fs] = audioread('vaiueo2d.wav');

fft_size = 8192;
w = (0 : fft_size - 1) * fs / fft_size;
win_len = 1024;
win = hanning(win_len);

for i = 1 : 10 : length(x) - win_len
  tmp = x(i : i + win_len - 1) .* win;
  subplot(2, 1, 1);
  plot((0 : length(x) - 1) / fs, x);
  hold on;
  plot([i, i, i + win_len - 1, i + win_len - 1] / fs, [-1 1 1 -1], 'k');
  hold off;
  subplot(2, 1, 2);
  plot(w, 20 * log10(abs(fft(tmp, fft_size))));
  set(gca, 'xlim', [0 4000]);
  set(gca, 'ylim', [-20 40]);
  grid;
  pause(0.01);
end;
