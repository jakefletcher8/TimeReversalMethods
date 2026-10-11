%Number of points in impulse response

N = 1000;

%Impulse Response from point of source

H = randn(1,N);

%Signal from interfering source

x = (1:1:N);

figure(1);

y = sin(x/8);

plot(y);
xlabel sample
ylabel amplitude

%Send the unknown signal through the channel

detectedSignal = conv(y,H);

%Plot detected signal

figure(2);

plot(detectedSignal);
xlabel sample
ylabel amplitude


%Autocorrelation of detected signal

flipped = fliplr(detectedSignal);


%Find the autocorrelation function (signal convolved with it's time
%reversal)

autocor = conv(detectedSignal, flipped);

%plot autocorrelation function

figure(3);

plot(autocor);
xlabel sample
ylabel amplitude

%Autocorrelation of detected signal

flipped2 = fliplr(y);


%Find the autocorrelation function (signal convolved with it's time
%reversal)

autocor2 = conv(y, flipped2);

figure(4);

plot(autocor2);
xlabel sample
ylabel amplitude

%AWGN

snr = 2;

yAWGN = awgn(y,snr);

%Plot AWGN signal

figure(5);

plot(yAWGN);

xlabel sample
ylabel amplitude

%Autocorrelation of AWGN signal

flippedAWGN = fliplr(yAWGN);
autocorAWGN = conv(yAWGN, flippedAWGN);

%Plot autocorrelation of AWGN signal

figure(6);

plot(autocorAWGN);
xlabel sample
ylabel amplitude

