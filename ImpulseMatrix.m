%Function that creates a 3 dimension matrix containing the impulse
%responses from a receiver to every other point on the plate

%Inputs include, plate dimensions, receiver position

function result = ImpulseMatrix(plateWidth,plateHeight,plateDepth,receiverRow, receiverColumn, sampleRate)

%Initialise a matrix of zeros for each row and column in the plate

result = zeros(plateHeight,plateWidth,sampleRate*2);

%Create a plate object using the given parameters

plate = [plateWidth,plateHeight,plateDepth];

%Iterate through every transmitter position and generate an impulse
%response to the receiver

for row = 1:1:plateHeight
    for column = 1:1:plateWidth
        
        response = acousticRoomResponse(plate,[column,row,plateDepth],[receiverColumn,receiverRow,plateDepth],SampleRate=sampleRate);

        for sample = 1:1:sampleRate*2
        %Store the result of the impulse response from a point into the
        %corresponding cell in the matrix, assume impulses occur on the
        %surface of the plate and use the provided sample rate
            
        %If the sample indexing exceeds the length of the response then go
        %to the next cell using a break statement

        if sample > length(response)
            break;
        end

        %If another sample is read then store it to the result

        result(row,column,sample) = response(sample);
        end
    end
end

%[appendix]{"version":"1.0"}
%---
