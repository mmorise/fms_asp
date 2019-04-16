% �u�`�p�̃��[�r�[�����
fs = 48000;
f = 9;
t = (0 : fs * 2) / fs;
frame_rate = 30;
myVideo = VideoWriter('test.avi');
myVideo.FrameRate = frame_rate;
open(myVideo);

color_range = [0.8 0.8 0.8];
v_range = [-1.2 1.2];
circle_gray = [0.5 0.5 0.5];

coef = 1 / 600; % 1�t���[��������̎���
% 60 �t���[����100 ms�i�߂�
for i = 1 : 600
  subplot(2, 1, 1);
  plot([0.5 0.5], [-1 1], 'color', color_range);
  hold on;
  plot(0.5, sin(2 * pi * f * (0.5 + i * coef)), 'ko');  
  plot(t, sin(2 * pi * f * (t + i * coef)), 'b');
  DrawMicrophone(0.5 - 0.015, 0, 0.015, 0.1);
  hold off;
  set(gca, 'xlim', [0 1]);
  set(gca, 'ytick', []);
  set(gca, 'xtick', []);
  set(gca, 'ylim', v_range);
  title_text = sprintf('%04.2f ms', i / 600 * 1000);
  title(title_text);
  
  subplot(2, 1, 2);
  plot([0 0], v_range, 'color', color_range);
  hold on;
  for j = 0.1 : 0.1 : 0.9
    plot([j j], v_range, 'color', color_range);
  end;
  
  plot(i * coef, sin(2 * pi * f * (0.5 + i * coef)), 'o', 'color', circle_gray);
  
  for j = 0 : 60 : i - 1
    plot(j * coef, sin(2 * pi * f * (0.5 + j * coef)), 'ko');
  end;
  hold off;
  
  xlabel('Time (s)');
  set(gca, 'ytick', []);
  set(gca, 'xtick', [0 : 0.1 : 1]);
  set(gca, 'ylim', v_range);
  
  % �����܂łŐ}����������̂ŁC��������W�{�_�ł̃t���b�V��
  if rem(i, 60) == 0
    for j = 1 : 30
      subplot(2, 1, 1);
      c = 0.8 * ((abs(j - 15) / 15) .^ 0.5); % �����v�Z���ς����ǂ�����ۂ�����OK
      color_flash = [c c c];
      hold on;
      plot([0.5 0.5], [-1 1], 'color', color_flash);
      DrawMicrophone(0.5 - 0.015, 0, 0.015, 0.1);
      hold off;
      
      subplot(2, 1, 2);
      hold on;
      c = 0.5 - j / 60;
      color_flash = [c c c];
      plot(i * coef, sin(2 * pi * f * (0.5 + i * coef)), 'o', 'color', color_flash);
      hold off;

    	M = getframe(gcf);
      writeVideo(myVideo, M);
    end;
  end;
  
	M = getframe(gcf);
  writeVideo(myVideo, M);
end

close(myVideo);
