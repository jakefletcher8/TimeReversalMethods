%Model metal plate for impulse responses from positions to receiver

%Stephan said the imaging method only works for rectangular geometry, if
%given time and enough motivation investigate other shaped materials 

plate.rows = 10;
plate.columns = 10;

%Create an empty matrix of positions

plate = zeros(plate.rows,plate.columns);

%Place the receiver at some arbitrary position on the plate

receiver.row = 1;
receiver.column = 1;

%Place the target at some arbitrary position on the plate

target.row = 6;
target.column = 5;

%Set receiver position in matrix to R and target position to T

plate(receiver.row,receiver.column) = -1;

plate(target.row,target.column) = 1;

%Find absolute distance between target and receiver

distance.row = receiver.row - target.row;
distance.column = receiver.column - target.column;

%Absolute distance

radius = sqrt(distance.row^2 + distance.column^2);

%To do: 
%
%Create an attenuation function dependant on distance propagated
%along the metal plate.
%
%Put metal plate things into a custom struct/object and give it functions

