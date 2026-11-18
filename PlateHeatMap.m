%To Do: 

%Wrap all of this in a function with parameters for
%Signal, SNR, frame count and dimensions of plate

function animation = PlateHeatMap(signal, width, height, frames, N, impulse_row, impulse_column)

%How many frames in animation 

%frames = 80;

%Height of plate

%height = 400;

%Width of plate

%width = 400;

%Generate noise with time being frames long

noise = randn(height,width,frames);

%Generate x vector

x = 1:1:width;

%Generate y vector

y = transpose(1:1:height);

%Number of points in the simulation

%N = 500;

%Define an angles vector from 0 to 2pi

angleValues = linspace(0,2*pi*(1-1/N),N);

%Initial position of impulse

%impulse_row = 40;

%impulse_column = 40;

%Speed of propagation (arbitrary as of now, same value as 2D visual)

speed =2;

%signal = [-10,0,10,0,-10,0,10,0];

%For each sample in the signal then stagger by 1 iteration and then fill
%'working' matrix with how that component of the signal propagates
%Then add 'working' matrix to a cumulative result matrix to then display



result_matrix = zeros(height,width,frames);

for sample = 1:1:length(signal)

    %Set 'working' matrix to all zeros at the start of the loop

    working_matrix = zeros(height,width,frames);

    %Create vectors for data for wave components

    %Store the x and y position of each component

    acousticWave.xposition = linspace(impulse_column,impulse_column,N);

    acousticWave.yposition = linspace(impulse_row,impulse_row,N);

    %Also store the direction of these components, circular initialisation
    %as for unit circle mag(cos(angle) + jsin(angle)) = 1 

    acousticWave.xdirections = cos(angleValues);

    acousticWave.ydirections = sin(angleValues);

    %To Do: Implement a magnitude vector to make components of signal die
    %out over time

    acousticWave.magnitudes = ones(N);
    
    %If this component of the signal is 0 then move on to save computation
    %power

    if signal(sample) == 0

        %Jump to the next sample in the signal

        continue;

    end

%Iterate through every frame for the simulation

for frame = (1:1:frames)

    %Iterate through every generated wave component

    for component = (1:1:N)

        %To get the cell to place the value in round the component's
        %position values 

        row = round(acousticWave.yposition(component));
        column = round(acousticWave.xposition(component));

        %If the position is on the plate then set the value to 1 (value is
        %for test just now. If the indexing is outside the matrix
        %dimensions this will not run

        if (row < height) && (column < width) && (row > 0) && (column > 0)

            %Set the corresponding value equal to 1

            if (frame+sample) < frames

            working_matrix(row,column,frame+(sample-1)) = working_matrix(row,column,frame+(sample-1)) + signal(sample)*acousticWave.magnitudes(component);

            end
        end

        %If the height goes outwith the plate then reflect in the y
        %direction

        if (round(acousticWave.yposition(component)) >= height) || (round(acousticWave.yposition(component)) <= 0)

            acousticWave.ydirections(component) = -acousticWave.ydirections(component);

        end

        %If the width goes outwith the plate then reflect in the x
        %direction

        if (round(acousticWave.xposition(component)) >= width) || (round(acousticWave.xposition(component)) <= 0)

            acousticWave.xdirections(component) = -acousticWave.xdirections(component);

        end

        %Update the position of the component due to the direction, speed and current position

        acousticWave.yposition(component) = acousticWave.yposition(component) + speed*acousticWave.ydirections(component);
        acousticWave.xposition(component) = acousticWave.xposition(component) + speed*acousticWave.xdirections(component);

        %Only attenuate the signal if the magnitude of the signal is
        %non-zero

        if acousticWave.magnitudes(component) > 0

            %Subtract some amount from the magnitude to simulate
            %attenuation, could change this to a factor rather than a
            %subtraction and could change the variable to an input

            acousticWave.magnitudes(component) = acousticWave.magnitudes(component) - 0.01;
        
        end

    end

end

result_matrix = result_matrix + working_matrix;

end
%Smooth the matrix layers to prevent weird looking spikes

smoothed_matrix = zeros(height,width,frames);

%Iterate through each frame in the animation

for frame = 1:1:frames

    %Create a smoothed version of the matrix frames using imgaussfilt()

    smoothed_matrix(:,:,frame) = imgaussfilt(imgaussfilt(result_matrix(:,:,frame)));

end

%Create the combined signal and noise

AWGN_signal = noise+smoothed_matrix;

map = surf(x,y,AWGN_signal(:,:,1));

%Remove boundary colour

map.EdgeColor = "interp";


xlim([0 width]);
ylim([0 height]);
zlim([-frames frames]);

ylabel 'Y Axis'
xlabel 'X Axis'
zlabel 'Magnitude'
title("Acoustic Signal Animation")

colorbar

%Update plot and draw it to screen to make animation

for frame = 1:1:frames

    map.ZData = AWGN_signal(:,:,frame);
    drawnow;

end

animation = AWGN_signal;

end


%[appendix]{"version":"1.0"}
%---
