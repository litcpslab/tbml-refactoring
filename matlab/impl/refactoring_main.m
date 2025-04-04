
addpath('atomic_operations\instance_level\')
addpath('atomic_operations\type_level\')
addpath('atomic_operations\helper\')

system = load_system('assembly_line.slx');

library = load_system('testLib.slx');

set_param(library, 'Lock', 'off');

signals = showSignalSelectionDialog('assembly_line');

library_left_obj_path = 'testLib/PositionSensor'; % use the object on the left side of the signal
library_right_obj_path= 'testLib/MechatronicArm';


vars = load('MyBus.mat');
disp('Loaded variables from MyBus.mat:');
disp(fieldnames(vars));
busName = 'test';
busObj = createBusObject(signalSpecs, busName);
% Ensure the bus object is correctly loaded
if isfield(vars, busName)
    % Assign directly to the base workspace
    assignin('base', busName, vars.(busName));
else
    error('Bus object %s not loaded. Confirm the MAT-file contents.', busObjName);
end

% Check if it is correctly in the workspace
if evalin('base', ['exist(''', busObjName, ''', ''var'')']) == 0
    error('Bus object %s is still not found in the base workspace.', busObjName);
end
% Remove an inport or outport and get the connected signal

% getOutports from left , iterate over it



signals{end+1} = removePorts(library_left_obj_path);
signals{end+1} = removePorts(library_right_obj_path);

% Display the connected signals

%% Create Port with bus and selector
newPortName = createPort(library_left_obj_path, 'Inport','busObj');
createAndConnectBusSelector(library_left_obj_path,newPortName);
repair_instance_connections(assembly_line,signals,busName);


save_system(library);




