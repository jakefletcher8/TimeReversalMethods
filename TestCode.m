t = (1:0.1:100);

Signal = sin(2*pi*t);

%Signal to noise ratio

snr = 20;

%Add Additive White Gaussian Noise to the signal 

output = awgn(Signal, snr);

%Plot the output

plot(t,output)
xlabel 'Time (s)';
ylabel 'Amplitude'
%% 


%hold on

%Find transfer function of the channel

channelTransfer = ifft(fft(output)./fft(Signal));

plot(t,channelTransfer)

xlabel 'Time (s)'
ylabel 'Amplitude'

%Flip the signal in time and plot the result

timereversal = flip(output);

%hold on

plot(t,timereversal)

%% 


%Convolve the time reversed signal with the channel's transfer functio

%finalSignal = ifft(fft(timereversal).*fft(channelTransfer));

finalSignal = awgn(timereversal,snr);

%Plot final signal

plot(finalSignal)

hold on

plot(Signal,"red");

%% 


%Find the magnitude squared transfer function

channelSquared = ifft((fft(channelTransfer)).^2);

expectedSignal = ifft(fft(channelSquared).*fft(Signal));

clf

plot(channelSquared,"green")






