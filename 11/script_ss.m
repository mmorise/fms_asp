% SS�@�̊ȒP�ȃe�X�g
[x, fs] = audioread('coffee.wav');
x = x ./ sqrt(sum(x .^ 2));
t = (0 : length(x) - 1) / fs * 1000;
n = randn(length(x), 1);
n = n ./ sqrt(sum(n .^ 2)) / 2; % ����͐U���Ȃ̂�6 dB
y = x + n;

fft_size = 256;
frame_length = 128;

% �ŏ���6�t���[���̎G�����猸�Z�p�X�y�N�g���𓾂�
n_power = zeros(fft_size, 1);
for i = 1 : 6
  tmp = n((i - 1) * frame_length + 1 : i * frame_length);
  n_power = n_power + abs(fft(tmp, fft_size)) .^ 2;
end;
n_power = n_power / 6; % ���ς����߂�

alpha = 2.0;
beta = 0.01;

y_ss = zeros(length(y), 1);
for i = 1 : 770 % �Ō�̕��܂Łi�K���Ɍ��߂��j
  tmp = y((i - 1) * frame_length + 1 : i * frame_length);
  
  % �X�y�N�g�������߂�
  y_spec = fft(tmp, fft_size);
  y_power = abs(y_spec) .^ 2; % �p���[
  y_phase = angle(y_spec); % �ʑ�
  
  for j = 1 : fft_size % ���ۂ͔����ŗǂ�
    if y_power(j) - alpha * n_power(j) > beta * y_power(j)
      y_power(j) = y_power(j) - alpha * n_power(j);
    else
      y_power(j) = beta * y_power(j);
    end;
  end;

  % �g�`�ɖ߂�
  y_spec_ss = sqrt(y_power) .* exp(1i * y_phase);
  tmp_y_ss = real(ifft(y_spec_ss));
  y_ss((i - 1) * frame_length + 1 : (i - 1) * frame_length + fft_size) =...
    tmp_y_ss;
end;

%% �\������
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
