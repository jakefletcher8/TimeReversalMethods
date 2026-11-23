function detected_signal = EnergyDetector(input, energyThreshold, windowSize) 

%Create time vector for signal

t = 1:1:length(input);

%Initialise energy vector for signal

energy_y = zeros(1,length(t));

%Create vector for samples recorded by the energy detector

detected_signal = [0];

%Detect energy of a signal given the window size and chosen signal

for frame = (1:1:length(t) - windowSize)

    energy_y(frame) = sum((input(frame:frame+windowSize)).^2);

    %If the energy within the window is above the threshold

    if energy_y(frame) > energyThreshold

        %Record the sample and store it in the detected_signal vector

        detected_signal = [detected_signal, input(frame)];

    end

end

%Animate the energy plot of the signal over time

energy_plot = plot(t,energy_y);
xlabel 'Time (s)'
ylabel 'Energy'
title 'Energy Detector'

energy_y = zeros(1,length(t));

for frame = (1:1:length(t) - windowSize)

    %Update y values with energy of signal in window

    energy_y(frame) = sum((input(frame:frame+windowSize)).^2);

    %Set the new data for the plot

    energy_plot.YData = energy_y;

    %If energy crosses a certain threshold then change the color of the plo
    %to red

    if energy_y(frame) > energyThreshold
        energy_plot.Color = 'r';

    else
        energy_plot.Color = 'g';
    end

    %Draw the new data on the plot

    drawnow
end

%[appendix]{"version":"1.0"}
%---
