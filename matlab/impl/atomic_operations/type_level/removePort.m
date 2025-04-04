function connectedSignals = removePort(blockPath, portNumber)
    % Validate input
    if nargin < 2
        error('You must provide both the block path and the port number to remove.');
    end
    
    % Check if the system containing the block is loaded
    if isempty(find_system('SearchDepth', 0, 'Name', bdroot(blockPath)))
        error('The specified block or its system is not loaded.');
    end

    % Initialize output
    connectedSignals = {};

    try
        % Get port handles
        portHandles = get_param(blockPath, 'PortHandles');
        
        if portNumber <= length(portHandles.Inport)
            % It's an inport
            inportBlocks = find_system(blockPath, 'SearchDepth', 1, 'BlockType', 'Inport');
            if numel(inportBlocks) >= portNumber
                inportBlock = inportBlocks{portNumber};

                % Find internal line connected to this Inport
                portHandle = get_param(inportBlock, 'PortHandles');
                internalLine = get_param(portHandle.Outport, 'Line');
                if internalLine ~= -1
                    % Extract internal signal info
                    connectedSignals = extractSignalInfo(internalLine);
                end

                % Remove only the Inport block (leave the signal intact)
                delete_block(inportBlock);
            end
        elseif portNumber <= (length(portHandles.Inport) + length(portHandles.Outport))
            % It's an outport
            portNumber = portNumber - length(portHandles.Inport);
            outportBlocks = find_system(blockPath, 'SearchDepth', 1, 'BlockType', 'Outport');
            if numel(outportBlocks) >= portNumber
                outportBlock = outportBlocks{portNumber};

                % Find internal line connected to this Outport
                portHandle = get_param(outportBlock, 'PortHandles');
                internalLine = get_param(portHandle.Inport, 'Line');
                if internalLine ~= -1
                    % Extract internal signal info
                    connectedSignals = extractSignalInfo(internalLine);
                end

                % Remove only the Outport block (leave the signal intact)
                delete_block(outportBlock);
            end
        else
            error('Port number exceeds the available ports in the subsystem.');
        end
    catch ME
        disp('Error occurred while handling subsystem ports:');
        disp(ME.message);
    end
end

function signalInfo = extractSignalInfo(line)
    % Extract signal name or connected block/port information
    signalInfo = get_param(line, 'Name');
    if isempty(signalInfo)
        % Signal name not found, try to get connected blocks and ports
        dstBlocks = get_param(line, 'DstBlockHandle');
        srcBlock = get_param(line, 'SrcBlockHandle');
        
        signalInfo = {};
        
        if srcBlock ~= -1
            srcBlockName = get_param(srcBlock, 'Name');
            signalInfo{end+1} = ['Source: ', srcBlockName];
        end
        
        if ~isempty(dstBlocks)
            for i = 1:length(dstBlocks)
                dstBlockName = get_param(dstBlocks(i), 'Name');
                signalInfo{end+1} = ['Destination: ', dstBlockName];
            end
        end
        
        if isempty(signalInfo)
            signalInfo = {'[Unnamed Signal]'};
        end
    else
        % Wrap the signal name in a cell array for consistency
        signalInfo = {signalInfo};
    end
end