% JakeExample1.m

% matrix of impulse responses --- each row one impulse response
randn('seed',0);
N = 1000;
H = randn(10,N);

% isolate target
h = H(5,:);

% time reversal
x_tr = fliplr(h);

% send out time reversed sequence
Y = zeros(10,2*N-1);
for k = 1:10,
Y(k,:) = conv(H(k,:),x_tr);
end;

% look at impulse responses and received signals
figure(1); plot(H');
figure(2); plot(Y');