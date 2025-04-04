function old_remove_port(blockPath, portNumber)
    % Validate input
    if nargin < 2
        error('You must provide both the block path and the port number to remove.');
    end
    
    % Check if the system containing the block is loaded
    if isempty(find_system('SearchDepth', 0, 'Name', bdroot(blockPath)))
        error('The specified block or its system is not loaded.');
    end
    
    % Assumes the subsystem manages inports and outports internally
    try
        % Handle Inports and Outports within the subsystem
        portHandles = get_param(blockPath, 'PortHandles');
        
        % Depending on input/output focus, remove correct port handle
        if portNumber <= length(portHandles.Inport)
            % It's an inport
            portHandle = portHandles.Inport(portNumber);
            
            % Break the line and adjust the subsystem's logic
            if portHandle ~= -1
                line = get_param(portHandle, 'Line');
                if line ~= -1
                    delete_line(line);
                end
                % Possibly remove the Inport block inside subsystem here
                inportBlocks = find_system(blockPath, 'SearchDepth', 1, 'BlockType', 'Inport');
                if numel(inportBlocks) >= portNumber
                    delete_block(inportBlocks{portNumber});
                end
            end
        elseif portNumber <= (length(portHandles.Inport) + length(portHandles.Outport))
            % It's an outport
            portNumber = portNumber - length(portHandles.Inport);
            portHandle = portHandles.Outport(portNumber);
            
            if portHandle ~= -1
                line = get_param(portHandle, 'Line');
                if line ~= -1
                    delete_line(line);
                end
                % Possibly remove the Outport block inside subsystem here
                outportBlocks = find_system(blockPath, 'SearchDepth', 1, 'BlockType', 'Outport');
                if numel(outportBlocks) >= portNumber
                    delete_block(outportBlocks{portNumber});
                end
            end
        else
            error('Port number exceeds the available ports in the subsystem.');
        end
    catch ME
        disp('Error occurred while handling subsystem ports:');
        disp(ME.message);
    end
end