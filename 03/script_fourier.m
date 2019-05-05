% �u�`�p�̃��[�r�[�����
fs = 48000;
f = 1;
t = (0 : fs) / fs;
frame_rate = 30;
myVideo = VideoWriter('test.avi');
myVideo.FrameRate = frame_rate;
open(myVideo);

spec = zeros(4, 1);

for j = 1 : 4 % �g�p������֐��̎��g���iHz�j
  f_fundamental = j;
  % �t�[���G�ϊ��Ȃ̂�cos, sin�����֐��Ƃ���ie^(-jwt)���I�C���[�̌����œW�J�j
  cos_core = cos(2 * pi * f_fundamental * t);
  sin_core = sin(2 * pi * f_fundamental * t);
  x_value_all = [];
  y_value_all = [];
    
  % 600�t���[���i20�b�j��2pi�i�߂�
  for i = 1 : 600
    theta = i / 600 * 2 * pi;
    % ������x�ɐM��������D�F�X����Ď����Ă݂悤�D
%    x = cos(2 * pi * f * t - theta) + cos(2 * pi * 3 * t); % 1 Hz��3 Hz
    x = cos(2 * pi * f * t - theta);
    subplot(2, 2, [1 2]);
    plot(t, sin_core, 'r', t, cos_core, 'b',  t, x, 'k');
    grid;
    
    % �M���Ɗ��֐��Ƃ̓��ς��v�Z
    x_value = mean(x .* cos_core) * 2;
    y_value = mean(x .* sin_core) * 2;
    % ���ӁF�z��̗v�f�̓��I�ω��͐�������܂���D
    % �ŏ��ɕK�v�Ȑ��̔z���p�ӂ��C�e�v�f�ɒl��ǉ�����`����������܂��D
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
  % 2�b�ԃX�g�b�v
  for i = 1 : 60
    M = getframe(gcf);
    writeVideo(myVideo, M);
  end;
end;

close(myVideo);
