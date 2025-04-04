function repair_instance_connections(modelName, signalSpecs, busOutputPort)
% REPAIR_INSTANCE_CONNECTIONS
% Repairs all instances affected by a refactoring by inserting Bus Selectors
% at the receiving end of the new structured output port.

% INPUTS:
%   modelName        - Name of the Simulink model (e.g., 'assembly_line')
%   signalSpecs      - Cell array of signal names selected via showSignalSelectionDialog
%   busOutputPort    - Name of the new structured port (e.g., 'PositionBusOut')

load_system(modelName);
allBlocks = find_system(modelName, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'BlockType', 'SubSystem');

for i = 1:length(allBlocks)
    block = allBlocks{i};
    
    % Skip blocks that are not subsystems (i.e., not instances of a type)
    if isempty(get_param(block, 'TreatAsAtomicUnit')), continue; end
    
    % Check if block has input port with same name as the structured port
    inports = find_system(block, 'SearchDepth', 1, 'BlockType', 'Inport');
    matchedPort = false;
    
    for j = 1:length(inports)
        portName = get_param(inports{j}, 'Name');
        if strcmp(portName, busOutputPort)
            matchedPort = true;
            break;
        end
    end
    
    if matchedPort
        fprintf('Repairing instance: %s\n', block);
        
        % Insert Bus Selector and connect lines
        busSelectorName = [get_param(block, 'Name') '_BusSelector'];
        bs = add_block('simulink/Signal Routing/Bus Selector', ...
            [modelName '/' busSelectorName], ...
            'Position', [400 100+50*i 500 150+50*i]);

        % Set output signals
        set_param(bs, 'OutputSignals', strjoin(signalSpecs, ','));

        % Reconnect the Bus
        try
            add_line(modelName, ...
                [get_param(block, 'Name') '/' busOutputPort], ...
                [busSelectorName '/1'], ...
                'autorouting', 'on');
        catch
            warning('Failed to connect Bus line for %s', block);
        end

        % Connect outputs from BusSelector to corresponding ports
        for k = 1:length(signalSpecs)
            selectorPort = sprintf('%d', k);
            targetPort = signalSpecs{k};
            try
                add_line(modelName, ...
                    [busSelectorName '/' selectorPort], ...
                    [get_param(block, 'Name') '/' targetPort], ...
                    'autorouting', 'on');
            catch
                warning('Failed to reconnect %s to %s', selectorPort, targetPort);
            end
        end
    end
end

save_system(modelName);
disp(' Instance repair complete.');

end
