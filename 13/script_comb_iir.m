fs = 48000;
fft_size = 65536;
w = (0 : fft_size - 1) * fs / fft_size;
x = zeros(fft_size, 1);
x(1) = 1;
alpha = 0.99;

for f0 = [100 : 1 : 300, 299 : -1 : 100]
  delay = round(fs / f0);
  y = zeros(fft_size, 1);
  for i = 1 : fft_size
    if i > delay
      y(i) = x(i) + alpha * y(i - delay);
    else
      y(i) = x(i);
    end;
  end;
  spec = 20 * log10(abs(fft(y, fft_size)));
  spec = spec - max(spec);
  plot(w, spec);
  set(gca, 'xlim', [0 1000]);
  set(gca, 'ylim', [-30 5]);
  grid;
  pause(0.01);
end;

for alpha = [0.99 : -0.01 : -0.99]
  y = zeros(fft_size, 1);
  for i = 1 : fft_size
    if i > delay
      y(i) = x(i) + alpha * y(i - delay);
    else
      y(i) = x(i);
    end;
  end;
  spec = 20 * log10(abs(fft(y, fft_size)));
  spec = spec - max(spec);
  plot(w, spec);
  set(gca, 'xlim', [0 1000]);
  set(gca, 'ylim', [-30 5]);
  grid;
  pause(0.01);
end;
