function createAndConnectBusSelector(subsystemPath, portName)
    % Validate if the subsystem path is provided
    if nargin < 2
        error('You must provide the subsystem path and the port name.');
    end

    % Check if the system containing the block is loaded
    if isempty(find_system('SearchDepth', 0, 'Name', bdroot(subsystemPath)))
        error('The specified subsystem or its system is not loaded.');
    end

    % Generate the Bus Selector block within the subsystem
    busSelectorName = [subsystemPath, strcat('/BusSelector',portName)];
    add_block('simulink/Signal Routing/Bus Selector', busSelectorName);

    % Get handles for the port and the bus selector
    portHandles = get_param([subsystemPath, '/', portName], 'PortHandles');
    busSelectorHandles = get_param(busSelectorName, 'PortHandles');

    % Set position of Bus Selector, adjusting if needed based on your model
    set_param(busSelectorName, 'Position', [200, 200, 230, 250]);

    % Make the connection from the port to the Bus Selector
    add_line(subsystemPath, portHandles.Outport, busSelectorHandles.Inport, 'autorouting', 'on');

    disp(['Added Bus Selector connected to port ', portName, ' in ', subsystemPath]);
end