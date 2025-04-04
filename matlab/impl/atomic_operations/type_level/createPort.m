function newPortName = createPort(blockPath, portType, busObjectName)
    % Validate input arguments
    if nargin < 3
        error('You must provide the block path, port type (Inport or Outport), and the bus object name.');
    end
    
    % Check if the system containing the block is loaded
    if isempty(find_system('SearchDepth', 0, 'Name', bdroot(blockPath)))
        error('The specified block or its system is not loaded.');
    end
    
    % Check for valid port type
    if ~ismember(portType, {'Inport', 'Outport'})
        error('Port type must be either "Inport" or "Outport".');
    end
    
    % Validate bus object existence
%    if ~exist(busObjectName, 'var')
%        error('Bus object %s not found in the workspace.', busObjectName);
 %   end
    
    % Generate the new port block and assign bus object as its data type
    portHandles = get_param(blockPath, 'PortHandles');
    if strcmp(portType, 'Inport')
        newPortName = ['newIn', num2str(length(portHandles.Inport) + 1)];
        newPosition = [100, 200 + 40 * length(portHandles.Inport), 130, 220 + 40 * length(portHandles.Inport)];
        add_block('simulink/Sources/In1', [blockPath, '/', newPortName], 'Position', newPosition);
        
        % Set the data type of the input port to the bus object
        set_param([blockPath, '/', newPortName], 'OutDataTypeStr', ['Bus: ', busObjectName]);
        
    elseif strcmp(portType, 'Outport')
        newPortName = ['newOut', num2str(length(portHandles.Outport) + 1)];
        newPosition = [300, 200 + 40 * length(portHandles.Outport), 330, 220 + 40 * length(portHandles.Outport)];
        add_block('simulink/Sinks/Out1', [blockPath, '/', newPortName], 'Position', newPosition);
        
        % Set the data type of the output port to the bus object
        set_param([blockPath, '/', newPortName], 'OutDataTypeStr', ['Bus: ', busObjectName]);
    end
    
    disp(['Added ', portType, ' block named ', newPortName, ' to ', blockPath, ' configured with bus ', busObjectName]);
    
end