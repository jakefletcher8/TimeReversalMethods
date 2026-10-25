%Define dimensions of a room

length = 10;
width = 10;
height = 2;

%Create room dimensions array

room = [length,width,height];

%Define receiver positions

rx = [1,6,1];

rx2 = [1,1,1];

%Define transmitter position

tx = [6,6,1];

%Impulse responses from transmitter to receiver

irTR = acousticRoomResponse(room,tx,rx);

irRT = acousticRoomResponse(room,rx,tx);

%Time vectors

t = linspace(0,0.2,size(irTR,2));

t2 = linspace(0,0.2,size(irRT,2));

%Plot impulse response of the room for first position

subplot(2,1,1)

plot(t, irTR);

%Labels

xlabel 'Time (s)'
ylabel 'Magnitude'

title 'Impulse Response - Transmitter -> Receiver'

%Plot impulse response of the room for the second position

subplot(2,1,2)

plot(t2, irRT);

%Labels

xlabel 'Time (s)'
ylabel 'Magnitude'

title 'Impulse Response - Receiver -> Transmitter'

%Create signal

f = 1000;

y = (0.25*cos(2*pi*f*t) + 0.25*cos(4*pi*f*t) + 0.25*cos(8*pi*f*t) + 0.25*cos(16*pi*f*t)).*exp(-300*t);

%Length of signal

N = 1000;

y(N:end) = 0;

%Plot generated signal

figure(2)

plot(t(1:N), y(1:N));

xlabel 'Time (s)'
ylabel 'Magnitude'

title 'Actuator Signal'

%Send y signal down channel from tx to rx

y_rec = conv(irTR,y);

%Send the received signal (time reversed) back from rx to tx

y_time_reversed = fliplr(y_rec);

y_back = conv(irRT,y_time_reversed);

y_back = cat(2,y_back,y_back);

y_back = cat(2,y_back,y_back);

y_back = cat(2,y_back,y_back);

%Plot both of these signals to see what it is like

figure(3)

subplot(2,1,1)

t3 = linspace(0,0.2,size(y_rec,2));

plot(t3,y_rec);

xlabel 'Time (s)'
ylabel 'Magnitude'

title 'Signal at receiver'

subplot (2,1,2)

t4 = linspace(0,0.2,size(y_back,2));

plot(t4,y_back);

xlabel 'Time (s)'
ylabel 'Magnitude'

title 'Time reversed signal at Transmitter'