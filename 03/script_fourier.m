% 講義用のムービーを作る
fs = 48000;
f = 1;
t = (0 : fs) / fs;
frame_rate = 30;
myVideo = VideoWriter('test.avi');
myVideo.FrameRate = frame_rate;
open(myVideo);

spec = zeros(4, 1);

for j = 1 : 4 % 使用する基底関数の周波数（Hz）
  f_fundamental = j;
  % フーリエ変換なのでcos, sinを基底関数とする（e^(-jwt)をオイラーの公式で展開）
  cos_core = cos(2 * pi * f_fundamental * t);
  sin_core = sin(2 * pi * f_fundamental * t);
  x_value_all = [];
  y_value_all = [];
    
  % 600フレーム（20秒）で2pi進める
  for i = 1 : 600
    theta = i / 600 * 2 * pi;
    % ここのxに信号を入れる．色々入れて試してみよう．
%    x = cos(2 * pi * f * t - theta) + cos(2 * pi * 3 * t); % 1 Hzと3 Hz
    x = cos(2 * pi * f * t - theta);
    subplot(2, 2, [1 2]);
    plot(t, sin_core, 'r', t, cos_core, 'b',  t, x, 'k');
    grid;
    
    % 信号と基底関数との内積を計算
    x_value = mean(x .* cos_core) * 2;
    y_value = mean(x .* sin_core) * 2;
    % 注意：配列の要素の動的変化は推奨されません．
    % 最初に必要な数の配列を用意し，各要素に値を追加する形が推奨されます．
    x_value_all = [x_value_all, x_value];
    y_value_all = [y_value_all, y_value];
    
    subplot(2, 2, 3);
    plot(x_value_all, y_value_all, 'k');
    hold on;
    plot(x_value, y_value, 'ko');
    set(gca, 'xlim', [-1.1 1.1], 'ylim', [-1.1 1.1]);
    set(gca, 'PlotBoxAspectRatio', [1 1 1]);
    grid;
    plot([0 x_value x_value], [0 0 y_value], 'r');
    plot([0 0 x_value], [0 y_value y_value], 'b');
    plot([0 x_value], [0 y_value], 'g');
    hold off;
    
    subplot(2, 2, 4);
    spec(j) = sqrt(x_value ^ 2 + y_value ^ 2);
    plot(spec, 'ko');
    hold on;
    plot([j j], [0 spec(j)], 'g', j, spec(j), 'go');
    set(gca, 'ylim', [0 1.1]);
    grid;
    hold off;
    
    M = getframe(gcf);
    writeVideo(myVideo, M);
  end
  % 2秒間ストップ
  for i = 1 : 60
    M = getframe(gcf);
    writeVideo(myVideo, M);
  end;
end;

close(myVideo);
