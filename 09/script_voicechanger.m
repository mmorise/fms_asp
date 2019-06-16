[x, fs] = audioread('vaiueo2d.wav');
r = Harvest(x, fs);
q = D4C(x, fs, r);
f = CheapTrick(x, fs, q);

y = Synthesis(q, f);

q2 = q;
q2.f0 = q2.f0 * 2;
f2 = f;
f2.spectrogram = StretchSpectrum(f2.spectrogram, 1.4);

y2 = Synthesis(q2, f2);
