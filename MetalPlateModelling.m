%Model metal plate for impulse responses from positions to receiver

%Stephan said the imaging method only works for rectangular geometry, if
%given time and enough motivation investigate other shaped materials 

plateRows = 10;
plateColumns = 10;

%Create an empty matrix of positions

plate = zeros(plateRows,plateColumns);

%Place the receiver at some arbitrary position on the plate

receiverRow = 1;
receiverColumn = 1;

%Place the target at some arbitrary position on the plate

targetRow = 6;
targetColumn = 5;

%Set receiver position in matrix to R and target position to T

plate(receiverRow,receiverColumn) = -1;

plate(targetRow,targetColumn) = 1;

%Find absolute distance between target and receiver

distanceRow = receiverRow - targetRow;
distanceColumn = receiverColumn - targetColumn;

%Absolute distance

radius = sqrt(distanceRow^2 + distanceColumn^2);
