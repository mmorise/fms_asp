fs = 48000;
fft_size = 65536;
w = (0 : fft_size - 1) * fs / fft_size;

for f0 = [100 : 1 : 300, 299 : -1 : 100]
  delay = round(fs / f0);
  alpha = 1.0;
  
  h = zeros(delay, 1);
  h(1) = 1;
  h(delay) = alpha;
  
  spec = 20 * log10(abs(fft(h, fft_size)));
  spec = spec - max(spec);
  plot(w, spec);
  set(gca, 'xlim', [0 1000]);
  set(gca, 'ylim', [-30 5]);
  grid;
  pause(0.01);
end;

% ÉøÇÃÉRÉìÉgÉçÅ[Éã
for alpha = [1.0 : -0.01 : 0.01, 0 : 0.01 : 2.0]
  delay = round(fs / f0);
  
  h = zeros(delay, 1);
  h(1) = 1;
  h(delay) = alpha;
  
  spec = 20 * log10(abs(fft(h, fft_size)));
  spec = spec - max(spec);
  plot(w, spec);
  set(gca, 'xlim', [0 1000]);
  set(gca, 'ylim', [-30 5]);
  grid;
  pause(0.01);
end;
