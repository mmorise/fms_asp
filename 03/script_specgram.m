fs = 16000;
t = (0 : fs) / fs;

% 適当に作ったチャープ信号
% 正確な作り方は「チャープ信号」ググってください．
f1 = 1000;
f2 = 6000;
x = sin(2 * pi * (f1 * t + f2 / 2* t.^2));
plot(t, x);

%% この信号に対してスペクトログラムを生成する

% 窓関数の長さを決定
win_len = round(20 / 1000 * fs); % 20 msにする

% 窓関数（Hanning窓）を生成
% ここを色々な関数に変えてみよう（窓関数 matlabで調べれば色々出てくる）
win = hanning(win_len)'; % 後々の演算のために横ベクトル化

% フレームシフトの決定
shift_len = round(10 / 1000 * fs); % 10 ms (窓長の半分)

temporal_positions = shift_len : shift_len : length(x) - shift_len;
number_of_frames = length(temporal_positions);
fft_size = 512; % 窓長が20 ms (320サンプル)なので，それ以上かつ2のべき乗の長さ
% スペクトログラムはFFT長の半分+1で良い
output_specgram = zeros(fft_size / 2 + 1, number_of_frames);
% 添え字が波形の範囲を超えないようにfor文を組む
current_position = 1;
for i = 1 : shift_len : length(x) - win_len
  tmp = x(i : i + win_len - 1) .* win;
  tmp_spec = 20 * log10(abs(fft(tmp, fft_size)));
  output_specgram(:, current_position) = tmp_spec(1 : fft_size / 2 + 1);
  current_position = current_position + 1; % MATLABには++が無い
end;

imagesc([0 t(end)], [0 fs / 2], output_specgram);
colorbar; % 最大値と最小値が窓関数によりどう変わるか．
axis('xy'); % y軸の上下を逆転
