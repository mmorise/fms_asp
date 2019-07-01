% SS法の簡単なテスト
[x, fs] = audioread('coffee.wav');
x = x ./ sqrt(sum(x .^ 2));
t = (0 : length(x) - 1) / fs * 1000;
n = randn(length(x), 1);
n = n ./ sqrt(sum(n .^ 2)) / 2; % これは振幅なので6 dB
y = x + n;

fft_size = 256;
frame_length = 128;

% 最初の6フレームの雑音から減算用スペクトルを得る
n_power = zeros(fft_size, 1);
for i = 1 : 6
  tmp = n((i - 1) * frame_length + 1 : i * frame_length);
  n_power = n_power + abs(fft(tmp, fft_size)) .^ 2;
end;
n_power = n_power / 6; % 平均を求める

alpha = 2.0;
beta = 0.01;

y_ss = zeros(length(y), 1);
for i = 1 : 770 % 最後の方まで（適当に決めた）
  tmp = y((i - 1) * frame_length + 1 : i * frame_length);
  
  % スペクトルを求める
  y_spec = fft(tmp, fft_size);
  y_power = abs(y_spec) .^ 2; % パワー
  y_phase = angle(y_spec); % 位相
  
  for j = 1 : fft_size % 実際は半分で良い
    if y_power(j) - alpha * n_power(j) > beta * y_power(j)
      y_power(j) = y_power(j) - alpha * n_power(j);
    else
      y_power(j) = beta * y_power(j);
    end;
  end;

  % 波形に戻す
  y_spec_ss = sqrt(y_power) .* exp(1i * y_phase);
  tmp_y_ss = real(ifft(y_spec_ss));
  y_ss((i - 1) * frame_length + 1 : (i - 1) * frame_length + fft_size) =...
    tmp_y_ss;
end;

%% 表示する
specgram_x = 20 * log10(abs(specgram(x)));
specgram_x = specgram_x - max(specgram_x(:));
specgram_x = max(-60, specgram_x);
figure; imagesc([0 length(x) / fs], [0 fs / 2], specgram_x); axis('xy');
set(gca, 'ylim', [0 8000]);

specgram_y = 20 * log10(abs(specgram(y)));
specgram_y = specgram_y - max(specgram_y(:));
specgram_y = max(-60, specgram_y);
figure; imagesc([0 length(x) / fs], [0 fs / 2], specgram_y); axis('xy');
set(gca, 'ylim', [0 8000]);

specgram_yss = 20 * log10(abs(specgram(y_ss)));
specgram_yss = specgram_yss - max(specgram_yss(:));
specgram_yss = max(-60, specgram_yss);
figure; imagesc([0 length(x) / fs], [0 fs / 2], specgram_yss); axis('xy');
set(gca, 'ylim', [0 8000]);
