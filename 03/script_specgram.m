fs = 16000;
t = (0 : fs) / fs;

% �K���ɍ�����`���[�v�M��
% ���m�ȍ����́u�`���[�v�M���v�O�O���Ă��������D
f1 = 1000;
f2 = 6000;
x = sin(2 * pi * (f1 * t + f2 / 2* t.^2));
plot(t, x);

%% ���̐M���ɑ΂��ăX�y�N�g���O�����𐶐�����

% ���֐��̒���������
win_len = round(20 / 1000 * fs); % 20 ms�ɂ���

% ���֐��iHanning���j�𐶐�
% ������F�X�Ȋ֐��ɕς��Ă݂悤�i���֐� matlab�Œ��ׂ�ΐF�X�o�Ă���j
win = hanning(win_len)'; % ��X�̉��Z�̂��߂ɉ��x�N�g����

% �t���[���V�t�g�̌���
shift_len = round(10 / 1000 * fs); % 10 ms (�����̔���)

temporal_positions = shift_len : shift_len : length(x) - shift_len;
number_of_frames = length(temporal_positions);
fft_size = 512; % ������20 ms (320�T���v��)�Ȃ̂ŁC����ȏォ��2�ׂ̂���̒���
% �X�y�N�g���O������FFT���̔���+1�ŗǂ�
output_specgram = zeros(fft_size / 2 + 1, number_of_frames);
% �Y�������g�`�͈̔͂𒴂��Ȃ��悤��for����g��
current_position = 1;
for i = 1 : shift_len : length(x) - win_len
  tmp = x(i : i + win_len - 1) .* win;
  tmp_spec = 20 * log10(abs(fft(tmp, fft_size)));
  output_specgram(:, current_position) = tmp_spec(1 : fft_size / 2 + 1);
  current_position = current_position + 1; % MATLAB�ɂ�++������
end;

imagesc([0 t(end)], [0 fs / 2], output_specgram);
colorbar; % �ő�l�ƍŏ��l�����֐��ɂ��ǂ��ς�邩�D
axis('xy'); % y���̏㉺���t�]
