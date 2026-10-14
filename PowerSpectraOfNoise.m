%Clear plots

clf;

%Sampling frequency

fs = 1000;

%Frequency of Signal

f = 100;

%Time vector

t = (0:1/fs:1 -1/fs);

%Signal 

y = cos(2*pi*f*t);

%Noise signal 

noise = randn(1,fs);

figure(1)

subplot(2,1,1)

plot(t,y)
xlabel 'Time (s)'
ylabel 'Amplitude'

title 'Time Domain Signal Plot'

subplot(2,1,2)

plot(t,noise)
xlabel 'Time (s)'
ylabel 'Amplitude'

title 'Time Domain Noise Plot'

noise_f = abs(fft(noise));

noise_f = 2.*(noise_f(1:fs/2));

y_f = abs(fft(y));

y_f = 2.*(y_f(1:fs/2));

freq = linspace(0,fs/2,fs/2);

figure(2)

subplot(2,1,1)

plot(freq,y_f)
xlabel 'Frequency (Hz)'
ylabel 'Magnitude'
title 'Frequency Spectra of Signal'

subplot(2,1,2)



plot(freq,noise_f)
xlabel 'Frequency (Hz)'
ylabel 'Magnitude'
title 'Frequency Spectra of Noise'


figure(3)

awgn_signal = y + noise;

subplot(2,1,1)

plot(t,awgn_signal);

xlabel 'Time (s)'
ylabel 'Amplitude'

title 'Noisy Signal Time Plot'

subplot(2,1,2)

awgn_f = abs(fft(awgn_signal));

awgn_f = 2.*(awgn_f(1:fs/2));

plot(freq,awgn_f)

xlabel 'Frequency (Hz)'
ylabel 'Magnitude'

title 'Frequency Spectra of Noisy Signal'

figure(4)