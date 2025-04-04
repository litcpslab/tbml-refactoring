function showSignalSelectionDialog(modelName)
    % Load the Simulink model if not already loaded
    if ~bdIsLoaded(modelName)
        load_system(modelName);
    end

    % Find all lines (signals) in the model
    allLines = find_system(modelName, 'FindAll', 'on', 'Type', 'line');

    % Extract source and destination block names
    uniqueConnections = containers.Map; % To store unique (source -> destination) connections
    for i = 1:length(allLines)
        srcBlockHandle = get_param(allLines(i), 'SrcBlockHandle');
        dstBlockHandles = get_param(allLines(i), 'DstBlockHandle');
        srcBlock = get_param(srcBlockHandle, 'Name');
        for j = 1:length(dstBlockHandles)
            dstBlock = get_param(dstBlockHandles(j), 'Name');
            connectionKey = sprintf('%s -> %s', srcBlock, dstBlock);
            if ~isKey(uniqueConnections, connectionKey)
                uniqueConnections(connectionKey) = 1; % Mark as unique connection
            end
        end
    end

    % Extract unique connection keys as display names
    connectionNames = keys(uniqueConnections);

    % Create a popup dialog
    dlg = dialog('Name', 'Select Signal', 'Position', [300, 300, 400, 400]);

    % Add radio buttons
    radioButtonGroup = uibuttongroup('Parent', dlg, ...
                                     'Position', [0.05, 0.15, 0.9, 0.75], ...
                                     'Title', 'Select a Signal');
    buttonHeight = 30;
    panelHeight = max(200, length(connectionNames) * buttonHeight);

    for i = 1:length(connectionNames)
        uicontrol(radioButtonGroup, 'Style', 'radiobutton', ...
                  'String', connectionNames{i}, ...
                  'Position', [10, panelHeight - i * buttonHeight, 380, buttonHeight], ...
                  'HorizontalAlignment', 'left');
    end

    % Add an OK button
    uicontrol(dlg, 'Style', 'pushbutton', ...
        'String', 'OK', ...
        'Position', [150, 20, 100, 30], ...
        'Callback', @(btn, event) onOK(dlg, radioButtonGroup));

    % Keep dialog open
    uiwait(dlg);
end

function onOK(dlg, radioButtonGroup)
    % Get the selected button
    selectedButton = radioButtonGroup.SelectedObject;
    if isempty(selectedButton)
        disp('No signal selected.');
    else
        disp('Selected Connection:');
        disp(selectedButton.String);
    end

    % Close the dialog
    delete(dlg);
end