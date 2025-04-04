function busObj = createBusObject(signalSpecs, busName)
    % Validate inputs
    if ~isstruct(signalSpecs) || isempty(signalSpecs)
        error('signalSpecs must be a non-empty array of structures.');
    end
    
    % Initialize the array of BusElements
    numSignals = length(signalSpecs);
    elems(numSignals) = Simulink.BusElement;  % Preallocate the array
    
    % Loop through the signal specifications to create bus elements
    for i = 1:numSignals
        if ~isfield(signalSpecs(i), 'Name') || ~isfield(signalSpecs(i), 'DataType')
            error('Each signal specification must have Name and DataType fields.');
        end
        
        elems(i) = Simulink.BusElement;
        elems(i).Name = signalSpecs(i).Name;
        elems(i).Dimensions = 1;             % Default to scalar. Modify as needed
        elems(i).DataType = signalSpecs(i).DataType;
    end
    
    % Create the Bus object
    busObj = Simulink.Bus;
    busObj.Elements = elems;
    busObj.Description = ['Bus object for ', busName];
    
    % Optional: Assign the bus object to a base workspace variable
    assignin('base', busName, busObj);
    
    % Save the Bus object into a MAT file
    save([busName, '.mat'], 'busObj');
end